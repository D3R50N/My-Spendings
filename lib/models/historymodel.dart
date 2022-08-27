import 'package:flutter_application_1/models/spendingsmodel.dart';

class HistoryModel {
  final String title, date;
  final double amount;
  final AmountType type;

  HistoryModel(this.title, this.date, this.amount,
      {this.type = AmountType.expense});
}
