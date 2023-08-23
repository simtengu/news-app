abstract class PostsRepoInterface {
  Future fetchAllPosts(Map<String,String> parameters);
 Future fetchRecommendedPosts(Map<String,String> options);
 Future fetchFilteredPosts(Map<String,String> options);
 Future searchPosts(Map<String,String> options);
}
