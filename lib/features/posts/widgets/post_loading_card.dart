import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/common/round_skeleton.dart';

class PostLoadingCard extends StatelessWidget {
  const PostLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            RoundSkeleton(
                width: MediaQuery.of(context).size.width * 0.30,
                height: 100,
                borderRadius: 10),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RoundSkeleton(width: 140, height: 13, borderRadius: 5),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const RoundSkeleton(
                        width: double.infinity, height: 13, borderRadius: 5),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .57,
                    child: const RoundSkeleton(
                        width: double.infinity, height: 13, borderRadius: 5),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    children: [
                      RoundSkeleton(width: 110, height: 13, borderRadius: 5),
                      SizedBox(
                        width: 6,
                      ),
                      RoundSkeleton(width: 110, height: 13, borderRadius: 5),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
