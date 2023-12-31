import 'package:http/http.dart' as http;
import 'package:news_app/features/posts/controllers/repositories/posts_repository_interface.dart';

class PostsRepo implements PostsRepoInterface {

  final String baseUrl = 'newsdata.io';
  @override
  Future fetchAllPosts(Map<String, String> parameters) {
    var url = Uri.https(baseUrl, '/api/1/news', {
      'apikey': 'pub_27472d98e95365e4d9f6797e1b28d48057a5e',
      'language': 'en',
      ...parameters
    });
    return http.get(url);
  }

  @override
  Future fetchFilteredPosts(Map<String, String> parameters) {
    return fetchAllPosts(parameters);
  }

  @override
  Future fetchRecommendedPosts(Map<String, String> parameters) {
    return fetchAllPosts(parameters);
  }

  @override
  Future searchPosts(Map<String, String> parameters) {
    return fetchAllPosts(parameters);
  }
}
