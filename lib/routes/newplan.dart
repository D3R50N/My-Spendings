// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/date_utils.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:flutter_application_1/widgets/historycard.dart';
import 'package:flutter_application_1/widgets/spendingscard.dart';
import 'package:gap/gap.dart';

class NewPlanif extends StatefulWidget {
  const NewPlanif({Key? key}) : super(key: key);

  @override
  State<NewPlanif> createState() => _NewPlanifState();
}

class _NewPlanifState extends State<NewPlanif> {
  int year_limit = 1;

  List list = ["Nouvelle dépense", "Nouvelle entrée"];
  late String curr_type;

  TextEditingController amount_controller = TextEditingController();
  TextEditingController title_controller = TextEditingController();
  TextEditingController date_controller =
      TextEditingController(text: AppDateUtils.toFr(DateTime.now()));

  TextEditingController planif_name_controller = TextEditingController(
    text: newmodel.title,
  );
  String old_title = newmodel.title;

  int incomes_count = newmodel.incomesList.length;
  int expenses_count = newmodel.expensesList.length;

  bool get hasChanged {
    return newmodel.incomesList.length != incomes_count ||
        newmodel.expensesList.length != expenses_count ||
        newmodel.title != old_title ||
        true;
  }

  @override
  void initState() {
    curr_type = list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeCol.bkgColor,
      appBar: AppBar(
        elevation: 0,
        // centerTitle: true,
        backgroundColor: ThemeCol.mainColor,
        title: GestureDetector(
            child: Text(old_title),
            onTap: () {
              rename();
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: hasChanged
                  ? Badge(
                      badgeContent: Text(
                        '',
                      ),
                      child: Icon(Icons.save_alt_outlined),
                    )
                  : Icon(Icons.save_alt_outlined),
              onPressed: () {
                newmodel.title = old_title;

                spendingsBox.add(newmodel).then((value) {
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context);
                  } //NOTE Revenir sur la page précédente
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context);
                  } //NOTE Enlever le dialog
                  Navigator.pushReplacementNamed(
                      context, Routes.home); //Remplacer la page
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpendingsCard(
            newmodel,
            showTitle: false,
            showEditBtn: false,
            onDelete: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size.fromHeight(40),
                padding: EdgeInsets.all(18),
                side: BorderSide(color: ThemeCol.mainColor, width: 2),
              ),
              child: Text(
                'Ajouter une transaction',
                style: TextStyle(color: ThemeCol.mainColor),
              ),
              onPressed: () {
                newTransac();
              },
            ),
          ),
          Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.history, color: ThemeCol.mainColor),
                Gap(3),
                Text(
                  'Historique des transactions',
                  style: TextStyle(
                      color: ThemeCol.mainColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ...newmodel.filteredHistory.map((e) {
                  e.parent = newmodel;
                  return HistoryCard(
                    e,
                    showDate: true,
                    fresh: () {
                      setState(() {});
                    },
                  );
                }).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void save() {
    Navigator.of(context).pop();
    amount_controller.text = "";
    title_controller.text = "";
    date_controller.text = AppDateUtils.toFr(DateTime.now());
    setState(() {});
  }

  Future<void> newTransac() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
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
                    curr_type = e ?? "hd";
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
                    'Ajouter',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    HistoryModel hm = HistoryModel(
                      title_controller.text,
                      date_controller.text,
                      double.parse(amount_controller.text),
                      isIncoming: curr_type == list.last,
                    );
                    newmodel.add(hm);
                    save();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void rename() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nom de la planification"),
          backgroundColor: ThemeCol.bkgColor,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: planif_name_controller,
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
                Navigator.pop(context);
                setState(() {
                  old_title = planif_name_controller.text;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
