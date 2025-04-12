import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ArticleList extends StatelessWidget {
  final List<Article> articles;

  const ArticleList({super.key, required this.articles});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: article.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(article.title),
            subtitle: Text(article.sourceName),
            onTap: () {
              // Navigate to article detail
            },
          ),
        );
      },
    );
  }
}
