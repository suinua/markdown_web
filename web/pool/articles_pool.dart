import 'dart:convert';

import 'package:universal_html/html.dart';

import '../model/article.dart';
import '../model/article_folder.dart';

class ArticlesPool {
  ArticleFolder? _data;
  ArticleFolder get data => _data!;

  static final ArticlesPool _instance = ArticlesPool._internal();

  ArticlesPool._internal() {
    _init();
  }

  factory ArticlesPool() {
    return _instance;
  }

  void _init() async {
    var response = await HttpRequest.getString('data.json');
    _data = ArticleFolder.fromMap(jsonDecode(response));
  }

   Article getByID(String uuid) {
    return _data!
        .getAllArticles()
        .where((element) => element.uuid == uuid)
        .first;
  }
}
