import 'article_index.dart';
import 'tag.dart';

class Article {
  final String uuid;
  final List<Tag> tags;
  final String title;
  final String body;
  final String url;
  final List<ArticleIndex> indexList;

  Article(
      {required this.uuid,
        required this.tags,
        required this.title,
        required this.body,
        required this.url,
        required this.indexList});

  Article.fromMap(Map<String,dynamic> data)
      : uuid = data['uuid'],
        tags = data['tags'].map((text) => Tag(text)).toList().cast<Tag>(),
        title = data['title'],
        body = data['body'],
        url = data['url'],
        indexList = data['index_list'].map((e) => ArticleIndex.fromMap(e)).toList().cast<ArticleIndex>();

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'tags': tags.map((e) => e.text).toList(),
      'title': title,
      'body': body,
      'url': url,
      'index_list': indexList.map((e) => e.toMap()).toList(),
    };
  }
}