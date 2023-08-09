import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants.dart';

import '../bloc/posts_bloc.dart';
import '../models/post_model.dart';

class PostDetailsScreen extends StatelessWidget {
  //final Map<String,dynamic> article;
  const PostDetailsScreen({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {},
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
                          onPressed: () {},
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
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_border),
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
                            "${post.source}, ",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: AppConstants.caption1),
                          ),
                          const Text(
                            "Feb 28 2023 . Word",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: AppConstants.caption1),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        post.title,
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
                          post.imageUrl,
                          width: MediaQuery.of(context).size.width - 30,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        post.description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: AppConstants.body1,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        post.description,
                        textAlign: TextAlign.left,
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
      ),
    );
  }
}
