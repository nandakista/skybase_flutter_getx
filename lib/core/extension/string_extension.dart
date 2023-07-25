extension StringNullExtension on String? {
  bool isZeroOrEmpty() {
    return this == null || this == '0';
  }

  bool isNullOrEmpty() {
    return this == null || this == '';
  }

  bool isNotNullAndNotEmpty() {
    return this != null && this != '' && this != 'null';
  }
}