import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/posts/views/post_details.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/constants.dart';

import '../bloc/posts_bloc.dart';
import '../models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.1),
      child: Builder(builder: (context) {
        return BlocConsumer<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is NavigateToPostDetailsState) {
              //navigate to post details screen..........................
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostDetailsScreen(
                    post: post,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return InkWell(
              onTap: () => Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => PostDetailsScreen(
                        post: post,
                      ),
                    ),
                  )
                  .then((value) => BlocProvider.of<PostsBloc>(context)
                      .add(PostDetailsScreenPopedOutEvent())),
              child: Container(
                padding: const EdgeInsets.all(1),
                margin: const EdgeInsets.symmetric(vertical: 4),
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              '${AppConstants.imgPath}loaderImg.gif'),
                          image: NetworkImage(post.imageUrl),
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: 100,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.category,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            post.title,
                            maxLines: 3,
                            style: GoogleFonts.cabin(
                                height: 1.2,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text(
                                  post.author.length > 20
                                      ? '${post.author.substring(0, 20)}... , '
                                      : '${post.author} , ',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  DateFormat.yMMMMd()
                                      .format(DateTime.parse(post.publishedAt)),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
