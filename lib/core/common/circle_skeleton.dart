import 'package:flutter/material.dart';
class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, required this.size});
   final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
 width: size,
 height: size,
 decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.04),
  shape: BoxShape.circle,
 ),
    );
  }
}