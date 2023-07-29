import 'package:flutter/material.dart';

class GradientColor {
  static Gradient gradientType1 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black.withOpacity(0.7)]
  );

  static Gradient gradientType2 = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xff003EA1), Color(0xff9F0077)]
  );

  static LinearGradient gradient1(Color colorStart, Color colorEnd) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: const GradientRotation(1),
      colors: <Color>[
        colorStart,
        colorEnd.withOpacity(0.5),
        colorEnd.withOpacity(0.75),
        colorEnd,
        colorEnd,
      ],
      tileMode: TileMode.decal,
    );
  }

  static LinearGradient gradient2(Color colorStart, Color colorEnd) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: const GradientRotation(1),
      colors: <Color>[
        colorStart,
        colorEnd.withOpacity(0.65),
        colorEnd.withOpacity(0.85),
        colorEnd,
        colorEnd,
        colorEnd,
      ],
      tileMode: TileMode.decal,
    );
  }

  static LinearGradient gradient3(Color colorStart, Color colorEnd) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        colorStart,
        colorStart.withOpacity(0.70),
        colorStart.withOpacity(0.80),
        colorStart.withOpacity(0.90),
        colorEnd,
        colorEnd,
        colorEnd,
        colorEnd,
        colorEnd,
        colorEnd.withOpacity(0.85),
      ],
      tileMode: TileMode.decal,
    );
  }

  static LinearGradient gradientCircle(Color color) {
    return LinearGradient(
      transform: const GradientRotation(1),
      colors: <Color>[
        color.withOpacity(0.75),
        color.withOpacity(0.85),
        color.withOpacity(0.90),
        color.withOpacity(0.95),
        color.withOpacity(0.95),
      ],
      tileMode: TileMode.decal,
    );
  }
}
