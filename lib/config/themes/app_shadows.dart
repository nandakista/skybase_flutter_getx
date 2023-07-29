import 'package:flutter/material.dart';

class AppShadows {
  static BoxShadow shadow1 = const BoxShadow(
    color: Colors.black45,
    offset: Offset(0, 0),
    blurRadius: 1,
    spreadRadius: -1
  );
  
  static BoxShadow shadow2 = const BoxShadow(
    color: Colors.black45,
    offset: Offset(0, -4),
    blurRadius: 12,
    spreadRadius: -8
  );

  static BoxShadow shadow3 = const BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: -1
  );
  
  static BoxShadow shadow4 = const BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: -6
  );
}
