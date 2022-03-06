import 'dart:convert';
import 'dart:io';

import '../common/model/folder.dart';
import 'folder_analyzer.dart';
import 'folder_service.dart';
import 'local_folder.dart';

void main() {
  var env = Platform.environment;

  var debug = !env.keys.contains('GITHUB_WORKSPACE');
  var articlesPath = '';
  var outputPath = '';

  if (debug) {
    var basePath = Platform.script
        .toString()
        .replaceAll('file:///', '')
        .replaceAll('/bin/markdown_web.dart', '')
        .replaceAll('/', Platform.pathSeparator);
    articlesPath = basePath + Platform.pathSeparator + 'articles';
    outputPath = basePath + Platform.pathSeparator + 'output';
  } else {
    articlesPath =
        '${env['GITHUB_WORKSPACE']}/' + env['INPUT_ARTICLES_DIRECTORY_PATH']!;
    outputPath = Directory.current.path + '/output';
  }

  Directory(outputPath).create().then((_) {
    var folder = FolderAnalyzer.execute(LocalFolder(articlesPath)).toFolder();
    FolderService.saveTopFolder(folder, outputPath+'/');

    generateArticlesDataFile(outputPath, folder);
  });
}

void generateArticlesDataFile(String outputPath, Folder folder) {
  var file = File('$outputPath/data.json');
  file.writeAsString(jsonEncode(folder.toMap()));
}
