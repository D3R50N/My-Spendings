// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/custompaint.dart';
import 'package:flutter_application_1/utils/functions.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
          body: Stack(
            children: [
              Positioned(top: 60, child: customHeader(context)),
              Stack(
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      height: height(context),
                      viewportFraction: 1,
                    ),
                    items: List.generate(
                      100,
                      (index) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SpendingsCard();
                          },
                        );
                      },
                    ),
                  ),
                  if (showCarouselControls)
                    Positioned(
                      top: 120,
                      left: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(.2),
                        radius: 16,
                        child: whiteIcon(
                          Icons.arrow_back_ios,
                          size: 14,
                          onPressed: () {
                            carouselController.previousPage();
                          },
                        ),
                      ),
                    ),
                  if (showCarouselControls)
                    Positioned(
                      top: 120,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(.2),
                        radius: 16,
                        child: whiteIcon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          onPressed: () {
                            carouselController.nextPage();
                          },
                        ),
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
