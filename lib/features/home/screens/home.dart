import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/common/error_screen.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/home/bloc/bloc/home_bloc.dart';
import 'package:news_app/features/posts/models/country_model.dart';
import 'package:news_app/features/posts/models/post_model.dart';
import 'package:news_app/features/posts/widgets/post_card.dart';
import 'package:news_app/features/posts/widgets/breaking_news_list_item.dart';
import '../../posts/widgets/posts_filter_item.dart';
import '../widgets/home_loading_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  String _filterCountry = 'worldwide';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
    // homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      // bloc: BlocProvider.of<HomeBloc>(context),,
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
                      InkWell(
                        onTap: () => BlocProvider.of<HomeBloc>(context).add(
                            NavigateTabEvent(pageIndex: 1, filterInfo: const {
                          "searchCategory": "all",
                          "filterCountry": "worldwide"
                        })),
                        child: Text(
                          'Show More',
                          style: GoogleFonts.cabin(
                              color: AppConstants.bgPrimary,
                              fontWeight: FontWeight.w500),
                        ),
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
                        padding: const EdgeInsets.all(2).copyWith(left: 10),
                        margin: const EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          color: AppConstants.bgSecondaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _filterCountry,
                              items: Country.availableCountries.map((country) {
                                return DropdownMenuItem(
                                  value: country.code,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        country.flag,
                                        width: 20,
                                        height: 18,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(country.name),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null && value.isNotEmpty) {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      NavigateTabEvent(
                                          pageIndex: 1,
                                          filterInfo: {
                                        "searchCategory": 'all',
                                        "filterCountry": value
                                      }));
                                }
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => BlocProvider.of<HomeBloc>(context).add(
                            NavigateTabEvent(pageIndex: 1, filterInfo: const {
                          "searchCategory": 'all',
                          "filterCountry": 'worldwide'
                        })),
                        child: Container(
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
                      ),
                      ...Post.categoriesList
                          .map((category) => PostsFilterItem(
                                category: category,
                                filterCountry: _filterCountry,
                                filterCategory: 'all',
                              ))
                          .toList(),
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
                      InkWell(
                        onTap: () => BlocProvider.of<HomeBloc>(context).add(
                            NavigateTabEvent(pageIndex: 1, filterInfo: const {
                          "searchCategory": "all",
                          "filterCountry": "worldwide"
                        })),
                        child: Text(
                          'Show More',
                          style: GoogleFonts.cabin(
                              color: AppConstants.bgPrimary,
                              fontWeight: FontWeight.w500),
                        ),
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
                              : homeInitialState.recommendedgNewsPosts.length) *
                          100 +
                      100,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        homeInitialState.recommendedgNewsPosts.length > 12
                            ? 12
                            : homeInitialState.recommendedgNewsPosts.length,
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
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

        return const HomeLoadingScreen();
      },
    );
  }
}
