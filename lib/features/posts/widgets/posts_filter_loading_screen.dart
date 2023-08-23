import 'package:flutter/material.dart';
import 'package:news_app/features/posts/widgets/post_loading_card.dart';

import '../../home/widgets/home_loading_screen.dart';

class PostsFilterLoadingScreen extends StatelessWidget {
  const PostsFilterLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            RecommendedPostsLoader(),
            SizedBox(
              height: 10,
            ),
            PostLoadingCard(),
            PostLoadingCard(),
            PostLoadingCard(),
            PostLoadingCard(),
            PostLoadingCard(),
            PostLoadingCard(),
          ],
        ),
      ),
    );
  }
}
