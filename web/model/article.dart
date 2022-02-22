class Article {
  final List<Tag> tags;
  final String title;
  final String body;
  final String url;

  Article(
      {required this.tags,
      required this.title,
      required this.body,
      required this.url});

  Article.fromMap(Map data)
      : tags = data['tags'].map((text) => Tag(text)).toList(),
        title = data['title'],
        body = data['body'],
        url = data['url'];
}

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
}
