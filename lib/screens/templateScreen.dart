import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:skywamanager/components/businessWidget.dart';
import 'package:skywamanager/screens/searchPage.dart';
import 'package:skywamanager/screens/splashScreen.dart';
import 'package:skywamanager/services/deviceConnection.dart';
import 'package:skywamanager/utils/Network_aware.dart';
import 'package:skywamanager/components/tileWidgets.dart';

class TemplateScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  StreamSubscription _connectionChangeStream;
  int _totalNotifications = 0;
  PushNotification _notificationInfo;
  @override
  void initState() {
    super.initState();
  }

  @override
  final List<String> names = <String>[
    'Aby',
    'Aish',
    'Ayan',
    'Ben',
    'Bob',
    'Charlie',
    'Cook',
    'Carline'
  ];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Welcome"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchPage.id);
                },
                icon: Icon(Icons.search))
          ],
//        leading: IconButton(
//          icon: Icon(Icons.help),
//          onPressed: () => Navigator.pushNamed(context, HelpScreen.id),
//        ),
          //   backgroundColor: kAppBarColor,
        ),
        drawer: AppDrawer(),
        body: StreamProvider<NetworkStatus>(
          initialData: NetworkStatus.Online,
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
          child: NetworkAwareWidget(
            onlineChild: ListView(children: [
              for (int i = 0; i < nearbyQs.length; i++)
                BusinessWidget(
                    name: nearbyQs[i].name.first,
                    address: nearbyQs[i].location.city +
                        "," +
                        nearbyQs[i].location.state),
            ]),
          ),
        ));
  }

}
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createHeader(),
          createDrawerItem(
            icon: Icons.account_box,
            text: 'Update Profile',
         //   onTap: () => Navigator.pushNamed(context, ProfileEditPage.id),
          ),
          createDrawerItem(
            icon: Icons.help,
            text: 'Help',
        //    onTap: () => Navigator.pushNamed(context, HelpScreen.id),
          ),
          createDrawerItem(
            icon: Icons.category,
            text: 'Introduction',
       //     onTap: () => Navigator.pushNamed(context, OnBoardingPage.id),
          ),
          createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
        //    onTap: () => Navigator.pushNamed(context, SettingScreen.id),
          ),
          /*
         onTap: () =>

          */
          Divider(),
          createDrawerItem(
            icon: Icons.share,
            text: 'Tell a Friend',
            onTap: () => {
              // if (userDevice.isIOS)
              //   {
              //     Share.share('Download our cool new App' + appName,
              //         subject: 'Check Out ' + appName + '\n  ' + appleStoreURL)
              //   }
              // else
              //   {
              //     Share.share('Download our cool new App' + appName,
              //         subject:
              //             'Check Out ' + appName + '\n  ' + androidStoreURL)
              //   }
            },
          ),
          createDrawerItem(
              icon: Icons.email, text: 'Contact Us', onTap: () => sendemail()),
        ],
      ),
    );
  }
