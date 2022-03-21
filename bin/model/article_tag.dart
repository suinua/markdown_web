class ArticleTag {
  final String text;

  ArticleTag(this.text);

  @override
  bool operator ==(Object other) {
    if (other is ArticleTag) {
      return text == other.text;
    }

    return false;
  }
}
