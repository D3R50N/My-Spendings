import 'package:flutter_application_1/extensions/num_extension.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/utils/date_utils.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:hive/hive.dart';
part 'spendingsmodel.g.dart';

@HiveType(typeId: 0)
class SpendingsModel extends HiveObject {
  @HiveField(6)
  List<HistoryModel> incomesList = [];
  @HiveField(7)
  List<HistoryModel> expensesList = [];

  @HiveField(0)
  final double capital;

  @HiveField(1)
  late String title;

  @HiveField(2)
  final String devise;

  SpendingsModel(
    this.capital, {
    this.devise = "FCFA",
    this.title = "Dépenses",
  }) {
    add(HistoryModel("Capital", AppDateUtils.toFr(DateTime.now()), capital,
        isIncoming: true));
  }

  void add(
    HistoryModel amount,
  ) {
    if (amount.isIncoming) {
      incomesList.add(amount);
    } else {
      expensesList.add(amount);
    }
  }

  void edit(int index, HistoryModel value, {expense = true}) {
    if (expense) {
      expensesList[index] = value;
    } else {
      incomesList[index] = value;
    }
  }

  void clearAll() {
    incomesList = [];
    expensesList = [];
  }

  static Future<List<SpendingsModel>> all() async {
    List<SpendingsModel> list = [];
    for (var element in spendingsBox.values) {
      list.add(element);
    }
    return list;
  }

  List<HistoryModel> get filteredHistory {
    List<HistoryModel> list = [];
    for (var element in incomesList) {
      list.add(element);
    }
    for (var element in expensesList) {
      list.add(element);
    }
    list.sort((a, b) {
      return AppDateUtils.fromStr(b.date)
          .compareTo(AppDateUtils.fromStr(a.date));
    });
    return list;
  }

  @HiveField(3)
  double get solde {
    return income - expense;
  }

  @HiveField(4)
  double get income {
    double sum = 0;
    for (var income in incomesList) {
      sum += income.amount;
    }
    return sum;
  }

  @HiveField(5)
  double get expense {
    double sum = 0;
    for (var expense in expensesList) {
      sum += expense.amount;
    }
    return sum;
  }

  String get strIncome => str(income);
  String get strExpense => str(expense);
  String get strSolde => str(solde);

  String str(double amount) {
    String ret = "";
    int counter = 0;
    bool hasDecimal = amount.toIntOrDouble().ceil().toDouble() != amount;
    var splitted = amount.toIntOrDouble().toString().split("").reversed;
    if (hasDecimal) {
      splitted = amount.toString().split(".").first.split("").reversed;
    }
    for (var i = 0; i < splitted.length; i++) {
      ret += splitted.elementAt(i);
      if (splitted.elementAt(i) == ".") continue;
      counter++;
      if (counter > 2 && i != splitted.length - 1) {
        ret += " ";
        counter = 0;
      }
    }
    if (hasDecimal) {
      ret =
          ("." + amount.toString().split(".").last).split("").reversed.join() +
              ret;
    }
    return ret.split("").reversed.join() + " " + devise;
  }
}
