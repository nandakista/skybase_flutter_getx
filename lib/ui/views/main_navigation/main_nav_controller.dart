import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavController extends GetxController {
  RxInt index = 0.obs;
  PageController pageController = PageController(initialPage: 0);

}