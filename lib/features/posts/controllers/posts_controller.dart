import 'dart:io';

import 'package:news_app/features/posts/controllers/repositories/posts_repository.dart';
import 'dart:convert';
import '../../../core/common/network_info.dart';
import '../models/post_model.dart';

class PostsController {
  final PostsRepo _postsRepo;
  PostsController({required PostsRepo postsRepo}) : _postsRepo = postsRepo;

//fetch all posts(no filters involved).......................................................
  Future<DataState> fetchHomepagePosts(List<String> favCategories) async {
    Map<String, String> allPostsQueryParameters = {};

    if (favCategories.isNotEmpty) {
      //a user has fav categories.................................... recommend posts...........
      String favCategoriesString = "";

      for (var i = 0; i < favCategories.length; i++) {
        final cat = favCategories[i];
        if ((favCategories.length - 1) == i) {
          favCategoriesString += cat;
        } else {
          favCategoriesString += "$cat,";
        }
      }

      Map<String, String> favCategoriesPostsQueryParameters = {
        "category": favCategoriesString
      };

      try {
        final responses = await Future.wait([
          _postsRepo.fetchAllPosts(allPostsQueryParameters),
          _postsRepo.fetchRecommendedPosts(favCategoriesPostsQueryParameters)
        ]);
        final allPostsFetchRs = responses[0];
        final recommendedPostsRs = responses[1];

        if (allPostsFetchRs.statusCode == 200 &&
            recommendedPostsRs.statusCode == 200) {
          List<Post> allPosts = responseDataCleaning(allPostsFetchRs.body);
          List<Post> recommendedPosts =
              responseDataCleaning(recommendedPostsRs.body);

          final Map<String, dynamic> rsData = {
            "allPosts": allPosts,
            "recommendedPosts": recommendedPosts,
          };

          return DataSuccess(data: rsData);
        } else {
          return DataError(error: 'Something went wrong..');
        }
      } catch (e) {
        return DataError(error: e.toString());
      }
    } else {
      //a user doesnt have fav categories.................................... just fetch all posts...........

      try {
        var response = await _postsRepo.fetchAllPosts(allPostsQueryParameters);

        if (response.statusCode == 200) {
          List<Post> posts = responseDataCleaning(response.body);

          return DataSuccess(data: posts);
        } else {
          return DataError(error: 'Something went wrong..');
        }
      } catch (e) {
        return DataError(error: e.toString());
      }
    }
  }

//end of fetch all posts(no filters involved).......................................................
//fetch filtered posts...................................................................................
  Future<DataState> fetchFilteredPosts(Map<String, String> filterInfo) async {
    Map<String, String> queryParameters = {};

    if (filterInfo["country"]! != "worldwide") {
      queryParameters = {
        'country': filterInfo["country"]!,
      };
    }

    if (filterInfo["searchCategory"]! != "all") {
      queryParameters = {
        ...queryParameters,
        'category': filterInfo["searchCategory"]!,
      };
    }

    try {
      var response = await _postsRepo.fetchFilteredPosts(queryParameters);

      if (response.statusCode == 200) {
        List<Post> posts = responseDataCleaning(response.body);
        return DataSuccess(data: posts);
      } else {
        return DataError(error: 'Something went wrong..');
      }
    } catch (e) {
      return DataError(error: e.toString());
    }
  }
//End of fetch filtered posts.............................................................................

//search post........................................................................................
  Future<DataState> searchPost(String searchTerm) async {
    Map<String, String> queryParameters = {
      'qInTitle': searchTerm,
    };
    try {
      var response = await _postsRepo.searchPosts(queryParameters);

      if (response.statusCode == 200) {
        List<Post> posts = responseDataCleaning(response.body);
        return DataSuccess(data: posts);
      } else {
        return DataError(error: 'Something went wrong..');
      }
    } catch (e) {
      return DataError(error: e.toString());
    }
  }
  //end of search post.........................................................................

//filtering/validating results to get only valid posts...with no errors.................

  List<Post> responseDataCleaning(dynamic response) {
    Map<String, dynamic> rsData = json.decode(response) as Map<String, dynamic>;
    final posts = rsData['results'] as List<dynamic>;

    List<Post> allPosts = [];
    for (var map in posts) {
      var postMap = map as Map<String, dynamic>;
      String img = postMap['image_url'] ?? "";

      if (img.isNotEmpty) {
        //checking if the image link is valid ( from api specific errors )...............................................
        if (!img.substring(10).contains('https') &&
            !img.startsWith('//') &&
            !img.endsWith('.mp4')) {
          Post post = Post.fromMap(postMap);
          allPosts.add(post);
        }
      }
    }

    //removing duplicate posts.........................................................
    Set<Post> uniquePosts = Set<Post>.from(allPosts);
    List<Post> finalPosts = uniquePosts.toList();
    return finalPosts;
  }
}
