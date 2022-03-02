
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
  static bool addTag(Tag tag) {
    if (_tags.contains(tag)) {
      return false;
    }

    _tags.add(tag);
    return true;
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