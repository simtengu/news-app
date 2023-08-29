// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

sealed class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

final class NavigateToPostDetailsState extends PostsActionState {
  final Post post;
  NavigateToPostDetailsState({required this.post});
}

final class PostDetailsScreenPopedOutState extends PostsState {

}

final class PostsErrosState extends PostsState {
  final String errorMessage;
  PostsErrosState({required this.errorMessage});
}

final class PostsLoadingState extends PostsState {}

final class SearchPostsInitialState extends PostsState {}

final class SearchPostsResultState extends PostsState {
  final List<Post> matchedPosts;
  SearchPostsResultState({required this.matchedPosts});
}

class ClearSearchFieldState extends PostsState {}


class FilteredPostsLoadedState extends PostsState {
  final List<Post> posts;
  final String searchCategory;
  final String country;
  FilteredPostsLoadedState({
    required this.posts,
    required this.searchCategory,
    required this.country,
  });
}

class PostFilterChangedState extends PostsState {
  final String searchCategory;
  final String country;
  PostFilterChangedState({
    required this.searchCategory,
    required this.country,
  });
}

class PostSaveToggleState extends PostsState {
  final bool isSaved;
  final List<Post>? posts;
  PostSaveToggleState({
    required this.isSaved,
     this.posts,
  });
  
}



final class SavedPostsLoadedState extends PostsState {
  final List<Post> posts;
  SavedPostsLoadedState({required this.posts});

}

final class IsPostSavedCheckState extends PostsState {
  final bool isPostSaved;
  IsPostSavedCheckState( {required this.isPostSaved});
}

