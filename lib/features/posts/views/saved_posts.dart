import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/posts/bloc/posts_bloc.dart';
import 'package:news_app/features/posts/widgets/post_card.dart';

import '../models/post_model.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  List<Post> savedPosts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostsBloc>(context).add(LoadSavedPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: ((context, state) {
        if (state is SavedPostsLoadedState) {
          savedPosts = state.posts;
        }

        if (state is PostSaveToggleState) {
          savedPosts = state.posts!;
        }
      }),
      builder: ((context, state) {
        if (savedPosts.isNotEmpty) {
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
                  '${savedPosts.length} Saved Articles',
                  style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.body1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: savedPosts.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Stack(
                          children: [
                            PostCard(
                              post: savedPosts[index],
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<PostsBloc>(context).add(
                                      PostSaveToggleEvent(
                                          isSaved: true,
                                          post: savedPosts[index]));
                                },
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
        } else {
          return const Center(
            child: Text(
              "You don't have any saved article",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: AppConstants.body1),
            ),
          );
        }
      }),
    );
  }
}
