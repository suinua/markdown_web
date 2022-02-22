import '../model/article.dart';
import 'articles_pool.dart';

class SearchContextPool {
  static String _text = '';
  static List<Tag> _tags = [];

  //Text
  static void setText(String text) {
    _text = text;
  }

  static void resetText() {
    _text = '';
  }

  //Tags
  static void addTag(Tag tag) {
    _tags.add(tag);
  }

  static void removeTag(Tag tag) {
    _tags.remove(tag);
  }

  static void resetTags(){
    _tags = [];
  }

  static void reset() {
    resetText();
    resetTags();
  }

  static void search() {
  }
}