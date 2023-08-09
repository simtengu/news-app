import 'package:flutter/material.dart';

class RoundSkeleton extends StatelessWidget {
  const RoundSkeleton(
      {super.key,
      required this.width,
      required this.height,
      required this.borderRadius});
  final double width, height, borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.04),
          // shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}
