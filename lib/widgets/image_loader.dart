import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmerLoadingState extends StatelessWidget {
  const ImageShimmerLoadingState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey.shade400,
      highlightColor: kTextColor,
      child: Container(
        decoration: BoxDecoration(color: kScaffoldColor),
      ),
    );
  }
}
