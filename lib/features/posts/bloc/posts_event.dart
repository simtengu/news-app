part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

final class NavigateToPostDetailsEvent extends PostsEvent {
  final Post post;
  NavigateToPostDetailsEvent({required this.post});

}
