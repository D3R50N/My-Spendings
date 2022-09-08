// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:gap/gap.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  TextEditingController lock_controller = TextEditingController();

  bool show_code = false, show_error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeCol.bkgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Entrez votre code de vérouillage",
                style: TextStyle(
                  color: ThemeCol.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Gap(20),
              TextField(
                controller: lock_controller,
                keyboardType: TextInputType.number,
                scrollPhysics: BouncingScrollPhysics(),
                onChanged: (t) {},
                obscureText: !show_code,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: ThemeCol.mainColor,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        show_code = !show_code;
                      });
                    },
                    highlightColor: Colors.transparent,
                    splashColor: ThemeCol.mainColor.withOpacity(.1),
                    icon: Icon(
                      show_code ? Icons.visibility : Icons.visibility_off,
                      color: ThemeCol.mainColor,
                    ),
                  ),
                  floatingLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeCol.mainColor,
                  ),
                ),
              ),
              Gap(20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ThemeCol.mainColor,
                  minimumSize: Size.fromHeight(40),
                  padding: EdgeInsets.all(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.lock_open, color: Colors.white),
                    Text(
                      'Dévérouiller',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.lock_open, color: Colors.white),
                  ],
                ),
                onPressed: () {
                  // save();
                  if (Settings.lockcode == lock_controller.text) {
                    pushRoute(context, Routes.home);
                  } else {
                    setState(() {
                      show_error = true;
                      Timer(Duration(milliseconds: 300), () {
                        setState(() {
                          show_error = false;
                        });
                      });
                    });
                  }
                },
              ),
              Gap(10),
              AnimatedOpacity(
                opacity: show_error ? 1 : 0,
                duration: Duration(milliseconds: 100),
                child: Text(
                  "Incorrect !",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
