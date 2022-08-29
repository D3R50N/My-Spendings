import 'package:flutter_application_1/models/spendingsmodel.dart';
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
  
  HistoryModel(this.title, this.date, this.amount,
      {this.isIncoming = false});
}
