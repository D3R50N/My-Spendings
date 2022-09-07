// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:flutter_application_1/utils/styles.dart';
import 'package:gap/gap.dart';

class SpendingsCard extends StatefulWidget {
  final SpendingsModel model;
  final bool showTitle, showEditBtn;
  final Function() onDelete;
  const SpendingsCard(this.model,
      {Key? key,
      this.showTitle = true,
      this.showEditBtn = true,
      required this.onDelete})
      : super(key: key);

  @override
  State<SpendingsCard> createState() => SpendingsCardState();
}

class SpendingsCardState extends State<SpendingsCard> {
  IconData icondata = showSolde.value
      ? Icons.keyboard_arrow_up_rounded
      : Icons.keyboard_arrow_down_rounded;

  List<String> editChoice = ["Modifier", "Supprimer"];
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
              color: ThemeCol.cardColor,
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
                    if (widget.showTitle)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                newmodel = spendingsBox.get(widget.model.key)!;
                                push(context, Routes.editplanif);
                              },
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
                                  icondata = showSolde.value
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded;
                                  showSolde.value = !showSolde.value;
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
                                  showSolde.value = !showSolde.value;
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
                        if (widget.showEditBtn)
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                            onSelected: (e) {
                              if (e == editChoice.first) {
                                try {
                                  newmodel =
                                      spendingsBox.get(widget.model.key)!;
                                  push(context, Routes.editplanif);
                                } catch (excep) {
                                  // print(excep);
                                  errordialog(
                                    context,
                                    text:
                                        "Impossible de modifier cette planification",
                                  );
                                }
                              } else {
                                confirmdialog(
                                  context,
                                  text:
                                      "Supprimer '${widget.model.title}' ainsi que ${widget.model.incomesList.length + widget.model.expensesList.length} transaction(s)?",
                                  onOk: () {
                                    spendingsBox
                                        .delete(widget.model.key)
                                        .then((value) {
                                      widget.onDelete();
                                      if (Settings.alwaysconfirm) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                );
                              }
                            },
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
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: showSolde.value ? 30 : 0,
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
                    Gap(showSolde.value ? 20 : 5),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Text(
            amount,
            style: boldwhite(size: 20),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
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
    iconSize: size.toDouble(),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
