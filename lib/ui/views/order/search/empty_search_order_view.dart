import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptySearchOrderView extends StatelessWidget {
  const EmptySearchOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SvgPicture.asset('assets/images/img_search_no_result.svg'),
            const SizedBox(height: 24),
            Text(
              'Campaign yang kamu cari tidak ditemukan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Coba lakukan pencarian dengan kata kunci yang lain',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
