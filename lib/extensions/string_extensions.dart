extension StringExtension on String {
  bool get empty {
    return trim().isEmpty;
  }

  int toInt() {
    return int.parse(this);
  }
}
