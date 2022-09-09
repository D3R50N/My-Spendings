import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/routes/calc_histoy.dart';
import 'package:flutter_application_1/routes/calculator.dart';
import 'package:flutter_application_1/routes/converter.dart';
import 'package:flutter_application_1/routes/editplan.dart';
import 'package:flutter_application_1/routes/home.dart';
import 'package:flutter_application_1/routes/lockcode.dart';
import 'package:flutter_application_1/routes/newplan.dart';
import 'package:flutter_application_1/routes/settings.dart';
import 'package:flutter_application_1/routes/startingpage.dart';

class Routes {
  static String home = "/";
  static String startingpage = "startingpage";
  static String newplanif = "newplanif";
  static String editplanif = "editplanif";
  static String settingspage = "settingspage";
  static String lockpage = "lockpage";
  static String calcpage = "calcpage";
  static String converterpage = "converterpage";
  static String calchistorypage = "calchistoryrpage";

  static Map<String, Widget Function(BuildContext)> all = {
    home: (context) => const Home(),
    startingpage: (context) => const StartingPage(),
    newplanif: ((context) => const NewPlanif()),
    editplanif: ((context) => const EditPlanif()),
    settingspage: ((context) => const SettingsPage()),
    lockpage: ((context) => const LockCodePage()),
    calcpage: ((context) => const CalculatorPage()),
    converterpage: ((context) => const ConverterPage()),
    calchistorypage : ((context) => const CalcHistoryPage()),
  };
}
