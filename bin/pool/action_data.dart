import 'dart:io';
import 'package:path/path.dart' as path;

import '../model/article_file.dart';
import 'path_pool.dart';

class ActionData {
  static String ghPageIndexUrl() {
    var repositoryName = repoName();
    var owner = ownerName();

    if (repositoryName == '$owner.github.io') {
      return 'https://$owner.github.io/';
    } else {
      return 'https://$owner.github.io/$repositoryName/';
    }
  }

  static String ghPageUrl(ArticleFile file) {
    //todo:記事の中のフォルダにgetArticlesFolderName()を使えない
    return path.join(
        ghPageIndexUrl(),
        file.absolutePath
            .replaceAll(r'\', '/')
            .replaceFirst(RegExp('(.*)/${PathPool.articlesDirName()}/'), '')
            .replaceFirst('.md', '.html'));
  }

  static String fileUrlOnGithub(ArticleFile file) {
    return path.join(
        PathPool.articlesDirName(),
        ghPageUrl(file)
            .replaceFirst(ghPageIndexUrl(), '')
            .replaceFirst('.html', '.md'));
  }

  static String thumbnailsUrl() {
    return path.join(ghPageIndexUrl(), 'thumbnails');
  }

  static String actorName() {
    return Platform.environment['GITHUB_ACTOR'] ?? 'suinua';
  }

  static String ownerName() {
    return Platform.environment['GITHUB_REPOSITORY_OWNER'] ?? 'suinua';
  }

  static String branchName() {
    return Platform.environment['GITHUB_REF_NAME'] ?? 'master';
  }

  static String repoName() {
    return Platform.environment['GITHUB_REPOSITORY']
        ?.replaceFirst(RegExp('(.*)/'), '') ??
        'markdown_web';
  }

  static String repository() {
    return Platform.environment['GITHUB_REPOSITORY'] ?? 'suinua/markdown_web';
  }

  static String token() {
    var token = Platform.environment['GITHUB_TOKEN'];

    return token ?? '';
  }
}