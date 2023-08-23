// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 1)
class Article {


@HiveField(0)
   String author;
   @HiveField(1)
   String title;
   @HiveField(2)
   String description;
   @HiveField(3)
   String source;
   @HiveField(4)
  String imageUrl;
  @HiveField(5)
   String category;
   @HiveField(6)
   String country;
   @HiveField(7)
   String publishedAt;
  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.source,
    required this.imageUrl,
    required this.category,
    required this.country,
    required this.publishedAt,
  });
}
