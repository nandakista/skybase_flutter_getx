import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerText extends StatelessWidget {
  const ShimmerText({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 10,
      color: Get.isDarkMode ? Colors.black54 : Colors.white,
    );
  }
}
