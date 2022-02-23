import 'dart:convert';
import 'dart:html';

import '../model/folder.dart';

class ArticlesPool {
  static Folder? _data;

  static void _init() {
    //HttpRequest.getString('data.json').then((value) {
    //  _data = Folder.fromMap(jsonDecode(value));
    //});
    var data = {"name":"articles","articles":[{"uuid":"f40b0399-b6cd-4d26-abc3-1c0a929f0b6f","tags":[""],"title":"index","body":"# Test\r\nwelasdlk\r\ndsao\r\ndsao\r\nasd\r\nsda dasd \r\ndasd\r\nasd","url":"index.html"}],"folders":[{"name":"entity","articles":[{"uuid":"b9064053-cc70-4f58-9847-90cc7ed2c432","tags":["tag1","tag2","tag3"],"title":"npc","body":"# NPC","url":"entity\\npc.html"}],"folders":[]},{"name":"general","articles":[{"uuid":"d17a41f0-532e-462c-871a-6a607ec8773a","tags":["tag1","tag3","tag4","tag5"],"title":"develop","body":"# Develop12345678910111213342aaa\r\n","url":"general\\develop.html"},{"uuid":"1fef7ac5-d173-4577-af8b-09e4b1548363","tags":["tag1","tag3","tag4","tag5","tag6","tag7","tag8","tag9","tag10","tag11"],"title":"setup","body":"# Setup\r\nasdasdasd","url":"general\\setup.html"},{"uuid":"a28977d0-ca02-4c39-9737-cf104314d866","tags":["tag1","tag3","tag4","tag5","tag6","tag7"],"title":"setup_develop","body":"# Title1234\r\n\r\nasdasd\r\nasdasd\r\n\r\nasdasd","url":"general\\setup_develop.html"}],"folders":[]},{"name":"world","articles":[],"folders":[]}]};
    
    _data = Folder.fromMap(data);
  }

  static Folder data() {
    if (_data == null) _init();
    return _data!;
  }
}
