import 'article.dart';

class Folder {
  final String name;
  final List<Article> articles;
  final List<Folder> folders;

  Folder({required this.name, required this.articles, required this.folders});
  Folder.fromMap(Map data) :
      name = data['name'],
        articles = data['articles'].map((article) => Article.fromMap(article)).toList(),
        folders = data['folders'].map((folder) => Folder.fromMap(folder)).toList();

}
