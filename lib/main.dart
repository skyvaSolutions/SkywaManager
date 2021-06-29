import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skywamanager/Providers/ThemeProvider.dart';
import 'package:skywamanager/Providers/businessDataProvider.dart';
import 'package:skywamanager/Providers/searchProvider.dart';
import 'package:skywamanager/screens/helpScreen.dart';
import 'package:skywamanager/screens/homeScreen.dart';
import 'package:skywamanager/screens/manageUserScreen.dart';
import 'package:skywamanager/screens/newUser.dart';
import 'package:skywamanager/screens/onBoarding.dart';
import 'package:skywamanager/screens/operateScreen.dart';
import 'package:skywamanager/screens/profileEditScreen.dart';
import 'package:skywamanager/screens/searchPage.dart';
import 'package:skywamanager/screens/settingScreen.dart';
import 'package:skywamanager/screens/splashScreen.dart';

import 'DB/DB.dart';

void main() async {
  await Hive.initFlutter();
  DB.box = await Hive.openBox(DB.boxName);
  // imageCache.clear();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // print("firebase initialized, ${DateTime.now()}");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => searchProvider()),
    ChangeNotifierProvider(create: (context) => businessDataProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prov = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'App Template',
      debugShowCheckedModeBanner: false,
      themeMode: _prov.DarkMode == true ? ThemeMode.dark : ThemeMode.light,
      theme: FlexColorScheme.light(scheme: FlexScheme.hippieBlue).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.hippieBlue
              //  fontFamily: 'Georgia',
              )
          .toTheme,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        HelpScreen.id: (context) => HelpScreen(),
        OnBoardingPage.id: (context) => OnBoardingPage(),
        SettingScreen.id: (context) => SettingScreen(),
        ProfileEditPage.id: (context) => ProfileEditPage(),
        SearchPage.id: (context) => SearchPage(),
        NewUserScreen.id: (context) => NewUserScreen(),
        OperateScreen.id: (context) => OperateScreen(),
        ManageUserScreen.id: (context) => ManageUserScreen(),
      },
    );
  }
}
