import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformLoadingIndicator extends StatelessWidget {
  const PlatformLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(child: CupertinoActivityIndicator(radius: 16));
    }
  }
}