import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/common/error_screen.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/posts/bloc/posts_bloc.dart';
import 'package:news_app/features/posts/views/post_details.dart';

import '../models/post_model.dart';

class SearchPostScreen extends StatefulWidget {
  const SearchPostScreen({super.key});

  @override
  State<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  final TextEditingController _searchTermController = TextEditingController();
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(SearchPostsInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _searchTermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {
          // if (state is ClearSearchFieldState) {
          //   _searchTermController.text = "";
          //   print('clearing search term');
          // }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                color: AppConstants.bgSecondaryLight,
                child: TextField(
                  controller: _searchTermController,
                  autofocus: true,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      postsBloc.add(SearchPostsEvent(searchTerm: value.trim()));
                    } else {
                      postsBloc.add(SearchPostsInitialEvent());
                    }
                  },
                  style: const TextStyle(fontSize: AppConstants.body1),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Search....',
                    prefix: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    suffix: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        postsBloc.add(ClearSearchFieldEvent());
                        _searchTermController.text = "";
                      },
                    ),
                  ),
                ),
              ),
              if (state is SearchPostsResultState &&
                  state.matchedPosts.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.matchedPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Post post = state.matchedPosts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostDetailsScreen(
                                post: post,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppConstants.bgSecondaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          margin: const EdgeInsets.only(
                              bottom: 6, left: 6, right: 6),
                          child: Text(
                            post.title,
                            style:
                                const TextStyle(fontSize: AppConstants.body2),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (state is SearchPostsResultState && state.matchedPosts.isEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: const Center(
                    child: Text(
                      'No any post matched your search..',
                      style: TextStyle(fontSize: AppConstants.body1),
                    ),
                  ),
                ),
              if (state is SearchPostsInitialState)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: const Text(
                    '',
                    style: TextStyle(fontSize: AppConstants.caption1),
                  ),
                ),
              if (state is PostsLoadingState)
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (state is PostsErrosState)
                ErrorScreen(message: state.errorMessage),
            ],
          );
        },
      ),
    );
  }
}
