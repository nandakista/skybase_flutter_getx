import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_colors.dart';
import 'package:skybase/core/themes/app_style.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  const CustomBottomNavBar({
    Key? key,
    this.selectedIndex = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(3, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildItem('Menu 1', CupertinoIcons.book, 0),
          buildItem('Menu 2', CupertinoIcons.home, 1),
          buildItem('Menu 3', CupertinoIcons.map, 2),
        ],
      ),
    );
  }

  Widget buildItem(String name, IconData icon, int index) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: ((selectedIndex == index) ? 35 : 25),
            color: ((selectedIndex == index) ? AppColors.primary : Colors.grey),
          ),
          Text(
            name,
            style: (selectedIndex == index)
                ? AppStyle.headline3.copyWith(fontSize: 10)
                : AppStyle.subtitle4.copyWith(fontSize: 10),
          )
        ],
      ),
    );
  }
}
