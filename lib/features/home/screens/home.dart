import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/common/error_screen.dart';
import 'package:news_app/core/common/network_info.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/core/dummy_data.dart';
import 'package:news_app/features/home/bloc/bloc/home_bloc.dart';
import 'package:news_app/features/posts/controllers/repositories/posts_repository.dart';
import 'package:news_app/features/posts/widgets/post_card.dart';
import 'package:news_app/features/posts/widgets/breaking_news_list_item.dart';

import '../../posts/models/post_model.dart';
import '../../posts/widgets/posts_filter_item.dart';
import 'home_loading_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  // late List<Post> posts;
  // bool isLoading = true;
  // void fetchPosts() async {
  //   PostsRepo api = PostsRepo();

  //   DataState rs = await api.fetchAllPosts();
  //   setState(() {
  //     isLoading = false;
  //     if (rs is DataSuccess) {
  //       posts = rs.data as List<Post>;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {},
        builder: (context, state) {
          // print(state.runtimeType);
          if (state is HomeLoadingState) {
            return const HomeLoadingScreen();
          }

          if (state is HomeInitialState) {
            final homeInitialState = state;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Breaking News',
                          style: GoogleFonts.cabin(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          'Show More',
                          style: GoogleFonts.cabin(
                              color: AppConstants.bgPrimary,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // breaking news slider...............................................
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: ListView.builder(
                      itemCount: homeInitialState.breakingNewsPosts.length > 10
                          ? 10
                          : homeInitialState.breakingNewsPosts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => BreakingNewsListItem(
                          post: homeInitialState.breakingNewsPosts[index])),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 6),
                          decoration: BoxDecoration(
                              color: AppConstants.bgPrimary,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'All',
                            style: GoogleFonts.cabin(color: Colors.white),
                          ),
                        ),
                        const PostsFilterItem(
                          category: 'sports',
                        ),
                        const PostsFilterItem(
                          category: 'education',
                        ),
                        const PostsFilterItem(
                          category: 'politics',
                        ),
                        const PostsFilterItem(
                          category: 'entertainment',
                        ),
                        const PostsFilterItem(
                          category: 'environment',
                        ),
                        const PostsFilterItem(
                          category: 'economics',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommended for you',
                          style: GoogleFonts.cabin(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.body1),
                        ),
                        Text(
                          'Show More',
                          style: GoogleFonts.cabin(
                              color: AppConstants.bgPrimary,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: (homeInitialState.recommendedgNewsPosts.length > 12
                                ? 12
                                : homeInitialState
                                    .recommendedgNewsPosts.length) *
                            100 +
                        100,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          homeInitialState.recommendedgNewsPosts.length > 12
                              ? 12
                              : homeInitialState.recommendedgNewsPosts.length,
                      itemBuilder: ((context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: PostCard(
                                post: homeInitialState
                                    .recommendedgNewsPosts[index]),
                          )),
                    ),
                  )
                ],
              ),
            );
          }

          if (state is HomeErrosState) {
            final errorState = state;

            return ErrorScreen(message: errorState.errorMessage);
          }

          return const ErrorScreen(message: 'Something Went Wrong');
        },
      ),
    );
  }
}
