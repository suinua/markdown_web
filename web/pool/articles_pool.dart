import 'dart:convert';

import 'package:universal_html/html.dart';
import '../../common/model/folder.dart';

class ArticlesPool {
  static Folder? _data;

  static void _init()  {
    var request = HttpRequest()
      ..open('GET', 'data.json', async: false)
      ..send();
    
    _data = Folder.fromMap(jsonDecode(request.response));
  }

  static Folder data() {
    if (_data == null) _init();
    return _data!;
  }
}
