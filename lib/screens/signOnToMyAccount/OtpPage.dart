import 'dart:convert';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:skywamanager/screens/homeScreen.dart';
import 'package:skywamanager/screens/newUser.dart';
import 'package:skywamanager/screens/signOnToMyAccount/widget/MyButton.dart';

class OtpPage extends StatefulWidget {
  final otpController = TextEditingController();

  final mail;
  final phone;

  OtpPage(this.mail, this.phone);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();
  bool enabled = false, enabledField = true;

  var mailId;
  var phoneNumber;

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
  String uuid;
  bool enabledCancelButton = true;
  bool enabledRequestButton = false;

  @override
  void initState() {
    this.mailId = widget.mail;
    this.phoneNumber = widget.phone;
    super.initState();
    getDeviceDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("assets/images/otp_background.png"),
                      SizedBox(height: 20),
                      Text(
                        "VERIFY OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 20),
                      PinCodeTextField(
                        enabled: enabledField,
                        controller: otpController,
                        onChanged: (String value) {
                          if (value.length == 6) {
                            print(value);
                            setState(() {
                              enabled = true;
                            });
                          } else {
                            setState(() {
                              enabled = false;
                            });
                          }
                        },
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        length: 6,
                        appContext: context,
                      ),
                      SizedBox(height: 20),
                      MyButton(
                        enabled: enabled,
                        onPressed: () {
                          final otp = otpController.text;
                          if (otp.length == 6) {
                            verifyOtp(otp, context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: top,
          ),
        ],
      ),
    );
  }

  Future<http.Response> searchNumber() async {
    // final uri = Uri.parse(
    //     'https://shoeboxtx.veloxe.com:36251/api/getUserInfo?UserToken=temp$uuid&VersionNumber=1.20.23');
    final uri = Uri.parse('https://shoeboxtx.veloxe.com:36251/api/getUserInfo?PhoneNumber=+91$phoneNumber');
    http.Response response = await http.get(uri);
    setState(() {
      enabledField = true;
      enabled = true;
      top = null;
    });
    return response;
  }

  void getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        uuid = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        uuid = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    print(uuid);
  }

  void verifyOtp(otp, context) async {
    String text = '';
    setState(() {
      enabledField = false;
      top = fadingCircle;
      enabled = false;
    });
    Uri uri = Uri.parse("https://skyva-app.herokuapp.com/user/verifyotp");
    final params = {
      "email": mailId,
      "phoneNo": phoneNumber,
      "countryCode": 91,
      "otp": otp
    };
    http.Response response = await http.post(
      uri,
      body: json.encode(params),
      headers: {"Content-Type": "application/json"},
    );
    // print(response.body);
    // print(response.statusCode);

    //TODO: Once server issue is fixed remove approval for status code 500.
    if (response.statusCode == 200 || response.statusCode == 500) {
      http.Response response = await searchNumber();
      var body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        String email = body['Email'];
        String phone = body['PhoneNumber'];
        String locationId = body['AuthorizedLocationID'];
        String userType = body['UserType'];
        String deviceId = body['DeviceID'];
        String userName = body['UserName'];
        print('locationID = $locationId');

        //TODO: add check Authentication status in if condition after completion of workflow
        if (locationId == 'notSet') {
          showDialog(
            context: context,
            builder: (ctx) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text("You are not invited"),
                content: Container(
                  child: TextField(
                    onChanged: (val) {
                      text = val;
                      if (text.length == 0) {
                        setState(() {
                          enabledRequestButton = false;
                        });
                      } else {
                        setState(() {
                          enabledRequestButton = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter LocationID to request access",
                      hintStyle: TextStyle(
                        fontSize: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: enabledCancelButton
                        ? () {
                            Navigator.of(ctx).pop();
                          }
                        : null,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: enabledCancelButton ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: enabledRequestButton
                        ? () {
                            setState(() {
                              top = fadingCircle;
                              enabledRequestButton = false;
                              enabledCancelButton = false;
                            });

                            updateUserPost(
                              email: email,
                              phone: phone,
                              locationId: text,
                              authStatus: 'accessRequested',
                              userType: userType,
                              deviceId: uuid,
                              userName: userName,
                            );
                          }
                        : null,
                    child: Text(
                      "Request access",
                      style: TextStyle(
                        color: enabledRequestButton ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        } else {
          updateUserPost(
              email: email,
              phone: phone,
              locationId: locationId,
              authStatus: 'authorized',
              userType: userType,
              deviceId: deviceId,
              userName: userName);
        }
      }
    }
  }

  void updateUserPost(
      {email,
      phone,
      locationId,
      authStatus,
      userType,
      deviceId,
      userName}) async {
    Uri uri =
        Uri.parse('https://shoeboxtx.veloxe.com:36251/api/UpdateUserPost');

    var params = {
      'Email': 'utsavmishra@gmail.com',
      'PhoneNumber': '+91$phoneNumber',
      'AuthorizedLocationID': 'C29CDF52-7D14-4155-AADD-C35682B62906',
      'AuthorizationStatus': authStatus,
      'UserType': userType,
      'DeviceID': deviceId,
      'UserName': userName
    };

    String body = json.encode(params);

    var response = await http.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ), (Route<dynamic> route) => route is NewUserScreen);
    }
    setState(() {
      top = null;
      enabledRequestButton = true;
      enabledCancelButton = true;
    });
  }
}
