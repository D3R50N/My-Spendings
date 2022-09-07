// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/date_utils.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:gap/gap.dart';

class HistoryCard extends StatefulWidget {
  final HistoryModel model;
  final bool showDate;
  final Function() fresh;
  const HistoryCard(this.model,
      {Key? key, this.showDate = true, required this.fresh})
      : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  int year_limit = 1;

  List list = ["Nouvelle dépense", "Nouvelle entrée"];
  late String curr_type;
  late TextEditingController amount_controller;
  late TextEditingController title_controller;
  late TextEditingController date_controller;

  late bool wasIncoming;

  @override
  void initState() {
    wasIncoming = widget.model.isIncoming;
    curr_type = !widget.model.isIncoming ? list.first : list.last;

    amount_controller =
        TextEditingController(text: widget.model.amount.toString());
    title_controller = TextEditingController(text: widget.model.title);
    date_controller = TextEditingController(text: widget.model.date);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ThemeCol.mainColor.withOpacity(.3),
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            editTransac();
          },
          onLongPress: () {
            confirmdialog(
              context,
              text: "Supprimer '${widget.model.title}'",
              onOk: () {
                widget.model.parent?.incomesList.remove(widget.model);
                widget.model.parent?.expensesList.remove(widget.model);
                widget.model.parent?.save().then((value) {
                  if (Settings.alwaysconfirm) Navigator.pop(context);
                  widget.fresh();
                  reload();
                });
              },
            );
          },
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title +
                        (widget.model.parent != null
                            ? " (${widget.model.parent?.title}) "
                            : ""),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.showDate)
                        Text(
                          widget.model.date,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(.4),
                            fontSize: 13,
                          ),
                        )
                      else
                        Spacer(),
                      Text(
                        (widget.model.amount == 0
                                ? ""
                                : widget.model.isIncoming
                                    ? "+"
                                    : "-") +
                            " ${widget.model.amount}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: widget.model.isIncoming
                                ? ThemeCol.mainColor
                                : Color.fromARGB(255, 220, 35, 22)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editTransac() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        curr_type = !widget.model.isIncoming ? list.first : list.last;

        amount_controller =
            TextEditingController(text: widget.model.amount.toString());
        title_controller = TextEditingController(text: widget.model.title);
        date_controller = TextEditingController(text: widget.model.date);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: DropdownButton<String>(
                value: curr_type,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      list.first,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: list.first,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      list.last,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: list.last,
                  ),
                ],
                onChanged: (e) {
                  setState(() {
                    curr_type = e ?? curr_type;
                  });
                },
              ),
              backgroundColor: ThemeCol.bkgColor,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: title_controller,
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
                        // prefixText: "Titre : ",
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
                    Gap(10),
                    TextField(
                      controller: amount_controller,
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
                          'Montant : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        floatingLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeCol.mainColor,
                        ),
                        suffixText: "FCFA",
                      ),
                    ),
                    Gap(10),
                    TextField(
                      controller: date_controller,
                      scrollPhysics: BouncingScrollPhysics(),
                      keyboardType: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                          confirmText: "Confirmer",
                          cancelText: "Annuler",
                          helpText: "Sélectionnez la date de la transaction",
                          //TODO locale: Locale("fr"),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(DateTime.now().year + year_limit),
                        ).then((value) {
                          if (value == null) return;

                          date_controller.text = AppDateUtils.toFr(value);
                        });
                      },
                      readOnly: true,
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
                          'Date : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        floatingLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeCol.mainColor,
                        ),
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
                    'Enregistrer',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.model.title = title_controller.text;
                    widget.model.date = date_controller.text;
                    widget.model.amount = double.parse(amount_controller.text);
                    widget.model.isIncoming = curr_type == list.last;

                    // newmodel.add(hm);
                    if (wasIncoming && !widget.model.isIncoming) {
                      widget.model.parent?.incomesList.remove(widget.model);
                      widget.model.parent?.expensesList.add(widget.model);
                    } else if (!wasIncoming && widget.model.isIncoming) {
                      widget.model.parent?.expensesList.remove(widget.model);
                      widget.model.parent?.incomesList.add(widget.model);
                    }
                    if (widget.model.parent?.box != null) {
                      widget.model.parent?.save().then((value) {
                        Navigator.pop(context);

                        widget.fresh();
                        setState(() {});

                        reload();
                      });
                    } else {
                      Navigator.pop(context);
                      widget.fresh();
                      setState(() {});
                    }
                    // save();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
