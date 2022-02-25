import 'tag.dart';

class Article {
  final String uuid;
  final List<Tag> tags;
  final String title;
  final String body;
  final String url;

  Article(
      {required this.uuid,
        required this.tags,
        required this.title,
        required this.body,
        required this.url});

  Article.fromMap(Map<String,dynamic> data)
      : uuid = data['uuid'],
        tags = data['tags'].map((text) => Tag(text)).toList().cast<Tag>(),
        title = data['title'],
        body = data['body'],
        url = data['url'];

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'tags': tags.map((e) => e.text).toList(),
      'title': title,
      'body': body,
      'url': url
    };
  }
}