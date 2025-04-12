class Article {
  final String description;
  final String title;
  final String publishedAt;
  final String image;
  final String url;
  final String sourceName;
  final String? author;
  
  
  Article(
      {required this.description,
      required this.title,
      required this.publishedAt,
      required this.image,
      required this.url,
      required this.sourceName,
      this.author});

      factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      url: json['url'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      publishedAt: json['publishedAt'] ?? '',
      sourceName: json['source']['name'] ?? 'Unknown source',
      author: json['author'],
    );
  }
}

