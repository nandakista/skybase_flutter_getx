extension StringExtension on String {
  String get capitalize {
    return split(' ')
        .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
        .join(' ');
  }

  String get toSnakeCase {
    return replaceAll(' ', '_')
        .toLowerCase()
        .split(' ')
        .map((e) => '${e[0].toLowerCase()}${e.substring(1)}')
        .join(' ');
  }

  String get snakeToNormalCase {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((e) => '${e[0]}${e.substring(1)}')
        .join(' ');
  }

  String get fixJsonString {
    return replaceAll('{', '{"')
        .replaceAll(': ', '": "')
        .replaceAll(', ', '", "')
        .replaceAll('}', '"}');
  }
}

extension StringNullExtension on String? {
  String? removeLast({int count = 1}) {
    if (this != null && (this?.length ?? 0) > 0) {
      return this?.substring(0, this!.length - count);
    }
    return this;
  }

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
