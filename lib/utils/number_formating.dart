extension NumberFormattingString on String {
  String formatNumberWithCommas() {
    String numberString = this;
    String separatedNumber = '';

    int count = 0;
    for (int i = numberString.length - 1; i >= 0; i--) {
      separatedNumber = numberString[i] + separatedNumber;
      count++;

      if (count % 3 == 0 && i != 0) {
        separatedNumber = ',$separatedNumber';
      }
    }

    return separatedNumber;
  }
}

extension NumberFormattingInt on int {
  String formatNumberWithCommas() {
    String numberString = toString();
    String separatedNumber = '';

    int count = 0;
    for (int i = numberString.length - 1; i >= 0; i--) {
      separatedNumber = numberString[i] + separatedNumber;
      count++;

      if (count % 3 == 0 && i != 0) {
        separatedNumber = ',$separatedNumber';
      }
    }

    return separatedNumber;
  }
}
