import 'dart:io';

import 'package:uuid/uuid.dart';

import '../common/model/article.dart';
import '../common/model/folder.dart';
import 'local_file.dart';

class LocalFolder {
  final String name;
  final String path;
  List<LocalFile> files = [];
  List<LocalFolder> folders = [];

  LocalFolder(this.path)
      : name = path.replaceFirst(RegExp(r'(.*)\' + Platform.pathSeparator), '');

  void addFolder(LocalFolder folder) {
    folders.add(folder);
  }

  void addFile(LocalFile file) {
    files.add(file);
  }

  Map asJson() {
    var filesAsJson = [];
    files.forEach((element) {
      filesAsJson.add(element.asJson());
    });

    var foldersAsJson = [];
    folders.forEach((element) {
      foldersAsJson.add(element.asJson());
    });

    return {
      'name': name,
      'files': filesAsJson,
      'folders': foldersAsJson,
    };
  }

  Future<Folder> toFolder() async {
    var resultArticles = <Article>[];
    var resultFolders = <Folder>[];

    for (var i = 0; i < files.length; i++) {
      resultArticles.add(await files[i].toArticle());
    }

    for (var i = 0; i < folders.length; i++) {
      resultFolders.add(await folders[i].toFolder());
    }

    return Folder(
      name: name,
      uuid: Uuid().v4(),
      articles: resultArticles,
      folders: resultFolders,
    );
  }
}
