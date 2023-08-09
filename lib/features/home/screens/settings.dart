import 'package:flutter/material.dart';
import 'package:news_app/core/constants.dart';

import '../widgets/fav_category_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            child: GridView.count(
              mainAxisSpacing: 9,
              crossAxisSpacing: 8,
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              children: const [
                FavCategoryCard(
                  isSelected: true,
                  title: 'Sports',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Entertainment',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Comedy',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Environment',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Politics',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Business',
                ),
                FavCategoryCard(
                  isSelected: true,
                  title: 'Education',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Weather',
                ),
                FavCategoryCard(
                  isSelected: true,
                  title: 'Economics',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Technology',
                ),
                FavCategoryCard(
                  isSelected: false,
                  title: 'Lifestyle',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
