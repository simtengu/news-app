import 'package:flutter/material.dart';
import 'package:news_app/features/posts/widgets/post_loading_card.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/common/round_skeleton.dart';
import '../../posts/widgets/post_filter_loading_card.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),

          const RecommendedPostsLoader(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: RoundSkeleton(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
                  borderRadius: 10),
            ),
          ),

          // breaking news slider...............................................

          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 41,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(
                  width: 7,
                ),
                PostFilterLoadingCard(),
                SizedBox(
                  width: 4,
                ),
                PostFilterLoadingCard(),
                SizedBox(
                  width: 4,
                ),
                PostFilterLoadingCard(),
                SizedBox(
                  width: 4,
                ),
                PostFilterLoadingCard(),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          const RecommendedPostsLoader(),
          const SizedBox(
            height: 10,
          ),

          const PostLoadingCard(),
          const PostLoadingCard(),
          const PostLoadingCard(),
        ],
      ),
    );
  }
}

class RecommendedPostsLoader extends StatelessWidget {
  const RecommendedPostsLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: RoundSkeleton(
                width: MediaQuery.of(context).size.width * 0.30,
                height: 10,
                borderRadius: 10),
          ),
          Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: RoundSkeleton(
                width: MediaQuery.of(context).size.width * 0.1,
                height: 10,
                borderRadius: 10),
          ),
        ],
      ),
    );
  }
}
