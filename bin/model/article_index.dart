class ArticleIndex {
  final IndexLevel level;
  final String text;
  final String href;

  ArticleIndex(this.level, this.text, this.href);

  ArticleIndex.fromMap(Map data)
      : level = IndexLevel._(data['level']),
        text = data['text'],
        href = data['href'];

  Map<String, dynamic> toMap() {
    return {
      'level': level.toString(),
      'text': text,
      'href': href,
    };
  }
}

class IndexLevel {
  final String _value;

  IndexLevel._(this._value);

  static final h1 = IndexLevel._('h1');
  static final h2 = IndexLevel._('h2');
  static final h3 = IndexLevel._('h3');
  static final h4 = IndexLevel._('h4');

  IndexLevel.fromInt(int value) : _value = 'h$value';

  @override
  String toString() {
    return _value;
  }
}
