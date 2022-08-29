// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spendingsmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpendingsModelAdapter extends TypeAdapter<SpendingsModel> {
  @override
  final int typeId = 0;

  @override
  SpendingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpendingsModel(
      fields[0] as double,
      devise: fields[2] as String,
      title: fields[1] as String,
    )
      ..incomesList = (fields[6] as List).cast<HistoryModel>()
      ..expensesList = (fields[7] as List).cast<HistoryModel>();
  }

  @override
  void write(BinaryWriter writer, SpendingsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(6)
      ..write(obj.incomesList)
      ..writeByte(7)
      ..write(obj.expensesList)
      ..writeByte(0)
      ..write(obj.capital)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.devise)
      ..writeByte(3)
      ..write(obj.solde)
      ..writeByte(4)
      ..write(obj.income)
      ..writeByte(5)
      ..write(obj.expense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
