// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/string_extensions.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/date_utils.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
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

  String lastError = "-", lastEntry = "-", lastOutput = "-";
  bool hasPressOperator = true;

  int equalCounter = 0;

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

  String calc(String first, String operator, String last) {
    if (operator == Operators.div) {
      return (first.toDouble() / last.toDouble())
          .toString()
          .toIntOrDouble()
          .toString();
    } else if (operator == Operators.mult) {
      return (first.toDouble() * last.toDouble())
          .toString()
          .toIntOrDouble()
          .toString();
    } else if (operator == Operators.minus) {
      return (first.toDouble() - last.toDouble())
          .toString()
          .toIntOrDouble()
          .toString();
    } else if (operator == Operators.plus) {
      return (first.toDouble() + last.toDouble())
          .toString()
          .toIntOrDouble()
          .toString();
    }
    throw UnsupportedError("");
  }

  void saveToHistory() {
    calcHistoriesBox.add(
        [lastEntry + " = " + lastOutput, AppDateUtils.toFr(DateTime.now())]);
  }

  void getResult() {
    if (equalCounter <= 1) lastTerm = screenController.text;
    try {
      screenController.text = calc(firstTerm, lastoperator, lastTerm);
      hasPressOperator = false;

      setState(() {
        lastEntry = "$firstTerm  $lastoperator  $lastTerm";
        lastOutput = screenController.text;
        lastError = "-";

        saveToHistory();
      });
    } on UnsupportedError {
      setState(() {
        lastError = "Opération impossible";
      });
    }

    // lastoperator = "";
    // firstTerm = "";
    // lastTerm = "";
    // hasPressOperator = true;
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
              onSelected: (e) {
                push(context, Routes.calchistorypage);
              },
              padding: EdgeInsets.zero,
              itemBuilder: (context) {
                return editChoice.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    onTap: () {},
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
              calcScreen(),
              outputInfos(),
              toolButtons(context),
              Gap(10),
              calcKeyboard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget calcKeyboard() {
    return Expanded(
      flex: 3,
      child: Card(
        color: ThemeCol.mainColor.withOpacity(.9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(10),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(.2),
                      // blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Card(
                    color: ThemeCol.mainColor,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        childAspectRatio: 1.5,
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
                            onPressed: () {
                              screenController.text =
                                  screenController.text + ".";
                            },
                            isDigit: false,
                          ),
                          digit(
                            '0',
                            onPressed: () {},
                          ),
                          digit(
                            '=',
                            onPressed: () {
                              equalCounter++;
                              getResult();
                            },
                            isDigit: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                crossAxisCount: 1,
                childAspectRatio: 17 / 16,
                children: [
                  digit('↩',
                      onPressed: () {
                        screenController.text = screenController.text
                            .substring(0, screenController.text.length - 1);
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
    );
  }

  Widget toolButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        toolBtn("±", onPressed: () {
          screenController.text = screenController.text.startsWith("-")
              ? screenController.text.replaceFirst("-", "")
              : screenController.text = "-" + screenController.text;
        }),
        toolBtn("⅟ⅹ", onPressed: () {
          try {
            var _temp = screenController.text;

            screenController.text =
                calc("1", Operators.div, screenController.text);

            setState(() {
              lastoperator = "⅟";
              lastEntry = "1 ${Operators.div} $_temp";
              lastOutput = screenController.text;
              lastError = "-";
              saveToHistory();
            });
          } on UnsupportedError {
            setState(() {
              lastError = "Division par zéro";
            });
          }
        }),
        toolBtn("x²", onPressed: () {
          try {
            var _temp = screenController.text;

            screenController.text = calc(
                screenController.text, Operators.mult, screenController.text);

            setState(() {
              lastoperator = "²";
              lastEntry = "$_temp²";
              lastOutput = screenController.text;
              lastError = "-";
              saveToHistory();
            });
          } on UnsupportedError {
            setState(() {
              lastError = "Tend vers l'infini";
            });
          }
        }),
        toolBtn("%", onPressed: () {
          try {
            var _temp = screenController.text;

            screenController.text =
                calc(screenController.text, Operators.div, "100");

            setState(() {
              lastoperator = "%";
              lastEntry = "$_temp%";
              lastOutput = screenController.text;
              lastError = "-";
              saveToHistory();
            });
          } on UnsupportedError {
            setState(() {
              lastError = "Tend vers l'infini négatif";
            });
          }
        }),
        toolBtn("√", onPressed: () {
          try {
            var _temp = screenController.text;

            if (sqrt(screenController.text.toIntOrDouble()).isNaN) {
              throw UnsupportedError("");
            }
            screenController.text =
                sqrt(screenController.text.toIntOrDouble()).toString();
            setState(() {
              lastoperator = "√";
              lastEntry = "√$_temp";
              lastOutput = screenController.text;
              lastError = "-";
              saveToHistory();
            });
          } on UnsupportedError {
            setState(() {
              lastError = "Nombre négatif ou zéro";
            });
          }
        }),
      ],
    );
  }

  Widget toolBtn(String text, {required void Function()? onPressed}) {
    return Container(
      padding: EdgeInsets.zero,
      width: (width(context) / 6),
      child: ElevatedButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            // backgroundColor: Color.fromARGB(179, 0, 0, 0),
            padding: EdgeInsets.all(5),
            side: BorderSide(
              width: 1,
              color: ThemeCol.mainColor,
            )
            // fixedSize: Size.fromWidth(width(context) / 10),
            ),
        child: Text(
          text,
          style: TextStyle(
            // color: Colors.white,
            color: ThemeCol.mainColor,
            fontWeight: FontWeight.w500,
            fontSize: width(context) / 16,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget outputInfos() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  lastEntry,
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
                  lastOutput,
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
                  lastError,
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
    );
  }

  Widget calcScreen() {
    return Padding(
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
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ThemeCol.mainColor.withOpacity(.0),
            padding: EdgeInsets.all(0),
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
            if (number != "=") equalCounter = 0;
            if (isOperator) {
              if (hasPressOperator) getResult();
              setState(() {
                lastoperator = number;
                if (!hasPressOperator) hasPressOperator = true;
              });
            } else {
              if (hasPressOperator || equalCounter > 0) {
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
      ),
    );
  }
}
