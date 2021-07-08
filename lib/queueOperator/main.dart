import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:skywamanager/screens/queueOperator/CreateNewUser.dart';
import 'package:skywamanager/screens/queueOperator/widget/UserData.dart';
import 'package:skywamanager/screens/queueOperator/widget/userList.dart';

import 'ShowUser.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp2(),
    ));

class MyApp2 extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<MyApp2> {
  static List<String> nameList = [];
  static List<String> roleList = [];
  static List repo = [];
  List requestedRepo = [];
  Widget permanentBadge, permanentIcon;
  int badgeContent = 0;

  var name;
  var role;
  var pic;
  Color shimmerColor = Colors.white;
  List<Widget> realList = [];

  @override
  void initState() {
    super.initState();
    getShimmer();
    print("init called");
    getResponse();
  }

  Widget appbarSearchText =
      Text("Users", style: TextStyle(color: Colors.black));
  Icon searchOrCancel = Icon(
    Icons.search,
    color: Colors.black,
  );
  TextEditingController controllerAuto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    permanentIcon = Icon(
      Icons.person_add,
      color: Colors.black,
    );
    permanentBadge = Badge(
      badgeContent: Text(badgeContent.toString()),
      child: Icon(Icons.person_add, color: Colors.black),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 10,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0, right: 20.0),
          child: appbarSearchText,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 20.0),
            child: IconButton(
              onPressed: () {
                setState(
                  () {
                    if (searchOrCancel.icon == Icons.search) {
                      appbarSearchText = SizedBox(
                        height: 40,
                        child: Center(
                          child: TypeAheadFormField<String>(
                            suggestionsCallback: UserData.getSuggestions,
                            itemBuilder: (context, String suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (String suggestion) {
                              controllerAuto.text = suggestion;
                              setState(() {
                                nameList = UserData.getSuggestions(suggestion);
                                getChildren();
                              });
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: controllerAuto,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Queue",
                              ),
                            ),
                          ),
                        ),
                      );
                      searchOrCancel = Icon(
                        Icons.cancel,
                        color: Colors.black,
                      );
                    } else {
                      nameList = UserData.users;
                      UserData.tempRepo = UserData.repos;
                      getChildren();
                      searchOrCancel = Icon(
                        Icons.search,
                        color: Colors.black,
                      );
                      appbarSearchText = Text(
                        "Users",
                        style: TextStyle(color: Colors.black),
                      );
                    }
                  },
                );
              },
              icon: searchOrCancel,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final value = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreateNewUser(
                      repos: requestedRepo,
                    );
                  },
                ),
              );
              if (value != null) {
                getShimmer();
                getResponse();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: badgeContent > 0 ? permanentBadge : permanentIcon,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // MyHead(),
            Expanded(
              child: ListView(
                children: realList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getChildren() {
    requestedRepo = [];
    List<Widget> userModule = [];
    for (dynamic i in UserData.tempRepo) {
      if (i['AuthorizationStatus'] != 'accessRequested') {
        Color color = Colors.green;
        if (i['AuthorizationStatus'] != 'authorized') {
          color = Colors.orange;
        }
        Widget row = UserRow(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ShowUser(
                    repo: i,
                    pic: pic,
                  );
                },
              ),
            );
          },
          colour: color,
          role: i['UserType'],
          userName: i['UserName'],
          statusColor: color,
          authorization: i['AuthorizationStatus'],
        );
        userModule.add(row);
      } else {
        requestedRepo.add(i);
      }
    }
    setState(() {
      final requestCount = requestedRepo.length;
      badgeContent = requestCount;
      realList = userModule;
    });
  }

  void getResponse() async {
    Uri uri = Uri.parse(
        'https://shoeboxtx.veloxe.com:36251/api/getLocationAdmins?UserToken=EAB8D7A5-D1AC-40AE-ACE5-2F41CEACAC2B644170606&LocationID=C29CDF52-7D14-4155-AADD-C35682B62906');
    http.Response response = await http.get(uri);
    List list = jsonDecode(response.body);
    nameList = [];
    roleList = [];
    for (var i in list) {
      final name = i['UserName'];
      final type = i['UserType'];
      nameList.add(name);
      roleList.add(type);
      repo.add(i);
    }
    UserData.users = nameList;
    UserData.repos = list;
    UserData.tempRepo = list;
    print(nameList);
    getChildren();
  }

  void getShimmer() {
    List<Widget> shimmers = [];
    for (int i = 0; i < 7; i++) {
      Widget listObj = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Shimmer.fromColors(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  baseColor: shimmerColor,
                  highlightColor: Colors.grey,
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 100,
                      child: Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        baseColor: shimmerColor,
                        highlightColor: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 10,
                      width: 200,
                      child: Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        baseColor: shimmerColor,
                        highlightColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      shimmers.add(listObj);
    }
    setState(() {
      realList = shimmers;
    });
  }
}
