import 'package:flutter_application_1/extensions/num_extension.dart';

extension StringExtension on String {
  bool get empty {
    return trim().isEmpty;
  }

  int toInt() {
    return int.parse(this);
  }

  double toDouble() {
    return double.parse(this);
  }

  num toIntOrDouble() {
    return toDouble().toIntOrDouble();
  }
}
