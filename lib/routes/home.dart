// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/custompaint.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:flutter_application_1/utils/styles.dart';
import 'package:flutter_application_1/widgets/spendingscard.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController carouselController = CarouselController();
  bool showCarouselControls = false;

  List all = List.generate(1, (index) => index);

  late ScrollController _scrollViewController;
  bool isScrollingDown = false, showFloating = true;

  @override
  void initState() {
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_scrollViewController.offset < 20) return;
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            showFloating = false;
          });
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            showFloating = true;
          });
        }
      }
    });

    showSolde.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: bkgColor,
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + 20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(10),
                Text(
                  "Bonsoir,",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Max Andy M.",
                  style: boldwhite(size: 18),
                ),
              ],
            ),
            elevation: 0,
            backgroundColor: mainColor,
            actions: [whiteIcon(Icons.settings_outlined, onPressed: () {})],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: floatingButtons(context),
          body: Stack(
            children: [
              Positioned(top: 60, child: customHeader(context)),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      autoPlay: all.length > 1,
                      viewportFraction: 1,
                      // aspectRatio: showSolde.value ? 1.4 : 1.6,
                      height: showSolde.value ? 250 : 200,
                      // height: 200,
                    ),
                    items: all.map((index) {
                      return Builder(
                        builder: (BuildContext context) {
                          var model = SpendingsModel(
                              Random(index).nextInt(99999999).toDouble());
                          return SpendingsCard(model);
                        },
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Historique des transactions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "Voir tout",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollViewController,
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Gap(10),
                                historycard(),
                                historycard(),
                                historycard(),
                                historycard(),
                                historycard(),
                                historycard(),
                                historycard(),
                                Gap(100),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedOpacity floatingButtons(BuildContext context) {
    return AnimatedOpacity(
      opacity: showFloating ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            heroTag: "new",
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            label: const Text('Nouvelle planif'),
            foregroundColor: Colors.white,
            backgroundColor: mainColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide.none,
            ),
          ),
          Gap(10),
          Builder(
            builder: (context) {
              if (width(context) > 308) {
                return FloatingActionButton.extended(
                  heroTag: "tools",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Card(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Outils",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black.withOpacity(.8),
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(thickness: 1),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("Convertisseur"),
                                    subtitle: Text("Détails"),
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      backgroundColor: mainColor,
                                      child: Icon(Icons.attach_money_rounded),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("Calculatrice"),
                                    subtitle: Text("Détails"),
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      backgroundColor: mainColor,
                                      child: Icon(Icons.calculate_rounded),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("Espace trading"),
                                    subtitle: Text("Détails"),
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      backgroundColor: mainColor,
                                      child: Icon(Icons.trending_up_rounded),
                                    ),
                                  ),
                                  Gap(30),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.build_rounded),
                  label: Text('Outils'),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: mainColor,
                      width: 2,
                    ),
                  ),
                  foregroundColor: mainColor,
                  elevation: 0,
                );
              }

              return FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.build_rounded),
                tooltip: 'Outils',
                backgroundColor: Colors.white,
                foregroundColor: mainColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget historycard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(.3),
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Achat de gari",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Aujourd'hui",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.4),
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "+ 10000 FCFA",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: mainColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
