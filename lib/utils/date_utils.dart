import 'package:flutter_application_1/extensions/num_extension.dart';
import 'package:flutter_application_1/extensions/string_extensions.dart';

class AppDateUtils {
  static List daysFr = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche",
  ];
  static List monthFr = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre ",
    "Décembre ",
  ];

  static String toFr(DateTime dt, {bool withDay = true}) {
    String ret = "";
    if (withDay) {
      ret += daysFr[dt.weekday - 1];
      ret += " ";
    }
    ret += dt.day.twoDigit();
    ret += " ";
    ret += monthFr[dt.month - 1];
    ret += " ";
    ret += dt.year.toString();

    return ret;
  }

  static DateTime fromStr(String date) {
    var splitted = date.split(' ');
    int day = splitted[1].toInt();
    int month = monthFr.indexOf(splitted[2]) + 1;
    int year = splitted[3].toInt();

    return DateTime(year, month, day);
  }

}
