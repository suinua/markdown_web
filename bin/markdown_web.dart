import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

import 'custom_logger.dart';
import 'model/article_file.dart';
import 'model/article_folder.dart';
import 'service/github_action_service.dart';
import 'service/thumbnail_service.dart';
import 'view/page.dart';

void main(List<String> arguments) async {
  CustomLogger.normal.i('Start Converting');
  var folder = ArticleFolder.fromDirectory(
      Directory(GithubActionService.getArticlesFolderPath()));
  await folder.analyze();
  await exportArticleTopFolder(folder);
  CustomLogger.normal.i('Finish Converting');

  CustomLogger.normal.i('Save Data File');
  try {
    File(path.join(GithubActionService.getExportPath(),'data.json')).writeAsStringSync(jsonEncode(folder.asMap()));
  } catch(e) {
    CustomLogger.simple.w(e);
  }
}

Future<void> exportArticleTopFolder(ArticleFolder topFolder) async {
  await Directory(GithubActionService.getExportPath()).create();

  await Future.forEach<ArticleFile>(topFolder.files, (article) async {
    await exportArticleFile(
        GithubActionService.getExportPath(), topFolder, article);
  });

  await Future.forEach<ArticleFolder>(topFolder.folders, (folder) async {
    await exportArticleFolder(
        GithubActionService.getExportPath(), folder, topFolder);
  });
}

Future<void> exportArticleFolder(parentPath, ArticleFolder folder, ArticleFolder topParentFolder) async {

  var folderPath = path.join(parentPath, folder.name);
  await Directory(folderPath).create();

  CustomLogger.normal.i('export folder : $folderPath');

  if (folder.files.length + folder.folders.length == 0) {
    await File(path.join(folderPath, '.gitkeep')).create();
  }

  await Future.forEach<ArticleFile>(folder.files, (article) async {
    await exportArticleFile(folderPath, topParentFolder, article);
  });

  await Future.forEach<ArticleFolder>(folder.folders, (folder) async {
    await exportArticleFolder(folderPath, folder, topParentFolder);
  });
}

Future<void> exportArticleFile(
    String folderPath, ArticleFolder topFolder, ArticleFile articleFile) async {
  var filePath = path.join(folderPath, '${articleFile.articleTitle}.html');
  var file = File(filePath);
  var html = await Page.html(topFolder, articleFile);
  await file.writeAsString(html);

  CustomLogger.normal.i('export file : $filePath');

  await ThumbNailService.generateImage(articleFile.articleTitle);
}
