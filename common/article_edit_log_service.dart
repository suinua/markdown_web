import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'model/article.dart';
import 'model/article_edit_log.dart';
import 'model/committer.dart';

class ArticleEditLogService {
  static Future<List<ArticleEditLog>> getLogs(Article article) async {
    var repoName = Platform.environment['GITHUB_REPOSITORY'] ?? 'suinua/markdown_web';
    var branchName = Platform.environment['GITHUB_REF_NAME'] ?? 'master';

    var logs = <ArticleEditLog>[];
    var url =
        'https://api.github.com/repos/$repoName/commits?path=${(Platform.environment['INPUT_ARTICLES_DIRECTORY_PATH'] ?? 'articles')}/${article.url.replaceAll(r'\', '/').replaceAll('.html', '.md')}&sha=$branchName';
    var response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body);
    data.forEach((commitAsMap) {
      var committer = Committer.fromJson(commitAsMap['committer']);
      var comment = commitAsMap['commit']['message'];
      var date = DateTime.parse(commitAsMap['commit']['committer']['date']);
      logs.add(ArticleEditLog(committer, comment, date));
    });
    return logs;
  }

  static List<Committer> getCommitterList(List<ArticleEditLog> logs) {
    var committerList = <Committer>[];
    logs.forEach((log) {
      if (!committerList.contains(log.committer)) {
        committerList.add(log.committer);
      }
    });

    return committerList;
  }
}
