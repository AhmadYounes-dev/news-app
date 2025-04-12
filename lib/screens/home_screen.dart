import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/widgets/article_list.dart';
import 'package:news_app/widgets/search_bar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final newsService = Provider.of<NewsService>(context, listen: false);
    try {
      final data = await newsService.fetchArticles(count: 10);
      setState(() {
        articles = data.map((json) => Article.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load articles: $e')),
      );
    }
  }

  Future<void> _searchArticles(String query) async {
    final newsService = Provider.of<NewsService>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      final data = await newsService.searchArticles(query);
      setState(() {
        articles = data.map((json) => Article.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to search articles: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Column(
        children: [
          SearchBarWidget(onSearch: _searchArticles),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ArticleList(articles: articles),
          ),
        ],
      ),
    );
  }
}
