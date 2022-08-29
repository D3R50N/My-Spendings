// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  var btnStyle = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.bold,
  );

  bool atEnd = false;

  int pageCount = 3;

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkgColor,
      body: PageView(
        controller: pageController,
        onPageChanged: (page) {
          if (page.round() == pageCount - 1) {
            setState(() {
              atEnd = true;
            });
          } else {
            setState(() {
              atEnd = false;
            });
          }
        },
        children: [
          firstPage(context),
          secondPage(context),
          thirdPage(context),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: atEnd ? 0 : 10),
        color: bkgColor,
        height: 40,
        child: atEnd
            ? TextButton(
                onPressed: () {
                  prefs.setBool(Settings.firstTime, false).then((value) {
                    pushRoute(context, '/');
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: mainColor,
                  minimumSize: Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  "Commencer",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        pageCount - 1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(
                      "Passer",
                      style: btnStyle,
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: pageCount,
                      effect: WormEffect(
                        activeDotColor: mainColor,
                        dotColor: Colors.grey.shade400,
                        radius: 5,
                        dotHeight: 10,
                        dotWidth: 18,
                      ),
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text("Suivant", style: btnStyle),
                  ),
                ],
              ),
      ),
    );
  }

  Widget firstPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: .1,
            child: CircleAvatar(
              backgroundColor: mainColor,
              child: Icon(
                Icons.attach_money_rounded,
                size: width(context),
              ),
              foregroundColor: Colors.white,
              radius: width(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Enregistrez vos dépenses en seul geste et suivez en temps réel vos bénéfices.',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget secondPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: .1,
            child: CircleAvatar(
              backgroundColor: mainColor,
              child: Icon(
                Icons.account_balance_rounded,
                size: width(context) * 0.8,
              ),
              foregroundColor: Colors.white,
              radius: width(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Utilisez nos outils tel que le "Convertisseur" pour connaître vos encoûts dans n\'importe quelle devise.',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget thirdPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: .1,
            child: CircleAvatar(
              backgroundColor: mainColor,
              child: Icon(
                Icons.history,
                size: width(context) * 0.7,
              ),
              foregroundColor: Colors.white,
              radius: width(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Accéder à l\'historique de vos transactions pour voir le bilan de vos dépenses.',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
