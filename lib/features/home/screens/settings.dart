import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/home/bloc/bloc/home_bloc.dart';
import 'package:news_app/features/posts/models/post_model.dart';

import '../widgets/fav_category_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, String>> categories = [];

  bool isCategorySelected(String category) {
    if (categories.isEmpty) {
      return false;
    }
    List<String> catTitles = categories.map((cat) => cat['title']!).toList();
    return catTitles.contains(category);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadFavCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Favorite Categories",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: AppConstants.heading2),
          )
              .animate()
              .fadeIn(duration: 1.seconds)
              .slideY(duration: 1.3.seconds, curve: Curves.bounceOut),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "Choose your top 3 categories",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppConstants.body2,
                color: AppConstants.bgSecondary),
          )
              .animate()
              .fadeIn(duration: 1.seconds)
              .slideY(duration: 1.3.seconds, curve: Curves.bounceOut),
          const SizedBox(
            height: 27,
          ),
          Expanded(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: ((context, state) {
                if (state is LoadedFavCategoriesState) {
                  categories = state.favCategories;
                }
              }),
              builder: ((context, state) {
                return GridView.count(
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 8,
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  children: [
                    ...Post.categoriesList
                        .map(
                          (category) => FavCategoryCard(
                            isSelected: isCategorySelected(category),
                            title: category,
                            canBeAdded: categories.length <= 2,
                          )
                              .animate()
                              .scale(
                                  begin: const Offset(0, 0),
                                  duration: .7.seconds)
                              .shimmer(
                                  delay: 300.ms,
                                  duration: 1.2.seconds,
                                  curve: Curves.easeIn),
                        )
                        .toList(),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
