import 'package:news_app/features/posts/controllers/repositories/posts_repository.dart';
import 'dart:convert';
import '../../../core/common/network_info.dart';
import '../models/post_model.dart';

class PostsController {
  final PostsRepo _postsRepo;
  PostsController({required PostsRepo postsRepo}): _postsRepo = postsRepo;


  Future<DataState> fetchAllPosts() async {


    try {
      var response = await _postsRepo.fetchAllPosts();
      if (response.statusCode == 200) {
        Map<String, dynamic> rsData =
            json.decode(response.body) as Map<String, dynamic>;
        final posts = rsData['data'] as List<dynamic>;

        List<Post> allPosts = [];
        for (var map in posts) {
          var postMap = map as Map<String, dynamic>;
          String img = postMap['image'] ?? "";
          //checking if the image link is valid.......................
          if (img.isNotEmpty) {
            // bool isImageAvailable = await isImageUrlValid(img);
            if (!img.contains('{https}') && !img.startsWith('//')) {
              Post post = Post.fromMap(postMap);
              allPosts.add(post);
            }
          }
        }

        //removing duplicate posts......................
        Set<Post> uniquePosts = Set<Post>.from(allPosts);
        List<Post> finalPosts = uniquePosts.toList();

        return DataSuccess(data: finalPosts);
      } else {
        return DataError(error: 'Something went wrong..');
      }
    } catch (e) {
      return DataError(error: 'Something went wrong..');
    }
  }
  
}