// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:gap/gap.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool autosave = Settings.autosave,
      autoscroll = Settings.autoscroll,
      alwaysconfirm = Settings.alwaysconfirm,
      lock = Settings.lock;

  String old_name = Settings.username;
  String old_code = Settings.lockcode;

  late TextEditingController name_controller, lock_controller;
  bool get nameIsSaved => old_name == name_controller.text;
  bool show_code = false;

  @override
  void initState() {
    name_controller = TextEditingController(text: old_name);
    lock_controller = TextEditingController(text: lock ? old_code : "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeCol.mainColor,
        title: GestureDetector(
          child: Text('Paramètres'),
          onTap: () {
            pushRoute(context, "/");
          },
        ),
      ),
      backgroundColor: ThemeCol.bkgColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListBody(
            children: [
              title("Préférences"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Settings.setsave(!autosave).then((value) {
                            setState(() {
                              autosave = !autosave;
                            });
                          });
                        },
                        child: Text(
                          "Sauvegarde automatique",
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: autosave,
                      onChanged: (val) {
                        Settings.setsave(val).then((value) {
                          setState(() {
                            autosave = val;
                          });
                        });
                      },
                      activeColor: ThemeCol.mainColor,
                      focusColor: ThemeCol.mainColor,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Settings.setscroll(!autoscroll).then((value) {
                            setState(() {
                              autoscroll = !autoscroll;
                            });
                          });
                        },
                        child: Text(
                          "Défilement automatique",
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: autoscroll,
                      onChanged: (val) {
                        Settings.setscroll(val).then((value) {
                          setState(() {
                            autoscroll = val;
                          });
                        });
                      },
                      activeColor: ThemeCol.mainColor,
                      focusColor: ThemeCol.mainColor,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Settings.setconfirm(!alwaysconfirm).then((value) {
                            setState(() {
                              alwaysconfirm = !alwaysconfirm;
                            });
                          });
                        },
                        child: Text(
                          "Toujours confirmer avant suppression",
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: alwaysconfirm,
                      onChanged: (val) {
                        Settings.setconfirm(val).then((value) {
                          setState(() {
                            alwaysconfirm = val;
                          });
                        });
                      },
                      activeColor: ThemeCol.mainColor,
                      focusColor: ThemeCol.mainColor,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Settings.setlock(!lock).then((value) {
                            setState(() {
                              lock = !lock;
                              lock_controller.text = lock ? old_code : "";
                            });
                          });
                        },
                        child: Text(
                          "Vérouiller l'application",
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: lock,
                      onChanged: (val) {
                        Settings.setlock(val).then((value) {
                          setState(() {
                            lock = val;
                            lock_controller.text = lock ? old_code : "";
                          });
                        });
                      },
                      activeColor: ThemeCol.mainColor,
                      focusColor: ThemeCol.mainColor,
                    ),
                  ],
                ),
              ),
              Gap(10),
              title("Profil"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Gap(20),
              TextField(
                controller: name_controller,
                scrollPhysics: BouncingScrollPhysics(),
                onChanged: (t) {
                  setState(() {});
                },
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
                  suffix: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (nameIsSaved) return;
                      Settings.setname(name_controller.text).then((value) {
                        setState(() {
                          old_name = Settings.username;
                        });
                        reload();
                        // print("jd");
                      });
                    },
                    highlightColor: Colors.transparent,
                    splashColor:
                        ThemeCol.mainColor.withOpacity(nameIsSaved ? 0 : .1),
                    icon: Icon(
                      nameIsSaved ? Icons.check_rounded : Icons.save,
                      color: ThemeCol.mainColor,
                    ),
                  ),
                  label: Text("Nom d'utilisateur : "),
                  floatingLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeCol.mainColor,
                  ),
                ),
              ),
              Gap(20),
              TextField(
                controller: lock_controller,
                keyboardType: TextInputType.number,
                scrollPhysics: BouncingScrollPhysics(),
                onChanged: (t) {
                  Settings.setlockcode(lock_controller.text).then((value) {
                    setState(() {
                      old_code = Settings.lockcode;
                    });
                  });
                },
                enabled: lock,
                obscureText: !show_code,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      lock ? Colors.white : ThemeCol.mainColor.withOpacity(.3),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                  ),

                  disabledBorder: OutlineInputBorder(
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
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        show_code = !show_code;
                      });
                    },
                    highlightColor: Colors.transparent,
                    splashColor:
                        ThemeCol.mainColor.withOpacity(nameIsSaved ? 0 : .1),
                    icon: Icon(
                      show_code ? Icons.visibility : Icons.visibility_off,
                      color: ThemeCol.mainColor,
                    ),
                  ),
                  label: Text(lock
                      ? "Code de vérouillage : "
                      : "Aucun code de vérouillage"),
                  floatingLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeCol.mainColor,
                  ),
                ),
              ),
              //SECTION Bas
              Gap(10),
              title("Thèmes"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Gap(5),
              Center(
                child: Wrap(
                  children: ThemeCol.mainColors.map((e) {
                    var idx = ThemeCol.mainColors.indexOf(e);
                    if (idx < 2) {
                      return themeCard(idx, isPro: false);
                    }

                    return themeCard(idx);
                  }).toList(),
                ),
              ),
              // bottomSheet(width: 0),
            ],
          ),
        ),
      ),
      bottomSheet: bottomSheet(),
    );
  }

  Widget themeCard(int theme, {bool isPro = true}) {
    return GestureDetector(
      onTap: () {
        if (isPro) {
          errordialog(context, text: "Disponible dans la version pro !");
          return;
        }

        ThemeCol.setTheme(theme).then((value) {
          setState(() {});
        });
      },
      child: Stack(
        children: [
          SizedBox(
            width: width(context) / 6,
            height: width(context) / 6,
            child: Card(
              color: theme < ThemeCol.mainColors.length
                  ? ThemeCol.mainColors[theme]
                  : ThemeCol.mainColors.first,
            ),
          ),
          if (isPro)
            SizedBox(
              width: width(context) / 6,
              height: width(context) / 6,
              child: Card(
                color: Colors.black.withOpacity(.2),
                child: Center(
                  child: Text(
                    "PRO",
                    style: TextStyle(
                      color: Color.fromARGB(184, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget bottomSheet({double width = 2}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top:
            BorderSide(color: ThemeCol.mainColor.withOpacity(.3), width: width),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.share,
                    color: ThemeCol.mainColor,
                    size: 18,
                  ),
                  Gap(5),
                  Text("Partager",
                      style:
                          TextStyle(color: ThemeCol.mainColor, fontSize: 18)),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.comment,
                    color: ThemeCol.mainColor,
                    size: 18,
                  ),
                  Gap(5),
                  Text("FeedBack",
                      style:
                          TextStyle(color: ThemeCol.mainColor, fontSize: 18)),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: ThemeCol.mainColor,
                    size: 18,
                  ),
                  Gap(5),
                  Text(
                    "PRO",
                    style: TextStyle(color: ThemeCol.mainColor, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text title(String text) {
    return Text(
      text,
      style: TextStyle(
        color: ThemeCol.mainColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
