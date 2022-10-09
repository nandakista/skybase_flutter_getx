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

  /// Convert string Indonesian Currency to int.
  ///
  /// The required format string is "Rp 0.000..."
  /// the return is [Int]
  /// * Example : Rp 1.000 (String) --> 1000
  int fromStringIDR() {
    return int.tryParse(substring(3, length).replaceAll('.', '')) ?? 0;
  }
}