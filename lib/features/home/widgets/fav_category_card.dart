import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/bloc/home_bloc.dart';

import '../../../core/constants.dart';

class FavCategoryCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final bool canBeAdded;
  const FavCategoryCard(
      {super.key,
      required this.isSelected,
      required this.title,
      required this.canBeAdded});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isSelected) {
          BlocProvider.of<HomeBloc>(context).add(ToggleFavCategoryEvent(
            isFav: isSelected,
            title: title,
          ));
        } else {
          return canBeAdded
              ? BlocProvider.of<HomeBloc>(context).add(ToggleFavCategoryEvent(
                  isFav: isSelected,
                  title: title,
                ))
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                      'You can choose only three categories',
                      style: TextStyle(fontSize: AppConstants.body2),
                    ),
                  ),
                );
        }
      },
      child: Container(
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
      ),
    );
  }
}
