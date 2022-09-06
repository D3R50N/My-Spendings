// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:flutter_application_1/widgets/spendingscard.dart';

class NewPlanif extends StatefulWidget {
  const NewPlanif({Key? key}) : super(key: key);

  @override
  State<NewPlanif> createState() => _NewPlanifState();
}

class _NewPlanifState extends State<NewPlanif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkgColor,
      appBar: AppBar(
        elevation: 0,
        // centerTitle: true,
        backgroundColor: mainColor,
        title: Text(newmodel.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.save_alt_outlined),
              onPressed: () {
                //NOTE Enlever le dialogue avant d'afficher la page
                // Navigator.of(context).pop();
                spendingsBox.add(newmodel).then((value) {
                  pushRoute(context, Routes.home);
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SpendingsCard(
            newmodel,
            showTitle: false,
          ),
        ],
      ),
    );
  }
}
