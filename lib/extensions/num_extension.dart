extension NumExtension on num {
  String twoDigit() {
    return this < 10 ? "0" + toString() : toString();
  }
}
