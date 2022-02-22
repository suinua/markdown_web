import 'dart:io';

class LocalFile {
  final String name;
  final String path;
  final List<String> tags;
  final String context;

  LocalFile(this.path)
      : name = path.replaceFirst(RegExp(r'(.*)\' + Platform.pathSeparator), ''),
        tags = _getTags(path),
        context = _getContext(path);

  static List<String> _getTags(String path) {
    var file = File(path);
    var context = file.readAsStringSync();
    var firstLine = context.replaceAll('\r\n', '\n').split('\n')[0];
    return firstLine.split(' ');
  }

  static String _getContext(String path) {
    var file = File(path);
    var context = file.readAsStringSync();
    return context.split('\n').sublist(1).join('\n');
  }

  Map asJson() {
    return {'name': name, 'tags': tags};
  }
}

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
}

LocalFolder analyze(LocalFolder parentFolder) {
  var node = Directory(parentFolder.path);
  var subNote = node.listSync();

  subNote.forEach((element) {
    var path = element.path;
    var fileName = path.replaceAll(RegExp(r'(.*)\' + Platform.pathSeparator), '');

    if (!fileName.contains('.')) {
      var folder = LocalFolder(path);
      parentFolder.addFolder(folder);
      analyze(folder);
    } else if (fileName.substring(fileName.length - 2, fileName.length) == 'md') {
      parentFolder.addFile(LocalFile(path));
    }
  });

  return parentFolder;
}
