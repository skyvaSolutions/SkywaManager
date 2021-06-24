import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywamanager/Global&Constants/UserSettingsConstants.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:skywamanager/Providers/ThemeProvider.dart';
import 'package:skywamanager/screens/homeScreen.dart';
import 'package:skywamanager/screens/newUser.dart';
import 'package:skywamanager/services/deviceInfoService.dart';
import 'package:skywamanager/services/localStorage.dart';
import 'package:skywamanager/services/locationServices.dart' as Location2;
import 'package:skywamanager/services/qAPIServices.dart';
import 'package:skywamanager/services/userServices.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splashScreen';
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final p = Provider.of<ThemeProvider>(context, listen: false);
      p.checkMode();
    });

    initAll();
  }

  @override
  Widget build(BuildContext context) {
    getDeviceInfo(context);
    return Scaffold(
      body: Center(
        child: Text('Put Some Cool Splash Screen Here'),
      ),
    );
  }

  String messageTitle = "Empty";
  String notificationAlert = "alert";

  FirebaseMessaging _messaging;

  void initAll() async {
    const locationErrorSnackBar = SnackBar(
      //  backgroundColor: (Colors.blue),
      content: Text('Location Services disabled using default location, '),
      duration: const Duration(milliseconds: 3000),
    );
    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: "your base url",
          receiveDataWhenStatusError: true,
          connectTimeout: 30 * 1000, // 30 seconds
          receiveTimeout: 30 * 1000 // 30 seconds
          );

      dio = new Dio(options);
    }
    await getProfileData();
    print("Did I return");

    Location2.Location location = Location2.Location();

    // Just for test purposes
    var response = await Dio().get("https://randomuser.me/api/?results=25");
    for (int i = 0; i < response.data["results"].length; i++) {
      nearbyQs.add(userModel.fromJson(response.data["results"][i]));
    }
    // End test
    if (await location.getCurrentLocation()) {
      print("returned from location");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(locationErrorSnackBar);
    }
    UserService userService = UserService();
    await userService.getUserInfoFromServer();

    if (userInfo.phoneNumber == "notSet") {
      Navigator.pushReplacementNamed(context, NewUserScreen.id);
    } else {
      print("User " + userInfo.phoneNumber);
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
  }
}

Future<void> getProfileData() async {
  print("Getting profile Data");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userSettings.deviceID.value = await readDeviceIDFromLocal(prefs);
  userSettings.retiredRelease.value =
      readBoolFromLocal(prefs, userSettings.retiredRelease.key, false);
  userSettings.userSetting1.value =
      readBoolFromLocal(prefs, userSettings.userSetting1.key, false);
  userSettings.numUsages.value = updateNumberOfUsages(prefs);
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    dataBody,
  });
  String title;
  String body;
}
