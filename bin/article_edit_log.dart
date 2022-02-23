import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'article.dart';

class ArticleEditLog {
  final Committer committer;
  final String comment;
  final DateTime date;

  ArticleEditLog(this.committer, this.comment, this.date);

  String toHtml() {
    return '''
<div class="log">
<a href="${committer.url}"><img class="uk-border-pill" src="${committer.avatarUrl}" width="25px" alt="${committer.name}"></a>
${date.year} ${date.month}/${date.day} : $comment
</div>
    ''';
  }
}

class Committer {
  final String name;
  final String url;
  final String avatarUrl;

  Committer(this.name, this.url, this.avatarUrl);

  Committer.fromJson(Map json)
      : name = json['name'],
        url = json['url'],
        avatarUrl = json['avatar_url'];

  @override
  bool operator ==(Object other) {
    if (other is Committer) {
      return other.name == name;
    }
    return false;
  }

  String toHtml() {
    return '''
<a href="url"><img class="uk-border-pill" src="$avatarUrl" width="50px" alt="name"></a>
    ''';
  }
}

class ArticleEditLogService {
  static Future<List<ArticleEditLog>> getLogs(Article article) async {
    var repoName =
        Platform.environment['GITHUB_REPOSITORY'] ?? 'suinua/pmmp_sample_code';
    var branchName = Platform.environment['GITHUB_REF_NAME'] ?? 'master';

    var logs = <ArticleEditLog>[];
    var url =
        'https://api.github.com/repos/$repoName/commits?path=${(Platform.environment['INPUT_ARTICLES_DIRECTORY_PATH'] ?? 'articles')}/${article.url.replaceAll(r'\', '/')}&sha=$branchName';
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
