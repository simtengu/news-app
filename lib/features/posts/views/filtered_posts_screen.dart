import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/common/error_screen.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/posts/bloc/posts_bloc.dart';
import 'package:news_app/features/posts/models/post_model.dart';
import 'package:news_app/features/posts/widgets/post_card.dart';
import 'package:news_app/features/posts/widgets/posts_filter_item.dart';

import '../../home/bloc/bloc/home_bloc.dart';
import '../models/country_model.dart';
import '../widgets/posts_filter_loading_screen.dart';

class FilteredPostsScreen extends StatefulWidget {
  const FilteredPostsScreen({super.key});

  @override
  State<FilteredPostsScreen> createState() => _FilteredPostsScreenState();
}

class _FilteredPostsScreenState extends State<FilteredPostsScreen> {
  String _filterCountry = 'worldwide';
  String _searchCategory = 'all';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      items: Country.sortedCountries().map((country) {
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
                          BlocProvider.of<HomeBloc>(context)
                              .add(NavigateTabEvent(pageIndex: 1, filterInfo: {
                            "searchCategory": _searchCategory,
                            "filterCountry": value,
                          }));
                        }
                      }),
                ),
              ),
              GestureDetector(
                onTap: () => BlocProvider.of<HomeBloc>(context)
                    .add(NavigateTabEvent(pageIndex: 1, filterInfo: {
                  "searchCategory": 'all',
                  "filterCountry": _filterCountry,
                })),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                  decoration: BoxDecoration(
                      color: _searchCategory == "all"
                          ? AppConstants.bgPrimary
                          : AppConstants.bgSecondaryLight,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'All',
                    style: GoogleFonts.cabin(
                      color: _searchCategory == "all"
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              ...Post.categoriesList
                  .map((category) => PostsFilterItem(
                        category: category,
                        filterCountry: _filterCountry,
                        filterCategory: _searchCategory,
                      ))
                  .toList(),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        BlocConsumer<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostFilterChangedState) {
              setState(() {
                _filterCountry = state.country;
                _searchCategory = state.searchCategory;
              });
            }

            if (state is FilteredPostsLoadedState) {
              setState(() {
                _filterCountry = state.country;
                _searchCategory = state.searchCategory;
              });
            }
          },
          builder: (context, state) {
            if (state is PostsLoadingState) {
              return const PostsFilterLoadingScreen();
              // return const HomeLoadingScreen();
            }

            if (state is PostsErrosState) {
              ErrorScreen(message: state.errorMessage);
            }
            if (state is FilteredPostsLoadedState) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        '${state.posts.length} Available Articles',
                        style: GoogleFonts.cabin(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.body1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state.posts.isEmpty)
                      const Center(
                        child: Text(
                          'Try other filters....',
                          style: TextStyle(fontSize: AppConstants.body2),
                        ),
                      ),
                    if (state.posts.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: ((context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: PostCard(
                                  post: state.posts[index],
                                ),
                              )),
                        ),
                      )
                  ],
                ),
              );
            }

            return const ErrorScreen(
              message: 'something went wrong',
            );
          },
        ),
      ],
    );
  }
}
