extension StringNullExtension on String? {
  bool get isZeroOrEmpty {
    return this == null || this == '0';
  }

  bool get isNullOrEmpty {
    return this == null || this == '';
  }

  bool get isNotNullAndNotEmpty {
    return this != null && this != '' && this != 'null';
  }
}