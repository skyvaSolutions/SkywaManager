import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:skywamanager/Providers/ThemeProvider.dart';
import 'package:skywamanager/Providers/businessDataProvider.dart';
import 'package:skywamanager/components/tileWidgets.dart';
import 'package:skywamanager/screens/helpScreen.dart';
import 'package:skywamanager/screens/onBoarding.dart';
import 'package:skywamanager/screens/operateTrainingBusiness.dart';

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
    final businessDataProv = Provider.of<businessDataProvider>(context);

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
                    title: "Operate Training Business",
                    icon: Icons.school,
                    onTap: () async {
                      gQID = teachingQID;
                      print(gQID);
                      await businessDataProv.getQMetaData();
                      await businessDataProv.getReservationData(gQID);

                      print(gQID);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => operateTrainingBusiness(
                                    id: gQID,
                                  )));
                      //TODO Gaurav
                      // Can you call getQMeta with qid=gQiD and store it in a global variable
                      //    https://shoeboxtx.veloxe.com:36251/api/GetQMetadata?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QID=46181836-EC04-469E-8B2B-1E9F9565E5D0
                      // When that is complete call getAllReservationsForMyLocation with the same QID
                      // and store result in a global variable.
                      // Then transition to operateScreen and just print the list of people from all the reservations.
                      //  This needs to use the provider package as the reservations will change as people arrive and get served so we will need the operate screen to refresh
                    }),

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
