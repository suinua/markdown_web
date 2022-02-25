import 'dart:io';

import 'local_file.dart';
import 'local_folder.dart';

class FolderAnalyzer {
  static LocalFolder execute(LocalFolder parentFolder) {
    var node = Directory(parentFolder.path);
    var subNote = node.listSync();

    subNote.forEach((element) {
      var path = element.path;
      var fileName = path.replaceAll(RegExp(r'(.*)\' + Platform.pathSeparator), '');

      if (!fileName.contains('.')) {
        //todo:コードおかしくね？
        var folder = LocalFolder(path);
        parentFolder.addFolder(folder);
        execute(folder);
      } else if (fileName.substring(fileName.length - 2, fileName.length) == 'md') {
        parentFolder.addFile(LocalFile(path));
      }
    });

    return parentFolder;
  }
}