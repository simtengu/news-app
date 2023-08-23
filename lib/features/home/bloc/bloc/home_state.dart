// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitialState extends HomeState {
  final List<Post> breakingNewsPosts;
  final List<Post> recommendedgNewsPosts;
  HomeInitialState(
      {required this.breakingNewsPosts, required this.recommendedgNewsPosts});
}

class HomeErrosState extends HomeState {
  final String errorMessage;
  HomeErrosState({required this.errorMessage});
}

class HomeLoadingState extends HomeState {}

class NavigateToHomePageState extends HomeState {}

class NavigateToPostsFilterPageState extends HomeState {}

class NavigateToSavedPostsState extends HomeState {}

class NavigateToSettingsPageState extends HomeState {}

class NavigateTabState extends HomeActionState {
  final int pageIndex;
 final  Map<String,String>? filterInfo;
  NavigateTabState({
    required this.pageIndex,
    this.filterInfo,
  });
}

class LoadedFavCategoriesState extends HomeState {
  final List<Map<String,String>> favCategories;
  LoadedFavCategoriesState({
    required this.favCategories,
  });
  
}



