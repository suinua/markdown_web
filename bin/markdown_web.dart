import 'dart:io';

import 'folder.dart';
import 'folder_analyzer.dart';

void main() {
  var env = Platform.environment;

  var articlesPath ='${env['GITHUB_WORKSPACE']}/' + env['INPUT_ARTICLESDIRECTORYPATH']!;
  var outputPath = Directory.current.path + '/output';

  Directory(outputPath).create().then((_){
    var folder = Folder.fromLocalFolder(analyze(LocalFolder(articlesPath)));
    generateHomeHtml(folder, outputPath);
    folder.saveAsHtml(outputPath);
  });
}

void generateHomeHtml(Folder folder, String outputPath) {
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
    <div class="container" id="article-container">
        aaaaaa
    </div>
    <div class="container-divider"></div>
    <div class="container">
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
}