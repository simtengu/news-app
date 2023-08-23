// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  final String author;
  final String title;
  final String description;
  final String source;
  String imageUrl;
  final String category;
  final String country;
  final String publishedAt;
  Post({
    required this.author,
    required this.title,
    required this.description,
    required this.source,
    required this.imageUrl,
    required this.category,
    required this.country,
    required this.publishedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;

  static List<String> categoriesList = [
    'sports',
    'business',
    'entertainment',
    'technology',
    'politics',
    'environment',
  ];

  Post copyWith({
    String? author,
    String? title,
    String? description,
    String? source,
    String? imageUrl,
    String? category,
    String? country,
    String? publishedAt,
  }) {
    return Post(
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      source: source ?? this.source,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      country: country ?? this.country,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'title': title,
      'description': description,
      'source': source,
      'imageUrl': imageUrl,
      'category': category,
      'country': country,
      'publishedAt': publishedAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    final authorRs = (map['creator'] ?? []) as List<dynamic>;
    final categoryRs = (map['category'] ?? []) as List<dynamic>;
    final countryRs = (map['country'] ?? []) as List<dynamic>;
    final List<String> categoryFinal =
        categoryRs.map((e) => e.toString()).toList();

    final List<String> authorFinal = authorRs.map((e) => e.toString()).toList();
    final List<String> countryFinal =
        countryRs.map((e) => e.toString()).toList();

    return Post(
      author: authorFinal.isNotEmpty ? authorFinal[0] : "albert oscar",
      title: (map['title'] ?? 'title') as String,
      description: (map['content'] ?? 'desc') as String,
      source: (map['source_id'] ?? 'CNN News') as String,
      imageUrl: (map['image_url'] ??
              'https://i0.wp.com/theperfectroundgolf.com/wp-content/uploads/2022/04/placeholder.png?fit=1200%2C800&ssl=1')
          as String,
      category: categoryFinal.isNotEmpty ? categoryFinal[0] : 'sports',
      country: countryFinal.isNotEmpty ? countryFinal[0] : "United kingdoms",
      publishedAt: (map['pubDate'] ?? 'Feb 28, 2023') as String,
    );
  }

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
