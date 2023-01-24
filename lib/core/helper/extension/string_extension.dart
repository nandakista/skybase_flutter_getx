extension StringExtension on String {
  String capitalize() {
    return split(' ')
        .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
        .join(' ');
  }

  String toSnakeCase() {
    return replaceAll(' ', '_')
        .toLowerCase()
        .split(' ')
        .map((e) => '${e[0].toLowerCase()}${e.substring(1)}')
        .join(' ');
  }

  String snakeToNormalCase() {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((e) => '${e[0]}${e.substring(1)}')
        .join(' ');
  }
}

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