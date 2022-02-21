import 'dart:io';

import 'folder_analyzer.dart';
import 'article.dart';

class Folder {
  final String name;
  final List<Article> articles;
  final List<Folder> folders;

  Folder({required this.name, required this.articles, required this.folders});

  Folder.fromLocalFolder(LocalFolder localFolder)
      : articles =
            localFolder.files.map((e) => Article.fromLocalFile(e)).toList(),
        folders =
            localFolder.folders.map((e) => Folder.fromLocalFolder(e)).toList(),
        name = localFolder.name;

  String toHtmlAsMenu() {
    var children = '';
    folders.forEach((element) {
      children += element.toHtmlAsMenu();
    });
    articles.forEach((element) {
      children += element.toHtmlAsMenu();
    });

    return '''
<div class="folder" id="$name">
    <div class="folder-name">
      <span uk-icon="chevron-down"></span>$name 
      <span uk-icon="folder"></span>${folders.length}
      <span uk-icon="file-text"></span>${articles.length} 
    </div>
    <div class="children" id="$name-children">
        $children
    </div>
</div>
''';
  }

  void saveAsHtml(String parentPath) {
    var path = parentPath + Platform.pathSeparator + name;
    Directory(path).create().then((_){
      if (articles.length + folders.length == 0) {
        File(path + Platform.pathSeparator + '.gitkeep').create();
      }
      articles.forEach((article) {
        article.saveAsHtml(path);
      });

      folders.forEach((folder) {
        folder.saveAsHtml(path);
      });
    });
  }
}
