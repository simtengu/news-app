part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

final class NavigateToPostDetailsEvent extends PostsEvent {
  final Post post;
  NavigateToPostDetailsEvent({required this.post});
}

final class SearchPostsEvent extends PostsEvent {
  final String searchTerm;
  SearchPostsEvent({ required this.searchTerm});
}

class ClearSearchFieldEvent extends PostsEvent {
  
}



final class SearchPostsInitialEvent extends PostsEvent{}
final class LoadfilteredPostsEvent extends PostsEvent{
   final String searchCategory;
 final String country;

  LoadfilteredPostsEvent({required this.searchCategory,required this.country});
}


final class PostFilterChangedEvent extends PostsEvent{
   final String searchCategory;
 final String country;
  PostFilterChangedEvent({required this.searchCategory,required this.country});
}

final class PostSaveToggleEvent  extends PostsEvent{
  final bool isSaved;
  final Post post;

  PostSaveToggleEvent({required this.isSaved, required this.post});
  

}

final class LoadSavedPostsEvent extends PostsEvent {

}

final class IsPostSavedCheckEvent extends PostsEvent {
  final String postTitle;

  IsPostSavedCheckEvent({ required this.postTitle});

}



