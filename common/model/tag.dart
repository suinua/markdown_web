class Tag {
  final String text;

  Tag(this.text);

  @override
  bool operator ==(Object other) {
    if (other is Tag) {
      return text == other.text;
    }

    return false;
  }

  static const String ON_ARTICLE_MENU_CLASS_NAME = 'article-menu-tag';
}
