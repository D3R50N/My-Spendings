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
    Color.fromARGB(255, 112, 0, 132),
  ];
  static List<Color> cardColors = [
    Color.fromRGBO(0, 124, 113, 1),
    Color.fromARGB(255, 95, 0, 124),
  ];
  static List<Color> bkgColors = [
    Color.fromARGB(255, 243, 255, 253),
    Color.fromARGB(255, 255, 243, 252)
  ];

  static int theme = 0;

 static void setTheme(int them) {
    theme = them;
    reload();
  }

  static Color get mainColor => ThemeCol.mainColors[theme];
  static Color get cardColor => ThemeCol.cardColors[theme];
  static Color get bkgColor => ThemeCol.bkgColors[theme];
}
