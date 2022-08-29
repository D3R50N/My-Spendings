import 'package:flutter/material.dart';

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

void pushRoute(BuildContext context, String name) {
  Navigator.of(context).pushReplacementNamed(name);
}
