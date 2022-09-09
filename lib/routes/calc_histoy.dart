// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:gap/gap.dart';

class CalcHistoryPage extends StatefulWidget {
  const CalcHistoryPage({Key? key}) : super(key: key);

  @override
  State<CalcHistoryPage> createState() => _CalcHistoryPageState();
}

class _CalcHistoryPageState extends State<CalcHistoryPage> {
  List<ListTile> histories = [];

  @override
  void initState() {
    for (var element in calcHistoriesBox.values) {
      // histories.add(ListTile(
      //   title: Text(element),
      //   leading: Icon(Icons.history),
      //   tileColor: Colors.white,
      // ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeCol.bkgColor,
      appBar: AppBar(
        title: Text("Historique"),
        elevation: 0,
        backgroundColor: ThemeCol.mainColor,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (e) {
              calcHistoriesBox.clear().then((value) {
                setState(() {});
              });
            },
            padding: EdgeInsets.zero,
            itemBuilder: (context) {
              return ["Tout effacer"].map((String choice) {
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Builder(builder: (context) {
          if (calcHistoriesBox.isEmpty) {
            return Center(
              child: Text(
                "Aucun historique trouvé",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(20),
                ...calcHistoriesBox.values
                    .toList()
                    .reversed
                    .map((element) => Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(element[0]),
                            // leading: Icon(Icons.history),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            subtitle: Text(element[1]),
                            style: ListTileStyle.list,
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                calcHistoriesBox
                                    .deleteAt(calcHistoriesBox.values
                                        .toList()
                                        .indexOf(element))
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                        ))
                    .toList(),
                Gap(20),
              ],
            ),
          );
        }),
      ),
    );
  }
}
