import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/common/round_skeleton.dart';
class PostFilterLoadingCard extends StatelessWidget {
  const PostFilterLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return                 Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: RoundSkeleton(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: 40,
                      borderRadius: 30),
                );
  }
}