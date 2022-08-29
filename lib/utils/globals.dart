// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<bool> showSolde = ValueNotifier(false);

late SharedPreferences prefs;
late Box<SpendingsModel> spendingsBox;

class Boxes {
  static String spendings = "spendings";
}

class Settings {
  static String firstTime = "firstTime";
}
