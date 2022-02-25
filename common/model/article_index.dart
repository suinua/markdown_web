class ArticleIndex {
  final ArticleIndexId id;
  final IndexLevel level;
  final String text;

  ArticleIndex(this.id, this.level, this.text);

  ArticleIndex.fromMap(Map data)
      : id = ArticleIndexId(data['id']),
        level = IndexLevel._(data['level']),
        text = data['text'];

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'level': level.toString(),
      'text': text,
    };
  }
}

class ArticleIndexId {
  final String _id;

  ArticleIndexId(this._id);

  @override
  bool operator ==(Object other) {
    if (other is ArticleIndexId) {
      return other._id == _id;
    }

    return false;
  }

  @override
  String toString() {
    return _id;
  }
}

class IndexLevel {
  final String _value;

  IndexLevel._(this._value);

  static final h1 = IndexLevel._('h1');
  static final h2 = IndexLevel._('h2');
  static final h3 = IndexLevel._('h3');
  static final h4 = IndexLevel._('h4');
  IndexLevel.fromInt(int value):_value = 'h$value';

  @override
  String toString() {
    return _value;
  }
}
