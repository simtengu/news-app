part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}
sealed class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

final class NavigateToPostDetailsState extends PostsActionState {
  final Post post;
  NavigateToPostDetailsState({required this.post});
}
