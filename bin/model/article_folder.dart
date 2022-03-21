import 'dart:io';

import 'article_file.dart';

class ArticleFolder {
  final String name;
  final String absolutePath;
  final List<ArticleFile> files;
  final List<ArticleFolder> folders;

  ArticleFolder(
      {required this.name,
      required this.absolutePath,
      required this.files,
      required this.folders});

  ArticleFolder.fromDirectory(Directory directory)
      : absolutePath = directory.absolute.path,
        name = directory.absolute.path
            .replaceFirst(RegExp(r'(.*)\' + Platform.pathSeparator), ''),
        files = [],
        folders = [];

  void addFolder(ArticleFolder folder) {
    folders.add(folder);
  }

  void addFile(ArticleFile file) {
    files.add(file);
  }

  Future<void> analyze() async {
    var directory = Directory(absolutePath);

    var children = directory.listSync();
    await Future.forEach<FileSystemEntity>(children, (child) async {
      var fileType = child.statSync().type.toString();
      if (fileType == FileSystemEntityType.directory.toString()) {
        var childArticleFolder = ArticleFolder.fromDirectory(Directory(child.absolute.path));
        await childArticleFolder.analyze();
        addFolder(childArticleFolder);
      } else if(child.path.contains('.md')) {
        var articleFile = ArticleFile.fromFile(File(child.absolute.path));
        await articleFile.setUpMarkdownAndIndex();
        addFile(articleFile);
      }
    });
  }

  Map asMap() {
    var filesAsJson = [];
    files.forEach((element) {
      filesAsJson.add(element.asMap());
    });

    var foldersAsJson = [];
    folders.forEach((element) {
      foldersAsJson.add(element.asMap());
    });

    return {
      'name': name,
      'articles': filesAsJson,
      'folders': foldersAsJson,
    };
  }
}
