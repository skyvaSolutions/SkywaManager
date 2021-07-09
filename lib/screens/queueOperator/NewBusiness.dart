import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:skywamanager/screens/operateScreen.dart';

void main() => runApp(NewBusiness());

class NewBusiness extends StatefulWidget {
  @override
  _NewBusinessState createState() => _NewBusinessState();
}

class _NewBusinessState extends State<NewBusiness> {
  final phoneCon = TextEditingController();
  final businessNameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('My Business'),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Image.asset('assets/images/undraw_Upload_image_re_svxx.png'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: businessNameCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.business),
                    labelText: 'Business Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final uuid = await getDeviceUuid();
                  print(uuid);
                  createBusiness(
                    locationId: 'tlid$uuid',
                    businessName: businessNameCon.text,
                    managerUserId: uuid,
                    phoneNumber: phoneCon.text,
                    qId: 'tqid$uuid',
                  );
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      'CREATE BUSINESS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getDeviceUuid() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    String uuid;
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
    return uuid;
  }

  void createBusiness(
      {businessName,
      locationId,
      phoneNumber,
      qId,
      managerUserId,
      qMode}) async {
    Uri uri = Uri.parse('https://shoeboxtx.veloxe.com:36251/api/qMetaDataPost');
    final params = {
      'locationName': businessName,
      'locationID': locationId,
      'phoneNumber': '+91$phoneNumber',
      'qID': qId,
      'qManagerUserID': managerUserId,
    };
    String body = json.encode(params);
    http.Response response = await http
        .post(uri, body: body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OperateScreen();
          },
        ),
      );
    }
  }
}
