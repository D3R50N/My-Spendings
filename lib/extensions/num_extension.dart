extension NumExtension on num {
  String twoDigit() {
    return this < 10 ? "0" + toString() : toString();
  }

  bool get hasDecimal {
    return round() != this;
  }

  num toIntOrDouble() {
    return hasDecimal ? this : round();
  }
}
