
import '../../common/model/tag.dart';

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

  static String getText() {
    return _text;
  }

  //Tags
  static void addTag(Tag tag) {
    _tags.add(tag);
  }

  static void removeTag(Tag tag) {
    _tags.remove(tag);
  }

  static List<Tag> getTags(){
    return _tags;
  }

  static void resetTags(){
    _tags = [];
  }

  static void reset() {
    resetText();
    resetTags();
  }
}