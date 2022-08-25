enum AmountType { income, expense }

class SpendingsModel {
  List<double> incomesList = [], expensesList = [];
  final String devise, title;
  final double capital;

  SpendingsModel(
    this.capital, {
    this.devise = "FCFA",
    this.title = "Dépenses",
  }) {
    add(capital, type: AmountType.income);
  }

  void add(double amount, {type = AmountType.expense}) {
    if (type == AmountType.income) {
      incomesList.add(amount);
    } else {
      expensesList.add(amount);
    }
  }

  void edit(int index, double value, {type = AmountType.expense}) {
    if (type == AmountType.income) {
      expensesList[index] = value;
    } else {
      incomesList[index] = value;
    }
  }

  void clearAll() {
    incomesList = [];
    expensesList = [];
  }

  double get solde {
    return income - expense;
  }

  double get income {
    double sum = 0;
    for (var income in incomesList) {
      sum += income;
    }
    return sum;
  }

  double get expense {
    double sum = 0;
    for (var expense in expensesList) {
      sum += expense;
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
