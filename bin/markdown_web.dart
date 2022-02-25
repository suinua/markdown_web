import 'dart:convert';
import 'dart:io';

import '../common/model/folder.dart';
import '../common/view/main_page.dart';
import 'folder_analyzer.dart';
import 'folder_service.dart';
import 'local_file.dart';
import 'local_folder.dart';

void main() {
  var env = Platform.environment;

  var debug = !env.keys.contains('GITHUB_WORKSPACE');
  var articlesPath = '';
  var outputPath = '';
  var indexFilePath = '';

  if (debug) {
    var basePath = Platform.script
        .toString()
        .replaceAll('file:///', '')
        .replaceAll('/bin/markdown_web.dart', '')
        .replaceAll('/', Platform.pathSeparator);
    articlesPath = basePath + Platform.pathSeparator + 'articles';
    outputPath = basePath + Platform.pathSeparator + 'output';
    indexFilePath = articlesPath + Platform.pathSeparator + 'index.md';
  } else {
    articlesPath =
        '${env['GITHUB_WORKSPACE']}/' + env['INPUT_ARTICLES_DIRECTORY_PATH']!;
    outputPath = Directory.current.path + '/output';
    indexFilePath =
        '${env['GITHUB_WORKSPACE']}/' + env['INPUT_INDEX_FILE_PATH']!;
  }

  Directory(outputPath).create().then((_) {
    var folder = FolderAnalyzer.execute(LocalFolder(articlesPath)).toFolder();
    saveMainPage(folder, outputPath, indexFilePath);
    FolderService.saveAsHtml(outputPath, folder);

    generateArticlesDataFile(outputPath, folder);
  });
}

void saveMainPage(Folder folder, String outputPath, String indexFilePath) {
  var indexArticle = LocalFile(indexFilePath).toArticle();
  MainPage.generate(folder, outputPath, indexArticle).then((htmlContext){
    var homeHtmlFile = File('$outputPath/index.html');
    homeHtmlFile.writeAsString(htmlContext);
  });
}

void generateArticlesDataFile(String outputPath, Folder folder) {
  var file = File('$outputPath/data.json');
  file.writeAsString(jsonEncode(folder.toMap()));
}
