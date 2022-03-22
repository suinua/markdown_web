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

  static String getArticlesFolderName() {
    var token = Platform.environment['ARTICLES_DIRECTORY_PATH'];
    return token ?? 'articles';
  }

  static String getArticlesFolderPath() {
    var env = Platform.environment;
    if (env.keys.contains('GITHUB_WORKSPACE')) {
      return path.join(env['GITHUB_WORKSPACE']!, getArticlesFolderName());
    } else {
      //for debug
      return path.join(getBasePath(), 'articles');
    }
  }

  static String EXPORT_FOLDER_NAME = 'export';
  static String getExportPath() {
    return path.join(getBasePath(), EXPORT_FOLDER_NAME);
  }

  static String ASSETS_FOLDER_NAME = 'assets';

  static String getAssetsFolderPath() {
    return path.join(getBasePath(), ASSETS_FOLDER_NAME);
  }

  static String getExportThumbnailPath() {
    return path.join(getExportPath(), 'thumbnails');
  }

  static String getBasePath() {
    var env = Platform.environment;
    if (env.keys.contains('GITHUB_WORKSPACE')) {
      return path.join(env['GITHUB_WORKSPACE']!);
    } else {
      //for debug
      return Platform.script.path
          .replaceRange(0, 1, '')
          .replaceFirst(RegExp('bin(.*)'), '');
    }
  }
}
