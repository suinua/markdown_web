import 'article.dart';

class Folder {
  final String name;
  final String uuid;
  final List<Article> articles;
  final List<Folder> folders;

  Folder({required this.name, required this.uuid, required this.articles, required this.folders});

  Folder.fromMap(Map data)
      : name = data['name'],
        uuid = data['uuid'],
        articles = data['articles']
            .map((article) => Article.fromMap(article))
            .toList().cast<Article>(),
        folders =
        data['folders'].map((folder) => Folder.fromMap(folder)).toList().cast<Folder>();

  Map<String, dynamic> toMap() {
    var articlesAsMapList = [];
    articles.forEach((article) {
      articlesAsMapList.add(article.toMap());
    });

    var foldersAsMapList = [];
    folders.forEach((folder) {
      foldersAsMapList.add(folder.toMap());
    });

    return {
      'name': name,
      'articles': articlesAsMapList,
      'folders': foldersAsMapList,
    };
  }

  List<Article> getAllArticles() {
    var subArticles = <Article>[];
    folders.forEach((folder) {
      subArticles.addAll(folder.getAllArticles());
    });
    return articles + subArticles;
  }
}
