enum AmountType { income, expense }

class SpendingsModel {
  List<double> incomesList = [], expensesList = [];
  String devise = "FCFA", title = "Dépenses";

  void add(double amount, {type = AmountType.expense}) {
    if (type == AmountType.income) {
      expensesList.add(amount);
    } else {
      incomesList.add(amount);
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
    return 0;
  }

  double get expense {
    return 0;
  }
}
