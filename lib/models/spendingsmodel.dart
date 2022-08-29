import 'package:flutter_application_1/models/historymodel.dart';
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
  final String title;

  @HiveField(2)
  final String devise;

  SpendingsModel(
    this.capital, {
    this.devise = "FCFA",
    this.title = "Dépenses",
  }) {
    add(HistoryModel("Capital", DateTime.now().toString(), capital),
        type: true);
  }

  void add(HistoryModel amount, {type = false}) {
    if (type) {
      incomesList.add(amount);
    } else {
      expensesList.add(amount);
    }
  }

  void edit(int index, HistoryModel value, {type = false}) {
    if (type) {
      expensesList[index] = value;
    } else {
      incomesList[index] = value;
    }
  }

  void clearAll() {
    incomesList = [];
    expensesList = [];
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
    var splitted = amount.toString().split("").reversed;
    for (var i = 0; i < splitted.length; i++) {
      ret += splitted.elementAt(i);
      counter++;
      if (counter > 2 && i != splitted.length - 1) {
        ret += " ";
        counter = 0;
      }
    }
    return ret.split("").reversed.join() + " " + devise;
  }

  
}
