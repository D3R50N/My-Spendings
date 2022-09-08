// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/extensions/string_extensions.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/custompaint.dart';
import 'package:flutter_application_1/utils/date_utils.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:flutter_application_1/utils/styles.dart';
import 'package:flutter_application_1/widgets/historycard.dart';
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

  List<SpendingsModel> all = [];

  late ScrollController _scrollViewController;
  bool isScrollingDown = false, showFloating = true;

  List<HistoryModel> histories = [];

  late TextEditingController dialog_title, dialog_capital;
  @override
  void initState() {
    reload = () {
      SpendingsModel.all().then((value) {
        if (mounted) {
          setState(() {
            all = value;
          });
        }
      });
      HistoryModel.all().then((value) {
        // for (var item in value) {
        //   print(item.title);
        // }

        if (mounted) {
          setState(() {
            histories = value;
            histories.sort((a, b) {
              return AppDateUtils.fromStr(b.date)
                  .compareTo(AppDateUtils.fromStr(a.date));
            });
          });
        }
      });
    };
    reload();

    dialog_title = TextEditingController();
    dialog_capital = TextEditingController(text: "0");
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
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // showSolde = ValueNotifier(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: ThemeCol.bkgColor,
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
                  Settings.username,
                  style: boldwhite(size: 18),
                ),
              ],
            ),
            elevation: 0,
            backgroundColor: ThemeCol.mainColor,
            actions: [
              whiteIcon(Icons.settings_outlined, onPressed: () {
                push(context, Routes.settingspage);
              })
            ],
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
                  if (all.isNotEmpty)
                    CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        autoPlay: all.length > 1 && Settings.autoscroll,
                        viewportFraction: 1,
                        // aspectRatio: showSolde.value ? 1.4 : 1.6,
                        height: showSolde.value ? 250 : 200,
                        // height: 200,
                      ),
                      items: all.map((model) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SpendingsCard(
                              model,
                              onDelete: () {
                                reload();
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
                  Expanded(
                    child: all.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        color: ThemeCol.mainColor,
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
                                      ...histories
                                          .map((e) => HistoryCard(
                                                e,
                                                fresh: () {
                                                  setState(() {});
                                                },
                                              ))
                                          .toList(),
                                      Gap(100),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Aucune planification disponible",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(.6),
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
            extendedPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            onPressed: () {
              // pushRoute(context, Routes.newplanif);
              createDialog();
            },
            icon: const Icon(Icons.add_rounded),
            label: const Text('Nouvelle planif'),
            foregroundColor: Colors.white,
            backgroundColor: ThemeCol.mainColor,
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
                  extendedPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
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
                                    title: Text("Calculatrice"),
                                    subtitle: Text(
                                        "Effectuez des rapidement des opérations sur les montants"),
                                    onTap: () {
                                      push(context, Routes.calcpage);
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: ThemeCol.mainColor,
                                      child: Icon(
                                        Icons.calculate_rounded,
                                        color: ThemeCol.bkgColor,
                                      ),
                                    ),
                                  ),
                                  Gap(5),
                                  ListTile(
                                    title: Text("Convertisseur"),
                                    subtitle: Text(
                                        "Consultez votre solde et vos dépenses en plusieurs devises"),
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      backgroundColor: ThemeCol.mainColor,
                                      child: Icon(
                                        Icons.attach_money_rounded,
                                        color: ThemeCol.bkgColor,
                                      ),
                                    ),
                                  ),
                                  Gap(5),
                                  ListTile(
                                    title: Text("Espace trading (PRO)"),
                                    subtitle: Text(
                                        "Gérez vos achats et ventes dans cet espace"),
                                    onTap: () {
                                      errordialog(
                                        context,
                                        text:
                                            "Disponible dans la version pro !",
                                      );
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: ThemeCol.mainColor,
                                      child: Icon(
                                        Icons.trending_up_rounded,
                                        color: ThemeCol.bkgColor,
                                      ),
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
                      color: ThemeCol.mainColor,
                      width: 2,
                    ),
                  ),
                  foregroundColor: ThemeCol.mainColor,
                  elevation: 0,
                );
              }

              return FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.build_rounded),
                tooltip: 'Outils',
                mini: true,
                backgroundColor: Colors.white,
                foregroundColor: ThemeCol.mainColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ThemeCol.mainColor,
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

  Future<void> createDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Nouvelle planification',
            textAlign: TextAlign.center,
          ),
          backgroundColor: ThemeCol.bkgColor,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: dialog_title,
                  scrollPhysics: BouncingScrollPhysics(),
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
                    label: Text(
                      'Titre : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    floatingLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ThemeCol.mainColor,
                    ),
                  ),
                ),
                Gap(20),
                TextField(
                  controller: dialog_capital,
                  scrollPhysics: BouncingScrollPhysics(),
                  keyboardType: TextInputType.number,
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
                    // prefixText: "Titre : ",
                    label: Text(
                      'Capital : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    floatingLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ThemeCol.mainColor,
                    ),
                    suffixText: "FCFA",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ThemeCol.mainColor,
                minimumSize: Size.fromHeight(40),
                padding: EdgeInsets.all(18),
              ),
              child: Text(
                'Créer',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //NOTE Enlever le dialogue avant d'afficher la page
                // Navigator.of(context).pop();
                newmodel = SpendingsModel(double.parse(dialog_capital.text),
                    title: dialog_title.text.empty
                        ? NameUtil.untitled
                        : dialog_title.text);

                push(context, Routes.newplanif);
              },
            ),
          ],
        );
      },
    );
  }
}
