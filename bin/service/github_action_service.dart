import 'dart:io';

import 'package:path/path.dart' as path;

import '../model/article_file.dart';

class GithubActionService {
  static String getGhPageIndexUrl() {
    return 'https://${getOwnerName()}.github.io/${getRepoName()}/';
  }

  static String getGhPageUrl(ArticleFile file) {
    //todo:記事の中のフォルダにgetArticlesFolderName()を使えない
    return path.join(getGhPageIndexUrl(),
        file.absolutePath
            .replaceAll(r'\', '/')
            .replaceFirst(
                RegExp('(.*)/${getArticlesFolderName()}/'), '')
            .replaceFirst('.md', '.html'));
  }

  static String getFileUrlForGithubAPI(ArticleFile file) {
    return path.join(getArticlesFolderName(),
        getGhPageUrl(file)
            .replaceFirst(getGhPageIndexUrl(), '')
            .replaceFirst('.html', '.md'));
  }

  static String getThumbnailsUrl() {
    return path.join(getGhPageIndexUrl(), 'thumbnails');
  }

  static String getActorName() {
    return Platform.environment['GITHUB_ACTOR'] ?? 'suinua';
  }

  static String getOwnerName() {
    return Platform.environment['GITHUB_REPOSITORY_OWNER'] ?? 'suinua';
  }

  static String getBranchName() {
    return Platform.environment['GITHUB_REF_NAME'] ?? 'master';
  }

  static String getRepoName() {
    return Platform.environment['GITHUB_REPOSITORY']
            ?.replaceFirst(RegExp('(.*)/'), '') ??
        'markdown_web';
  }

  static String getRepository() {
    return Platform.environment['GITHUB_REPOSITORY'] ?? 'suinua/markdown_web';
  }

  static String getGithubToken() {
    var token = Platform.environment['GITHUB_TOKEN'];

    return token ?? '';
  }

  static String ASSETS_FOLDER_NAME = 'assets';
  static String getAssetsFolderPath() {
    var env = Platform.environment;
    return path.join(env['GITHUB_ACTION_PATH'] ?? _basedPathForDebug(), ASSETS_FOLDER_NAME);
  }

  static String EXPORT_FOLDER_NAME = 'export';

  static String getExportPath() {
    var env = Platform.environment;
    return path.join(
        env['GITHUB_ACTION_PATH'] ?? _basedPathForDebug(),
        EXPORT_FOLDER_NAME);
  }

  static String getExportThumbnailPath() {
    return path.join(getExportPath(), 'thumbnails');
  }

  static String getArticlesFolderName() {
    var dirPath = Platform.environment['ARTICLES_DIRECTORY_PATH'];
    return dirPath ?? 'articles';
  }

  static String getArticlesFolderPath() {
    var env = Platform.environment;
    return path.join(env['GITHUB_WORKSPACE'] ?? _basedPathForDebug(), getArticlesFolderName());
  }

  static String _basedPathForDebug() {
    return Platform.script.path
        .replaceRange(0, 1, '')
        .replaceFirst(RegExp('bin(.*)'), '');
  }
}
