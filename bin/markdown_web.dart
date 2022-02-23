import 'dart:convert';
import 'dart:io';

import 'article.dart';
import 'folder.dart';
import 'folder_analyzer.dart';

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
    var folder = Folder.fromLocalFolder(analyze(LocalFolder(articlesPath)));
    generateHomeHtml(folder, outputPath, indexFilePath);
    folder.saveAsHtml(outputPath);

    generateArticlesDataFile(outputPath, folder);
  });
}

void generateHomeHtml(Folder folder, String outputPath, String indexFilePath) {
  Article.fromLocalFile(LocalFile(indexFilePath)).toHtml().then((articleHtml) {
    var homeHtmlContext = '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="main.css">
    <link rel="stylesheet" href="uikit-3.7.6/css/uikit.css">
    <script src="uikit-3.7.6/js/uikit.js"></script>
    <script src="uikit-3.7.6/js/uikit-icons.min.js"></script>
</head>

<body>
  <div class="container-box">
    <div class="article-container">
      <span class="position"></span>
      <div class="dragbar"></div>
      <div class="ghostbar"></div>
        $articleHtml
    </div>
    <div class="side-menu">
        <div class="uk-margin">
            <form class="uk-search uk-search-default">
                <a href="" class="uk-search-icon-flip" uk-search-icon></a>
                <input class="uk-search-input" type="search" placeholder="Search">
            </form>
        </div>
      <div class="selected-tags"></div>
      <div class="folders-container">
        ${folder.toHtmlAsMenu()}
      </div>
    </div>
  </div>
<script src="main.js"></script>
</body>

</html>
''';
    var homeHtmlFile = File('$outputPath/index.html');
    homeHtmlFile.writeAsString(homeHtmlContext);
  });
}

void generateArticlesDataFile(String outputPath, Folder folder) {
  var file = File('$outputPath/data.json');
  file.writeAsString(jsonEncode(folder.toMap()));
}
