import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/posts/models/post_model.dart';
import 'package:news_app/features/posts/widgets/post_card.dart';
import 'package:news_app/features/posts/widgets/posts_filter_item.dart';


class FilteredPostsScreen extends StatelessWidget {
  const FilteredPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                decoration: BoxDecoration(
                    color: AppConstants.bgPrimary,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'All',
                  style: GoogleFonts.cabin(color: Colors.white),
                ),
              ),
              const PostsFilterItem(
                category: 'sports',
              ),
              const PostsFilterItem(
                category: 'education',
              ),
              const PostsFilterItem(
                category: 'politics',
              ),
              const PostsFilterItem(
                category: 'entertainment',
              ),
              const PostsFilterItem(
                category: 'environment',
              ),
              const PostsFilterItem(
                category: 'economics',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            '33 Available Articles',
            style: GoogleFonts.cabin(
                fontWeight: FontWeight.bold, fontSize: AppConstants.body1),
          ),
        ),
        const SizedBox(
          height: 10,
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
                  child: PostCard(
                    post: Post(
                        author: 'albert oscar',
                        title: 'here is a dummy post',
                        description: 'here is a simple desc',
                        source: 'CNN news',
                        imageUrl: 'https://media.tenor.com/PrBIxJ_-zswAAAAj/awesome-smiley-guy.gif',
                        category: 'sports',
                        country: 'us',
                        publishedAt: '33 jun'),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
