import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/core/dummy_data.dart';
import 'package:news_app/features/posts/widgets/post_card.dart';

import '../models/post_model.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            '33 Saved Articles',
            style: GoogleFonts.cabin(
                fontWeight: FontWeight.bold, fontSize: AppConstants.body1),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: ((context, index) =>
                // const ListTile(
                //       title: Text('hello'),
                //     )),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Stack(
                    children: [
                      PostCard(
                        post: Post(
                            author: 'albert oscar',
                            title: 'here is a dummy post',
                            description: 'here is a simple desc',
                            source: 'CNN news',
                            imageUrl:
                                'https://media.tenor.com/PrBIxJ_-zswAAAAj/awesome-smiley-guy.gif',
                            category: 'sports',
                            country: 'us',
                            publishedAt: '33 jun'),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: IconButton(
                          onPressed: () {},
                          color: AppConstants.danger,
                          icon: const Icon(Icons.remove_circle),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
