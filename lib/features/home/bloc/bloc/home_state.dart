part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState{}

final class HomeInitialState extends HomeState {
  final List<Post> breakingNewsPosts;
  final List<Post> recommendedgNewsPosts;
  HomeInitialState({required this.breakingNewsPosts, required this.recommendedgNewsPosts});
}


class HomeErrosState extends HomeState {
  final String errorMessage;
  HomeErrosState({required this.errorMessage});
}

class HomeLoadingState extends HomeState {
  
}


