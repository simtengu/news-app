import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostsFilterItem extends StatelessWidget {
  final String category;
  const PostsFilterItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 239, 239),
          borderRadius: BorderRadius.circular(30)),
      child: category == 'All'
          ? Text(
              'All',
              style: GoogleFonts.cabin(color: Colors.white),
            )
          : Row(
              children: [
                Image.asset(
                  'lib/assets/images/$category.png',
                  width: 40,
                ),
                Text(
                  category,
                  style: GoogleFonts.cabin(color: Colors.black54),
                ),
              ],
            ),
    );
  }
}
