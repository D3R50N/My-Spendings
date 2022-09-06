// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/routes/editplan.dart';
import 'package:flutter_application_1/routes/home.dart';
import 'package:flutter_application_1/routes/newplan.dart';
import 'package:flutter_application_1/routes/startingpage.dart';
import 'package:flutter_application_1/utils/globals.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SpendingsModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  spendingsBox = await Hive.openBox<SpendingsModel>(Boxes.spendings);
  prefs = await SharedPreferences.getInstance();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Spendings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: prefs.getBool(Settings.firstTime) ?? true
          ? Routes.startingpage
          : Routes.home,
      routes: {
        Routes.home: (context) => Home(),
        Routes.startingpage: (context) => StartingPage(),
        Routes.newplanif: ((context) => NewPlanif()),
        Routes.editplanif: ((context) => EditPlanif()),
      },
    );
  }
}
