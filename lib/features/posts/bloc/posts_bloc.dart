import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/posts/controllers/posts_controller.dart';
import 'package:news_app/features/posts/controllers/repositories/posts_repository.dart';
import 'package:news_app/features/posts/models/post_model.dart';

import '../../../core/common/network_info.dart';
import '../models/article.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsController _postsController =
      PostsController(postsRepo: PostsRepo());
  final Box<Article> articlesBox = Hive.box<Article>('Articles');

  PostsBloc() : super(PostsInitial()) {
    on<NavigateToPostDetailsEvent>(navigateToPostDetailsEvent);
    on<SearchPostsInitialEvent>(searchPostsInitialEvent);
    on<SearchPostsEvent>(searchPostsEvent);
    on<ClearSearchFieldEvent>(clearSearchFieldEvent);
    on<LoadfilteredPostsEvent>(loadfilteredPostsEvent);
    on<PostFilterChangedEvent>(postFilterChangedEvent);
    on<PostSaveToggleEvent>(postSaveToggleEvent);
    on<LoadSavedPostsEvent>(loadSavedPostsEvent);
    on<IsPostSavedCheckEvent>(isPostSavedCheckEvent);
    on<PostDetailsScreenPopedOutEvent>(postDetailsScreenPopedOutEvent);
  }

  FutureOr<void> navigateToPostDetailsEvent(
      NavigateToPostDetailsEvent event, Emitter<PostsState> emit) {
    emit.call(PostsInitial());
    emit(NavigateToPostDetailsState(post: event.post));
  }

  FutureOr<void> searchPostsEvent(
      SearchPostsEvent event, Emitter<PostsState> emit) async {
    List<Post> foundPosts = [];
    emit(PostsLoadingState());
    DataState response = await _postsController.searchPost(event.searchTerm);
    if (response is DataSuccess) {
      foundPosts = response.data as List<Post>;

      emit(SearchPostsResultState(matchedPosts: foundPosts));
    }

    if (response is DataError) {
      emit(PostsErrosState(errorMessage: response.error));
    }
  }

  FutureOr<void> clearSearchFieldEvent(
      ClearSearchFieldEvent event, Emitter<PostsState> emit) {
    emit(ClearSearchFieldState());
    emit(SearchPostsInitialState());
  }

  FutureOr<void> searchPostsInitialEvent(
      SearchPostsInitialEvent event, Emitter<PostsState> emit) {
    emit(SearchPostsInitialState());
  }

  FutureOr<void> loadfilteredPostsEvent(
      LoadfilteredPostsEvent event, Emitter<PostsState> emit) async {
    List<Post> posts = [];
    emit(PostsLoadingState());
    DataState response = await _postsController.fetchFilteredPosts(
        {"country": event.country, "searchCategory": event.searchCategory});
    if (response is DataSuccess) {
      posts = response.data as List<Post>;

      emit(FilteredPostsLoadedState(
          country: event.country,
          searchCategory: event.searchCategory,
          posts: posts));
    }

    if (response is DataError) {
      emit(PostsErrosState(errorMessage: response.error));
    }
  }

  FutureOr<void> postFilterChangedEvent(
      PostFilterChangedEvent event, Emitter<PostsState> emit) {
    emit(PostFilterChangedState(
        country: event.country, searchCategory: event.searchCategory));
  }

  FutureOr<void> postSaveToggleEvent(
      PostSaveToggleEvent event, Emitter<PostsState> emit) {
    if (event.isSaved) {
      //unsave the post.......................
      List<Map<String, dynamic>> savedArticles = articlesBox.keys.map((key) {
        Article article = articlesBox.get(key)!;
        return {"key": key, "article": article};
      }).toList();

      final foundArticle = savedArticles.firstWhere((article) {
        Article art = article["article"] as Article;
        return art.title == event.post.title;
      });
      int articleKey = foundArticle["key"] as int;

      articlesBox.delete(articleKey);
      //load saved posts(refresh)....................
      List<Post> posts = loadSavedPosts();

      emit(PostSaveToggleState(isSaved: false,posts: posts));
    } else {
      //Save  the post.......................
      Post post = event.post;
      Article article = Article(
          author: post.author,
          title: post.title,
          description: post.description,
          source: post.source,
          imageUrl: post.imageUrl,
          category: post.category,
          country: post.country,
          publishedAt: post.publishedAt);
      articlesBox.add(article);

      emit(PostSaveToggleState(isSaved: true));
    }
  }

  FutureOr<void> loadSavedPostsEvent(
      LoadSavedPostsEvent event, Emitter<PostsState> emit) {
    List<Post> posts = loadSavedPosts();

    emit(SavedPostsLoadedState(posts: posts));
  }

  FutureOr<void> isPostSavedCheckEvent(IsPostSavedCheckEvent event, Emitter<PostsState> emit) {
    
 List<Post> posts = loadSavedPosts();
 bool isSaved = posts.any((post) =>  post.title == event.postTitle);
 emit(IsPostSavedCheckState(isPostSaved: isSaved));
  }


  List<Post> loadSavedPosts(){
        List<Post> posts = [];
    if (articlesBox.keys.isNotEmpty) {
      posts = articlesBox.keys.map((key) {
        Article article = articlesBox.get(key)!;

        return Post(
            author: article.author,
            title: article.title,
            description: article.description,
            source: article.source,
            imageUrl: article.imageUrl,
            category: article.category,
            country: article.country,
            publishedAt: article.publishedAt);
      }).toList();
    }

    return posts;
  }



  FutureOr<void> postDetailsScreenPopedOutEvent(PostDetailsScreenPopedOutEvent event, Emitter<PostsState> emit) {
    emit(PostDetailsScreenPopedOutState());
  }
}
