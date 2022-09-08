// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/globals.dart';

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

void pushRoute(BuildContext context, String name) {
  Navigator.of(context).pushReplacementNamed(name);
}

void push(BuildContext context, String name) {
  Navigator.of(context).pushNamed(name);
}

void errordialog(context, {required String text}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              color: ThemeCol.mainColor,
              size: 30,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  );
}

void confirmdialog(
  context, {
  required String text,
  required Function() onOk,
  IconData icon = Icons.info_rounded,
}) {
  if (!Settings.alwaysconfirm) {
    onOk();
    return;
  }
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: ThemeCol.mainColor,
              size: 30,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Annluer",
              style: TextStyle(
                color: ThemeCol.mainColor,
              ),
            ),
          ),
          TextButton(
              onPressed: onOk,
              child: Text(
                "OK",
                style: TextStyle(
                  color: ThemeCol.mainColor,
                ),
              )),
        ],
      );
    },
  );
}
