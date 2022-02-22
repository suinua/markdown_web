import 'article.dart';

class Folder {
  final String name;
  final List<Article> articles;
  final List<Folder> folders;

  Folder({required this.name, required this.articles, required this.folders});

  Folder.fromMap(Map data)
      : name = data['name'],
        articles = data['articles']
            .map((article) => Article.fromMap(article))
            .toList().cast<Article>(),
        folders =
            data['folders'].map((folder) => Folder.fromMap(folder)).toList().cast<Folder>();

  List<Article> getAllArticles() {
    var subArticles = <Article>[];
    folders.forEach((folder) {
      subArticles.addAll(folder.getAllArticles());
    });
    return articles + subArticles;
  }
}
