import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme? get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}