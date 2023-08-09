import 'package:http/http.dart' as http;
import 'package:news_app/features/posts/controllers/repositories/posts_repository_interface.dart';




class PostsRepo implements PostsRepoInterface {


final String baseUrl = 'api.mediastack.com';
  @override
     Future fetchAllPosts()  {
    var url = Uri.http(baseUrl, '/v1/news', {
      'access_key': 'b534483a4eefd4e317523ff65300e764',
      'categories': 'technology,health,sports,entertainment,business,science',
      'languages': 'en',
      'limit': '40',
    });

      return http.get(url);

  }



  Future<bool> isImageUrlValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200; 
    } catch (e) {
      return false; 
    }
  }

//api key : b534483a4eefd4e317523ff65300e764

  // @override
  // Future<DataState> fetchRecommendedPosts() async {
  //  var url =
  //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // var response = await http.get(url);
  // if (response.statusCode == 200) {

  // } else {

  // }
  // }
}
