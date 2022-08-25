// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

TextStyle boldwhite({size = 14, underlined = false}) {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: size,
    decoration: underlined ? TextDecoration.underline : TextDecoration.none,
  );
}
