import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/themes/app_colors.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    this.hintText = 'Search...',
    required this.delegate,
  }) : super(key: key);

  final String hintText;
  final SearchDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: TextField(
        readOnly: true,
        onTap: () => showSearch(context: context, delegate: delegate),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: AppColors.systemDarkGrey),
          hintText: hintText,
        ),
      ),
    );
  }
}
