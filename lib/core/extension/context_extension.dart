import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme? get colorScheme => Theme.of(this).colorScheme;
}