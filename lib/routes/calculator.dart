// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/string_extensions.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:gap/gap.dart';

class Operators {
  static const minus = "–";
  static const plus = "+";
  static const div = "÷";
  static const mult = "×";
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController screenController = TextEditingController(text: "0");
  ScrollController scrollController = ScrollController();
  CarouselController carouselController = CarouselController();
  List<SpendingsModel> all = [];

  List<String> editChoice = ["Historique"];

  String lastoperator = "", firstTerm = "", lastTerm = "";

  bool hasPressOperator = true;
  @override
  void initState() {
    SpendingsModel.all().then((value) {
      if (mounted) {
        setState(() {
          all = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeCol.bkgColor,
        appBar: AppBar(
          title: Text("Outils - Calculatrice"),
          elevation: 0,
          backgroundColor: ThemeCol.mainColor,
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (e) {},
              padding: EdgeInsets.zero,
              itemBuilder: (context) {
                return editChoice.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    height: kMinInteractiveDimension - 10,
                    child: Text(
                      choice,
                      style: TextStyle(
                        color: ThemeCol.mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NOTE Screen
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: TextField(
                    // textDirection: TextDirection.rtl,
                    textAlign: TextAlign.end,
                    showCursor: false,
                    controller: screenController,
                    scrollController: scrollController,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    scrollPhysics: BouncingScrollPhysics(),
                    onChanged: (t) {
                      // scrollController.jumpTo(100);
                    },
                    maxLines: 1,
                    minLines: 1,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: 2,
                    ),

                    // textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          lastoperator,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(.5),
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: ThemeCol.mainColor.withOpacity(.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: ThemeCol.mainColor.withOpacity(.2),
                        ),
                      ),
                      // contentPadding:  EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            "Entrée précédente : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          Text(
                            "4569+19",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text(
                            "Sortie précédente : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          Text(
                            "4588",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text(
                            "Erreur de calcul : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          Text(
                            "aucune",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(179, 0, 0, 0),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                      "⅟ⅹ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: width(context) / 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(179, 0, 0, 0),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                      "x²",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: width(context) / 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(179, 0, 0, 0),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                      "%",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: width(context) / 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(179, 0, 0, 0),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                      "√",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: width(context) / 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Gap(10),
              Expanded(
                flex: 3,
                child: Card(
                  color: ThemeCol.mainColor.withOpacity(.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 4,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: [
                            digit(
                              '7',
                              onPressed: () {},
                            ),
                            digit(
                              '8',
                              onPressed: () {},
                            ),
                            digit(
                              '9',
                              onPressed: () {},
                            ),
                            digit(
                              '4',
                              onPressed: () {},
                            ),
                            digit(
                              '5',
                              onPressed: () {},
                            ),
                            digit(
                              '6',
                              onPressed: () {},
                            ),
                            digit(
                              '1',
                              onPressed: () {},
                            ),
                            digit(
                              '2',
                              onPressed: () {},
                            ),
                            digit(
                              '3',
                              onPressed: () {},
                            ),
                            digit(
                              ',',
                              onPressed: () {},
                              isDigit: false,
                            ),
                            digit(
                              '0',
                              onPressed: () {},
                            ),
                            digit(
                              '=',
                              onPressed: () {
                                lastTerm = screenController.text;
                                if (lastoperator == Operators.div) {
                                  screenController.text =
                                      (firstTerm.toDouble() /
                                              lastTerm.toDouble())
                                          .toString()
                                          .toIntOrDouble()
                                          .toString();
                                } else if (lastoperator == Operators.mult) {
                                  screenController.text =
                                      (firstTerm.toDouble() *
                                              lastTerm.toDouble())
                                          .toString()
                                          .toIntOrDouble()
                                          .toString();
                                } else if (lastoperator == Operators.minus) {
                                  screenController.text =
                                      (firstTerm.toDouble() -
                                              lastTerm.toDouble())
                                          .toString()
                                          .toIntOrDouble()
                                          .toString();
                                } else if (lastoperator == Operators.plus) {
                                  screenController.text =
                                      (firstTerm.toDouble() +
                                              lastTerm.toDouble())
                                          .toString()
                                          .toIntOrDouble()
                                          .toString();
                                }
                                // lastoperator = "";
                                // firstTerm = "";
                                // lastTerm = "";
                                hasPressOperator = true;
                              },
                              isDigit: false,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          childAspectRatio: 15 / 16,
                          children: [
                            digit('↩',
                                onPressed: () {
                                  screenController.text = screenController.text
                                      .substring(
                                          0, screenController.text.length - 1);
                                  if (screenController.text.empty) {
                                    screenController.text = "0";
                                    setState(() {
                                      lastoperator = "";
                                    });
                                  }
                                },
                                isDigit: false,
                                onLongPress: () {
                                  screenController.text = "0";
                                }),
                            digit(
                              Operators.div,
                              onPressed: () {},
                              isDigit: false,
                              isOperator: true,
                            ),
                            digit(
                              Operators.mult,
                              onPressed: () {},
                              isDigit: false,
                              isOperator: true,
                            ),
                            digit(
                              Operators.minus,
                              onPressed: () {},
                              isDigit: false,
                              isOperator: true,
                            ),
                            digit(
                              Operators.plus,
                              onPressed: () {},
                              isDigit: false,
                              isOperator: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget digit(
    String number, {
    required Function() onPressed,
    bool isDigit = true,
    bool isOperator = false,
    Function()? onLongPress,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ThemeCol.mainColor.withOpacity(.0),
          padding: EdgeInsets.all(width(context) / 30),
          fixedSize: Size(width(context) / 6, width(context) / 6),
        ),
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: width(context) / 15,
          ),
        ),
        onLongPress: onLongPress,
        onPressed: () {
          if (isOperator) {
            setState(() {
              lastoperator = number;
              hasPressOperator = true;
            });
          } else {
            if (hasPressOperator) {
              firstTerm = screenController.text;
            }
          }
          if (isDigit) {
            if (hasPressOperator) {
              screenController.text = number;
              hasPressOperator = false;
            } else {
              screenController.text += number;
            }
          }

          scrollController.jumpTo(scrollController.position.maxScrollExtent +
              (scrollController.position.maxScrollExtent > 0 && isDigit
                  ? 15
                  : 0));

          onPressed();
        },
      ),
    );
  }
}
