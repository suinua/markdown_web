import 'dart:convert';
import 'dart:html';

import '../model/folder.dart';

class ArticlesPool {
  static Folder? _data;

  static void _init() {
    HttpRequest.getString('data.json').then((value) {
      _data = Folder.fromMap(jsonDecode(value));
    });
  }

  static Folder data() {
    if (_data == null) _init();
    return _data!;
  }
}
