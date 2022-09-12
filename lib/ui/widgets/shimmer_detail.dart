import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetail extends StatelessWidget {
  const ShimmerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300] ?? Colors.grey,
        highlightColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildItem(width: double.infinity, height: 200),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildItem(width: 130, height: 18),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildItem(width: 195, height: 18),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildItem(width: 80, height: 18),
                        ],
                      ),
                      _buildItem(width: 30, height: 30)
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildItem(width: double.infinity, height: 60),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildItem(width: 110, height: 110, radius: 10),
                      _buildItem(width: 110, height: 110, radius: 10),
                      _buildItem(width: 110, height: 110, radius: 10),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildItem(width: double.infinity, height: 150),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildItem({
    required double width,
    required double height,
    double? radius,
  }) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          color: Colors.white,
        ),
      );
}
