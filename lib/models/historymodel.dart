import 'package:flutter_application_1/models/spendingsmodel.dart';
import 'package:flutter_application_1/utils/globals.dart';
import 'package:hive/hive.dart';

part 'historymodel.g.dart';

@HiveType(typeId: 1)
class HistoryModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double amount;

  @HiveField(2)
  final bool isIncoming;

  @HiveField(3)
  final String date;

  SpendingsModel? parent;

  HistoryModel(this.title, this.date, this.amount,
      {this.isIncoming = false, this.parent});

  static Future<List<HistoryModel>> all() async {
    List<HistoryModel> list = [];
    for (var element in spendingsBox.values) {
      list.addAll(element.incomesList);
      list.addAll(element.expensesList);

      for (var history in element.incomesList) {
        history.parent = element;
      }
      for (var history in element.expensesList) {
        history.parent = element;
      }
    }
    return list;
  }
}
