// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class NavigateToHomePageEvent extends HomeEvent {}

class NavigateToPostsFilterPageEvent extends HomeEvent {}

class NavigateToSavedPostsEvent extends HomeEvent {}

class NavigateToSettingsPageEvent extends HomeEvent {}

class NavigateTabEvent extends HomeEvent {
  final int pageIndex;
  final Map<String, String>? filterInfo;
  NavigateTabEvent({required this.pageIndex, this.filterInfo});
}

class LoadFavCategoriesEvent extends HomeEvent {}

class ToggleFavCategoryEvent extends HomeEvent {
  final bool isFav;
  final String title;
  ToggleFavCategoryEvent({
    required this.isFav,
    required this.title,
  });
}
