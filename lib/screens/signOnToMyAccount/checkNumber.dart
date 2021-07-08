import 'dart:convert';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:skywamanager/screens/signOnToMyAccount/widget/MyButton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'OtpPage.dart';

class CheckNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckApp(),
    );
  }
}

class CheckApp extends StatefulWidget {
  @override
  _CheckAppState createState() => _CheckAppState();
}

class _CheckAppState extends State<CheckApp> {
  final controller = TextEditingController();
  bool enabled = false, enabledField = true;
  String uuid;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Image.asset('assets/images/undraw_authentication_fsn5.png'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "VERIFICATION",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "We will verify if this number exist in our storage",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        "Enter Mobile Number",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextField(
                          enabled: enabledField,
                          onChanged: (val) {
                            if (val.length == 0) {
                              setState(() {
                                enabled = false;
                              });
                            } else {
                              setState(() {
                                enabled = true;
                              });
                            }
                          },
                          controller: controller,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xFFDDDDDD),
                        width: 220,
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: MyButton(
                          enabled: enabled,
                          onPressed: () {
                            getResponse(
                              mail: '',
                              phone: controller.text,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: top,
          ),
        ],
      ),
    );
  }

  void getResponse({mail, phone}) async {

    setState(() {
      enabledField = false;
      enabled = false;
      top = fadingCircle;
    });

    mail = 'utsavmishra1411@gmail.com';
    Uri uri = Uri.parse('https://skyva-app.herokuapp.com/user/sendotp');

    var params = {"email": mail, "phoneNo": phone, "countryCode": "91"};

    String body = json.encode(params);

    var response = await http.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OtpPage(mail, phone);
          },
        ),
      );
    }
    print(response.body);
    setState(() {
      enabledField = true;
      enabled = true;
      top = null;
    });
  }
}
