// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/styles.dart';
import 'package:gap/gap.dart';

class SpendingsCard extends StatefulWidget {
  const SpendingsCard({Key? key}) : super(key: key);

  @override
  State<SpendingsCard> createState() => SspendingscardSCate();
}

class SspendingscardSCate extends State<SpendingsCard> {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Solde total',
                              style: boldwhite(),
                            ),
                            whiteIcon(
                              Icons.keyboard_arrow_down_rounded,
                              onPressed: () {},
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "15 775 FCFA",
                          style: boldwhite(size: 20),
                        ),
                      ],
                    ),
                    Gap(20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        inOrOut(
                          "Entrées",
                        ),
                        inOrOut(
                          "Dépenses",
                          icon: Icons.arrow_upward_rounded,
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

Widget inOrOut(title,
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
          )
        ],
      ),
      Text(
        amount,
        style: boldwhite(size: 20),
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
