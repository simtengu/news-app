import 'package:flutter/material.dart';
import 'package:news_app/core/constants.dart';

class SearchPostScreen extends StatelessWidget {
  const SearchPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            color: AppConstants.bgSecondaryLight,
            child: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: AppConstants.body1),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search....',
                prefix: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffix: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
