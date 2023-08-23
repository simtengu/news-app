import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/posts/controllers/posts_controller.dart';
import 'package:news_app/features/posts/controllers/repositories/posts_repository.dart';

import '../../../../core/common/network_info.dart';
import '../../../posts/models/post_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final favCategoriesBox = Hive.box<String>('FavCategories');
  HomeBloc() : super(HomeLoadingState()) {
    //initial event ... to fetch all home screen data..............
    on<HomeInitialEvent>(homeInitialEvent);
    on<NavigateToHomePageEvent>(navigateToHomePageEvent);
    on<NavigateToPostsFilterPageEvent>(navigateToPostsFilterPageEvent);
    on<NavigateToSavedPostsEvent>(navigateToSavedPostsEvent);
    on<NavigateToSettingsPageEvent>(navigateToSettingsPageEvent);
    on<NavigateTabEvent>(navigateTabEvent);
    on<LoadFavCategoriesEvent>(loadFavCategoriesEvent);
    on<ToggleFavCategoryEvent>(toggleFavCategoryEvent);
  }

  final PostsController _postsController =
      PostsController(postsRepo: PostsRepo());

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    List<Post> breakingNewsPosts = [];
    List<Post> recommendedgNewsPosts = [];
    emit(HomeLoadingState());
    DataState response = await _postsController.fetchAllPosts();

    if (response is DataSuccess) {
      breakingNewsPosts = response.data as List<Post>;
      recommendedgNewsPosts = List.from(breakingNewsPosts);
      // recommendedgNewsPosts = response.data as List<Post>;
      recommendedgNewsPosts.shuffle();
      emit(HomeInitialState(
          breakingNewsPosts: breakingNewsPosts,
          recommendedgNewsPosts: recommendedgNewsPosts));
    }

    if (response is DataError) {
      emit(HomeErrosState(errorMessage: response.error));
    }
  }

  FutureOr<void> navigateToHomePageEvent(
      NavigateToHomePageEvent event, Emitter<HomeState> emit) {
    emit(NavigateToHomePageState());
  }

  FutureOr<void> navigateToPostsFilterPageEvent(
      NavigateToPostsFilterPageEvent event, Emitter<HomeState> emit) {
    emit(NavigateToPostsFilterPageState());
  }

  FutureOr<void> navigateToSavedPostsEvent(
      NavigateToSavedPostsEvent event, Emitter<HomeState> emit) {
    emit(NavigateToSavedPostsState());
  }

  FutureOr<void> navigateToSettingsPageEvent(
      NavigateToSettingsPageEvent event, Emitter<HomeState> emit) {
    emit(NavigateToSettingsPageState());
  }

  FutureOr<void> navigateTabEvent(
      NavigateTabEvent event, Emitter<HomeState> emit) {
    if (event.pageIndex != 0) {
      emit(HomeLoadingState());
    }
    if (event.filterInfo != null) {
      emit(NavigateTabState(
          pageIndex: event.pageIndex, filterInfo: event.filterInfo));
    } else {
      emit(NavigateTabState(pageIndex: event.pageIndex));
    }
  }

  FutureOr<void> loadFavCategoriesEvent(
      LoadFavCategoriesEvent event, Emitter<HomeState> emit) {
    List<Map<String, String>> categories = _loadFavCategories();

    emit(LoadedFavCategoriesState(favCategories: categories));
  }

  FutureOr<void> toggleFavCategoryEvent(
      ToggleFavCategoryEvent event, Emitter<HomeState> emit) {
    if (event.isFav) {
      //removing category from favorite categories...............
      List<Map<String, String>> categories = _loadFavCategories();

      final category =
          categories.firstWhere((element) => element['title'] == event.title);
      int categoryKey = int.parse(category['key']!);

      favCategoriesBox.delete(categoryKey);
    } else {
      favCategoriesBox.add(event.title);
    }

    final favCategories = _loadFavCategories();
    emit(LoadedFavCategoriesState(favCategories: favCategories));
  }

//loading stored fav categories...................................
  List<Map<String, String>> _loadFavCategories() {
    List<Map<String, String>> categories = [];

    if (favCategoriesBox.keys.isNotEmpty) {
      categories = favCategoriesBox.keys.map((key) {
        final item = favCategoriesBox.get(key);
        return {'key': key.toString(), 'title': item!};
      }).toList();
    }
    return categories;
  }
}
