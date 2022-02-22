import 'dart:convert';
import 'dart:html';

import '../model/folder.dart';

class ArticlesPool {
  static Folder? _data;
  static ArticlesPool? _instance;

  ArticlesPool._internal() {
    _init();
  }

  factory ArticlesPool() {
    _instance ??= ArticlesPool._internal();
    return _instance!;
  }

  static void _init() {
    HttpRequest.getString('data.json').then((value) {
      _data = Folder.fromMap(jsonDecode(value));
    });
  }
}
