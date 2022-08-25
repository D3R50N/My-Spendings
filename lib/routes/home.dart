// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
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
          backgroundColor: Color.fromARGB(255, 243, 255, 253),
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
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
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
                      onPressed: () {},
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
                      aspectRatio: showSolde.value ? 1.4 : 1.6,
                      // height: 200,
                    ),
                    items: all.map((index) {
                      return Builder(
                        builder: (BuildContext context) {
                          var model = SpendingsModel(
                              Random(index).nextInt(99999999).toDouble());
                          model.add(49950);
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Historique des transactions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                        )
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
}
