import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywamanager/Providers/ThemeProvider.dart';
import 'package:skywamanager/components/tileWidgets.dart';
import 'package:skywamanager/screens/helpScreen.dart';
import 'package:skywamanager/screens/onBoarding.dart';

class NewUserScreen extends StatefulWidget {
  static const String id = 'newUserScreen';
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  SharedPreferences prefs;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Welcome to Skywa Manager'),
        centerTitle: true,
      ),
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
                  title: "Tell Me More About Skywa",
                  icon: Icons.info,
                  onTap: () =>
                      {Navigator.pushNamed(context, OnBoardingPage.id)},
                ),

                //
                MenuListTile(
                    title: "Set up a new business",
                    icon: Icons.business,
                    onTap: () => {}),

                MenuListTile(
                    title: "Sign on to my account",
                    icon: Icons.account_circle,
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
