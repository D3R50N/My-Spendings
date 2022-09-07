// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/globals.dart';

// const Color ThemeCol.mainColor = Color.fromRGBO(0, 132, 122, 1);
// const Color ThemeCol.cardColor = Color.fromRGBO(0, 124, 113, 1);
// const Color ThemeCol.bkgColor = Color.fromARGB(255, 243, 255, 253);

// const Color ThemeCol.mainColor = Color.fromARGB(255, 112, 0, 132);
// const Color ThemeCol.cardColor = Color.fromARGB(255, 95, 0, 124);
// const Color ThemeCol.bkgColor = Color.fromARGB(255, 255, 243, 252);

class ThemeCol {
  static List<Color> mainColors = [
    Color.fromRGBO(0, 132, 122, 1),
    Color.fromARGB(255, 132, 88, 0),
    Color.fromARGB(255, 112, 0, 132),
    Color.fromARGB(255, 0, 86, 132),
    Color.fromARGB(255, 132, 0, 0),
  ];
  static List<Color> cardColors = [
    Color.fromRGBO(0, 124, 113, 1),
    Color.fromARGB(255, 109, 73, 2),
    Color.fromARGB(255, 95, 0, 124),
    Color.fromARGB(255, 1, 79, 121),
    Color.fromARGB(255, 113, 11, 11),
  ];
  static List<Color> bkgColors = [
    Color.fromARGB(255, 243, 255, 253),
    Color.fromARGB(255, 255, 250, 243),
    Color.fromARGB(255, 255, 243, 252),
    Color.fromARGB(255, 239, 241, 255),
    Color.fromARGB(255, 255, 239, 239),
  ];

  static int theme = Settings.currentheme;

  static Future<void> setTheme(int them) async {
    await Settings.settheme(them);
    theme = them;
    reload();
  }

  static Color get mainColor => ThemeCol.mainColors[theme];
  static Color get cardColor => ThemeCol.cardColors[theme];
  static Color get bkgColor => ThemeCol.bkgColors[theme];
}
