import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:skywamanager/Global&Constants/DeviceDetailsConstants.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:skywamanager/components/businessWidget.dart';
import 'package:skywamanager/components/tileWidgets.dart';
import 'package:skywamanager/screens/helpScreen.dart';
import 'package:skywamanager/screens/onBoarding.dart';
import 'package:skywamanager/screens/profileEditScreen.dart';
import 'package:skywamanager/screens/searchPage.dart';
import 'package:skywamanager/screens/settingScreen.dart';
import 'package:skywamanager/screens/splashScreen.dart';
import 'package:skywamanager/services/deviceConnection.dart';
import 'package:skywamanager/utils/Network_aware.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              for (int i = 0; i < nearbyQs.length;i++)
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

// class TestWidget extends StatelessWidget {
//   const TestWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${nearbyQs[index].companyName} ',
//               textAlign: TextAlign.left,
//               style: GoogleFonts.poppins(
//                   fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${nearbyQs[index].address}',
//               textAlign: TextAlign.left,
//               style: GoogleFonts.poppins(fontSize: 15),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 10.0, right: 10.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
// //                              style: ElevatedButton.styleFrom(
// //                                  primary: Colors.blueAccent),
//                   onPressed: () {
//                     // On button presed
//                   },
//                   child: const Text("Check In"),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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
            onTap: () => Navigator.pushNamed(context, ProfileEditPage.id),
          ),
          createDrawerItem(
            icon: Icons.help,
            text: 'Help',
            onTap: () => Navigator.pushNamed(context, HelpScreen.id),
          ),
          createDrawerItem(
            icon: Icons.category,
            text: 'Introduction',
            onTap: () => Navigator.pushNamed(context, OnBoardingPage.id),
          ),
          createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => Navigator.pushNamed(context, SettingScreen.id),
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
}
