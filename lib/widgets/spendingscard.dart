// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:flutter_application_1/utils/styles.dart';
import 'package:gap/gap.dart';

class SpendingsCard extends StatefulWidget {
  final SpendingsModel model;
  const SpendingsCard(this.model, {Key? key}) : super(key: key);

  @override
  State<SpendingsCard> createState() => SpendingsCardState();
}

class SpendingsCardState extends State<SpendingsCard> {
  IconData icondata = showSolde
      ? Icons.keyboard_arrow_up_rounded
      : Icons.keyboard_arrow_down_rounded;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(40),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(32, 0, 0, 0),
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: cardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: .8,
                            child: AutoSizeText(
                              widget.model.title,
                              style: boldwhite(underlined: true),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  icondata = showSolde
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded;
                                  showSolde = !showSolde;
                                });
                              },
                              child: Text(
                                'Solde total',
                                style: boldwhite(),
                              ),
                            ),
                            whiteIcon(
                              icondata,
                              onPressed: () {
                                setState(() {
                                  showSolde = !showSolde;
                                  icondata = icondata ==
                                          Icons.keyboard_arrow_down_rounded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded;
                                });
                              },
                              size: 20,
                            ),
                          ],
                        ),
                        whiteIcon(
                          Icons.more_horiz,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: showSolde ? 30 : 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.model.strSolde,
                            style: boldwhite(size: 20),
                          ),
                        ],
                      ),
                    ),
                    Gap(showSolde ? 20 : 5),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        inOrOut(
                          "Entrées",
                          context,
                          amount: widget.model.strIncome,
                          align: CrossAxisAlignment.start,
                        ),
                        inOrOut(
                          "Dépenses",
                          context,
                          icon: Icons.arrow_upward_rounded,
                          amount: widget.model.strExpense,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget inOrOut(title, context,
    {icon = Icons.arrow_downward_rounded,
    amount = "0 FCFA",
    align = CrossAxisAlignment.end}) {
  return Column(
    crossAxisAlignment: align,
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(.2),
            radius: 16,
            child: whiteIcon(
              icon,
              size: 16,
              onPressed: () {},
            ),
          ),
          Gap(5),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
      SizedBox(
        width: width(context) * .35,
        child: Text(
          amount,
          style: boldwhite(size: 20),
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      )
    ],
  );
}

Widget whiteIcon(icon, {onPressed, size = 24}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(icon),
    color: Colors.white,
    iconSize: size,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
