import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/constants.dart';

import '../bloc/posts_bloc.dart';
import '../models/post_model.dart';

class PostDetailsScreen extends StatefulWidget {
  //final Map<String,dynamic> article;
  const PostDetailsScreen({super.key, required this.post});
  final Post post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  bool isSaved = false;
  final PostsBloc _postsBloc = PostsBloc();
  @override
  void initState() {
    super.initState();
    _postsBloc.add(IsPostSavedCheckEvent(postTitle: widget.post.title));
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://media.tenor.com/FZxj4M9HGSwAAAAM/jinsoulery-jinsoulburger.gif',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "You cannot share for now",
                    style: TextStyle(fontSize: AppConstants.body2),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<PostsBloc, PostsState>(
          bloc: _postsBloc,
          listener: (context, state) {
            if (state is PostSaveToggleState) {
              isSaved = state.isSaved;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.isSaved
                      ? "The post has been saved successfully"
                      : "The post has been removed successfully"),
                  duration: const Duration(
                      seconds:
                          3), // Optional: Set how long the Snackbar should be displayed.
                ),
              );
            }

            if (state is IsPostSavedCheckState) {
              isSaved = state.isPostSaved;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 243, 239, 239),
                      width: 4,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 239, 239),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showMyDialog(context);
                            },
                            icon: const Icon(Icons.ios_share),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              _postsBloc.add(PostSaveToggleEvent(
                                  isSaved: isSaved, post: widget.post));
                            },
                            icon: Icon(isSaved
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(top: 14),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.title,
                          style: const TextStyle(
                              fontSize: AppConstants.title1,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              height: 1.2),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.post.imageUrl,
                            width: MediaQuery.of(context).size.width - 10,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                            text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppConstants.primary),
                          children: [
                            const TextSpan(
                              text: 'Category: ',
                            ),
                            TextSpan(
                              text: widget.post.category,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: AppConstants.caption1),
                            ),
                          ],
                        )),

                        Wrap(
                          children: [
                            const Text(
                              "Source: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${widget.post.source}, ",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: AppConstants.caption1),
                            ),
                            Text(
                              DateFormat.yMMMMd().format(
                                  DateTime.parse(widget.post.publishedAt)),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: AppConstants.caption1),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.post.description,
                          textAlign: TextAlign.left,
                          // maxLines: 20,
                          style: const TextStyle(
                              fontSize: AppConstants.body1,
                              color: Colors.black54),
                        ),

                        // Shimmer.fromColors(
                        //   baseColor: Colors.grey.shade400,
                        //   highlightColor: Colors.white,
                        //   child: Container(
                        //     height: 33,
                        //     color: Colors.black26,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
