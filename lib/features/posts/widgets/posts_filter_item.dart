import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/posts/bloc/posts_bloc.dart';

import '../../home/bloc/bloc/home_bloc.dart';

class PostsFilterItem extends StatelessWidget {
  final String category;
  final String filterCountry;
  final String filterCategory;
  const PostsFilterItem(
      {super.key,
      required this.category,
      required this.filterCountry,
      required this.filterCategory});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<PostsBloc, PostsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<HomeBloc>(context).add(NavigateTabEvent(
                    pageIndex: 1,
                    filterInfo: {
                      "searchCategory": category,
                      "filterCountry": filterCountry
                    }));
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                decoration: BoxDecoration(
                    color: category == filterCategory
                        ? AppConstants.bgPrimary
                        : AppConstants.bgSecondaryLight,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/assets/images/$category.png',
                      width: 40,
                    ),
                    Text(
                      category,
                      style: GoogleFonts.cabin(
                        color: category == filterCategory
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
