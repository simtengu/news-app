import 'package:flutter/material.dart';
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
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "Choose your top 3 categories",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppConstants.body2,
                color: AppConstants.bgSecondary),
          ),
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
                          ),
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
