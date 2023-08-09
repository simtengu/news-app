import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/posts/views/post_details.dart';

import '../models/post_model.dart';

class BreakingNewsListItem extends StatelessWidget {
  final Post post;
  const BreakingNewsListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>  PostDetailsScreen(post: post,),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(1),
        width: MediaQuery.of(context).size.width * 0.88,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.28,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12.0).copyWith(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(1)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.description,
                      maxLines: 3,
                      style: GoogleFonts.cabin(
                        height: 1.2,
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: AppConstants.bgPrimary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  post.category,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
