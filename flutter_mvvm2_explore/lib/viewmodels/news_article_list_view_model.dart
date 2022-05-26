import 'package:flutter/material.dart';
import 'package:flutter_mvvm2_explore/models/news_article.dart';
import 'package:flutter_mvvm2_explore/services/web_service.dart';
import 'package:flutter_mvvm2_explore/viewmodels/news_article_view_model.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class NewsArticleListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  late List<NewsArticleViewModel> articles;

  void topHeadlinesByCountry(String country) async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<NewsArticle> newsArticles =
        await WebService().fetchHeadlinesByCountry(country);

    this.articles = newsArticles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

  void topHeadlines() async {

    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlines();
    notifyListeners();

    this.articles = newsArticles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
}
