class Article {
  final String title;
  final String body;
  final List<String> tags;

  const Article({
    required this.title,
    required this.body,
    required this.tags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Article &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              body == other.body &&
              tags == other.tags
          );


  @override
  int get hashCode =>
      title.hashCode ^
      body.hashCode ^
      tags.hashCode;


  @override
  String toString() {
    return 'Article{' +
        ' title: $title,' +
        ' body: $body,' +
        ' tags: $tags,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'tags': tags,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      body: map['body'] as String,
      tags: map['tags'] as List<String>,
    );
  }
}