// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/routes.dart';

import 'package:flutter_application_1/utils/globals.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SpendingsModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  spendingsBox = await Hive.openBox<SpendingsModel>(Boxes.spendings);
  calcHistoriesBox = await Hive.openBox<List<String>>(Boxes.calcHistories);
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
      initialRoute: Settings.lock
          ? Routes.lockpage
          : prefs.getBool(Settings.firstTime) ?? true
              ? Routes.startingpage
              : Routes.home,
      routes: Routes.all,
    );
  }
}
