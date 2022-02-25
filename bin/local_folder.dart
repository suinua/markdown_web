import 'dart:io';

import 'package:uuid/uuid.dart';

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

  Folder toFolder() {
    return Folder(
        name : name,
        uuid : Uuid().v4(),
        articles : files.map((e) => e.toArticle()).toList(),
        folders : folders.map((e) => e.toFolder()).toList(),
    );
  }
}