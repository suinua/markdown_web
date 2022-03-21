class Article {
  final String uuid;
  final String title;
  final String body;
  final List<String> tags;

  const Article({
    required this.uuid,
    required this.title,
    required this.body,
    required this.tags,
  });


  factory Article.fromMap(Map map) {
    return Article(
      uuid: map['uuid'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      tags: map['tags'] as List<String>,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is Article) {
      return other.uuid == uuid;
    }

    return false;
  }
}