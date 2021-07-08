import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skywamanager/screens/queueOperator/widget/ExpandListView.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class CreateNewUser extends StatefulWidget {
  final repos;

  CreateNewUser({@required this.repos});

  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  var fadingCircle = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey,
        ),
      );
    },
  );
  var top;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String dropDownValue = 'Queue Operator';

  bool noMail = false, noName = false, noPhone = false, enabled = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Workroom',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: getExpands(),
            ),
          ],
        ),
      ),
    );
  }

  List<String> dropDownValuesList = [];
  bool createValues = true;

  List<ExpandListView> getExpands() {
    int count = 0;
    List<ExpandListView> expands = [];
    final repos = widget.repos;
    expands.add(initialItem());
    for (var repo in repos) {
      final c = count;
      if (createValues) {
        dropDownValuesList.add('Queue Operator');
      }
      final myExpand = ExpandListView(
        leading: Icon(Icons.person),
        title: Text('${repo['UserName']}'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Phone: ${repo['PhoneNumber']}'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Mail: ${repo['Email']}'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        items: <String>['admin', 'Queue Operator']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          setState(() {
                            dropDownValuesList[c] = _;
                          });
                        },
                        value: dropDownValuesList[c],
                      ),
                      TextButton(
                        onPressed: enabled
                            ? () {
                                updateUserPost(
                                  email: repo['Email'],
                                  userName: repo['UserName'],
                                  locationId: repo['AuthorizedLocationID'],
                                  userType: dropDownValuesList[c],
                                  deviceId: repo['DeviceID'],
                                  phone: repo['PhoneNumber'],
                                  authStatus: 'authorized',
                                );
                              }
                            : null,
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: enabled ? Colors.teal : Colors.grey,
                          ),
                          child: Center(
                            child: Text(
                              'APPROVE',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      expands.add(myExpand);
      count++;
    }
    createValues = false;
    return expands;
  }

  ExpandListView initialItem() {
    final creteItemExpand = ExpandListView(
      collapsedColor: Color(0xFF8FFFFF),
      leading: Icon(Icons.add),
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                TextFieldWidget(
                  enabled: enabled,
                  controller: controllers[0],
                  onChanged: (value) {
                    setState(() {
                      noMail = false;
                    });
                  },
                  showError: noMail,
                  label: 'Email',
                ),
                TextFieldWidget(
                  enabled: enabled,
                  controller: controllers[1],
                  onChanged: (value) {
                    setState(() {
                      noName = false;
                    });
                  },
                  showError: noName,
                  label: 'Name',
                ),
                TextFieldWidget(
                  enabled: enabled,
                  controller: controllers[2],
                  onChanged: (value) {
                    setState(() {
                      noPhone = false;
                    });
                  },
                  showError: noPhone,
                  label: 'Phone Number',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        items: <String>['admin', 'Queue Operator']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          setState(() {
                            dropDownValue = _;
                          });
                        },
                        value: dropDownValue,
                      ),
                      TextButton(
                        onPressed: enabled
                            ? () {
                                if (isOkay()) {
                                  updateUserPost(
                                    email: controllers[0].text,
                                    userName: controllers[1].text,
                                    locationId:
                                        "C29CDF52-7D14-4155-AADD-C35682B62906",
                                    userType: dropDownValue,
                                    deviceId: "temp${controllers[2].text}",
                                    phone: '+91${controllers[2].text}',
                                    authStatus: 'pendingAcceptance',
                                  );
                                }
                              }
                            : null,
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: enabled ? Colors.teal : Colors.grey,
                          ),
                          child: Center(
                            child: Text(
                              'ADD',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: top,
            ),
          ],
        )
      ],
      title: Text(
        'Add Someone',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
      ),
    );
    return creteItemExpand;
  }

  void updateUserPost({
    email,
    phone,
    locationId,
    authStatus,
    userType,
    deviceId,
    userName,
  }) async {
    setState(() {
      top = fadingCircle;
      enabled = false;
    });
    Uri uri =
        Uri.parse('https://shoeboxtx.veloxe.com:36251/api/UpdateUserPost');

    var params = {
      'Email': email,
      'PhoneNumber': phone,
      'AuthorizedLocationID': locationId,
      'AuthorizationStatus': authStatus,
      'UserType': userType,
      'DeviceID': deviceId,
      'UserName': userName,
    };

    String body = json.encode(params);

    var response = await http.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    Navigator.pop(context, 1);
    setState(() {
      top = null;
      enabled = false;
    });
  }

  bool isOkay() {
    bool textsThere = true;
    if (controllers[0].text.isEmpty) {
      textsThere = false;
      setState(() {
        noMail = true;
      });
    } else if (controllers[1].text.isEmpty) {
      textsThere = false;
      setState(() {
        noName = true;
      });
    } else if (controllers[2].text.isEmpty) {
      textsThere = false;
      setState(() {
        noPhone = true;
      });
    }
    return textsThere;
  }
}

class TextFieldWidget extends StatelessWidget {
  final controller;
  final label;
  final showError;
  final onChanged;
  final enabled;

  TextFieldWidget({
    this.controller,
    this.label,
    @required this.showError,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: enabled,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: label,
          errorText: showError ? "Mandatory Field" : null,
        ),
      ),
    );
  }
}
