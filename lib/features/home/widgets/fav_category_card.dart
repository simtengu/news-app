import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class FavCategoryCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  const FavCategoryCard(
      {super.key, required this.isSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: isSelected
                ? [AppConstants.bgPrimary, AppConstants.bgPrimary]
                : [
                    const Color.fromARGB(255, 132, 194, 242),
                    const Color.fromARGB(255, 190, 227, 255),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: AppConstants.secondary,
            fontSize: AppConstants.body2,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
