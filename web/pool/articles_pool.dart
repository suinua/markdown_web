import 'dart:convert';

import 'package:universal_html/html.dart';

import '../model/article_folder.dart';

class ArticlesPool {
  static ArticleFolder? _data;

  static void _init()  {
    var request = HttpRequest()
      ..open('GET', 'data.json', async: false)
      ..send();

    _data = ArticleFolder.fromMap(jsonDecode(request.response));
  }

  static ArticleFolder data() {
    if (_data == null) _init();
    return _data!;
  }
}
