import 'article.dart';

class ArticleFolder {
  final String name;
  final List<Article> articles;
  final List<ArticleFolder> folders;

  List<Article> getAllArticles() {
    var subArticles = <Article>[];
    folders.forEach((folder) {
      subArticles.addAll(folder.getAllArticles());
    });
    return articles + subArticles;
  }

  const ArticleFolder({
    required this.name,
    required this.articles,
    required this.folders,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleFolder &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          articles == other.articles &&
          folders == other.folders);

  @override
  int get hashCode => name.hashCode ^ articles.hashCode ^ folders.hashCode;

  @override
  String toString() {
    return 'ArticleFolder{' +
        ' name: $name,' +
        ' articles: $articles,' +
        ' folders: $folders,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'articles': articles,
      'folders': folders,
    };
  }

  factory ArticleFolder.fromMap(Map<String, dynamic> map) {
    return ArticleFolder(
      name: map['name'] as String,
      articles: (map['articles'] as List<Map>).map((e) => Article.fromMap(map)).toList(),
      folders: (map['folders'] as List<Map>).map((e) => ArticleFolder.fromMap(map)).toList(),
    );
  }
}
