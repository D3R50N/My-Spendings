// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<bool> showSolde = ValueNotifier(false);
late Function() reload;

late SharedPreferences prefs;
late Box<SpendingsModel> spendingsBox;
SpendingsModel newmodel = SpendingsModel(0);

class Boxes {
  static String spendings = "spendings";
}

class Settings {
  static String firstTime = "firstTime";

  static bool get autosave => prefs.getBool("autosave") ?? false;
  static bool get autoscroll => prefs.getBool("autoscroll") ?? false;
  static bool get alwaysconfirm => prefs.getBool("alwaysconfirm") ?? true;
  static bool get lock => prefs.getBool("lock") ?? false;
  static String get username => prefs.getString("username") ?? "Inconnu";
  static String get lockcode => prefs.getString("lockcode") ?? "";
  static int get currentheme => prefs.getInt("currentheme") ?? 0;

  static Future<void> settheme(int theme) async {
    await prefs.setInt("currentheme", theme);
  }
  static Future<void> setsave(bool b) async{
    await prefs.setBool("autosave", b);
  }

  static Future<void> setscroll(bool b) async{
    await prefs.setBool("autoscroll", b);
  }

  static Future<void> setconfirm(bool b) async{
    await prefs.setBool("alwaysconfirm", b);
  }
  static Future<void> setlock(bool b) async {
    await prefs.setBool("lock", b);
  }

  static Future<void> setname(String n) async{
    await prefs.setString("username", n);
  }
   static Future<void> setlockcode(String n) async {
    await prefs.setString("lockcode", n);
  }
}

class NameUtil {
  static String get untitled {
    var currNum = spendingsBox.values
        .where((element) => element.title.startsWith("Sans nom"))
        .length;
    return currNum > 0 ? "Sans nom ($currNum)" : "Sans nom";
  }
}
