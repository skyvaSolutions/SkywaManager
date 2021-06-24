import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:skywamanager/Providers/ThemeProvider.dart';
import 'package:skywamanager/components/tileWidgets.dart';
import 'package:skywamanager/screens/helpScreen.dart';
import 'package:skywamanager/screens/manageUserScreen.dart';
import 'package:skywamanager/screens/operateScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        //       leading: IconButton(
//          icon: Icon(
//            Icons.chevron_left,
//          ),
//          onPressed: () => Navigator.of(context).pop(),
        //      ),
        title: Text('Welcome'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body:
//      Column  (
//        children: [
          Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.only(left: 7, right: 7),
        child: ListView(
          children: [
            Column(
              children: [
                MenuListTile(
                  title: "Operate the Queue ",
                  icon: Icons.format_list_numbered_rtl,
                  onTap: () => {Navigator.pushNamed(context, OperateScreen.id)},
                ),

                //
                MenuListTile(
                  title: "Manage Users",
                  icon: Icons.person,
                  onTap: () =>
                      {Navigator.pushNamed(context, ManageUserScreen.id)},
                ),

                MenuListTile(
                    title: "Edit Business Information",
                    icon: Icons.business,
                    onTap: () => {}),

                MenuListTile(
                  title: "Help",
                  icon: Icons.help,
                  onTap: () => {Navigator.pushNamed(context, HelpScreen.id)},
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
