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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'articles': articles,
      'folders': folders,
    };
  }

  factory ArticleFolder.fromMap(Map map) {
    return ArticleFolder(
      name: map['name'] as String,
      articles: map['articles']
          .map((e) => Article.fromMap(e))
          .toList()
          .cast<Article>(),
      folders: map['folders']
          .map((e) => ArticleFolder.fromMap(e))
          .toList()
          .cast<ArticleFolder>(),
    );
  }
}
