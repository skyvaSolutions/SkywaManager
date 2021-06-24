import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywamanager/Providers/ThemeProvider.dart';
import 'package:skywamanager/components/tileWidgets.dart';
import 'package:skywamanager/screens/helpScreen.dart';

class ManageUserScreen extends StatefulWidget {
  static const String id = 'manageUserScreen';
  @override
  _ManageUserScreenState createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  SharedPreferences prefs;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Manage Users'),
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
                  title: "Place Holder",
                  icon: Icons.info,
                  onTap: () => {},
                ),
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
