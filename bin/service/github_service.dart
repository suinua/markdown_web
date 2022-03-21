import 'dart:convert';

import 'package:http/http.dart' as http;

import '../custom_logger.dart';
import '../model/article_edit_log.dart';
import '../model/article_file.dart';
import '../model/committer.dart';
import 'github_action_service.dart';

class GithubService {
  static Future<List<ArticleEditLog>> getLogs(ArticleFile article) async {
    var branchName = GithubActionService.getBranchName();
    var logs = <ArticleEditLog>[];
    var url =
        'https://api.github.com/repos/${GithubActionService.getRepository()}/commits?cliend_id=${GithubActionService.getGithubToken()}?path=${GithubActionService.getFileUrlForGithubAPI(article)}&sha=$branchName';
    CustomLogger.simple.i('github api : $url');
    try {
      var response = await http.get(Uri.parse(url));

      var data = jsonDecode(response.body);
      data.forEach((commitAsMap) {
        var committer = Committer.fromJson(commitAsMap['committer']);
        var comment = commitAsMap['commit']['message'];
        var date = DateTime.parse(commitAsMap['commit']['committer']['date']);
        logs.add(ArticleEditLog(committer, comment, date));
      });
    } catch (e) {
      CustomLogger.trace.w('Is this repository private? this action only work in public repository.\nAnd The maximum number of accesses per hour is 5000, so be sure that the number of files does not exceed that limit.');
    }

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
