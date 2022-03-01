import '../model/article_edit_log.dart';
import '../model/committer.dart';

class ArticleDetailView {
  static toHtml(List<ArticleEditLog> logs, List<Committer> committerList) {
    var logsHtml = logs.map((e) => _editLogToHtml(e)).join();
    var committerHtml = committerList.map((e) => _committerToHtml(e)).join();

    return '''
<div class="article-detail">
  <div class="article-menu-committer-list">$committerHtml</div>
  <div class="article-menu-logs">$logsHtml</div>
</div>
      ''';
  }

  static String _committerToHtml(Committer committer) {
    return '''
<div class="${Committer.ICON_CLASS_NAME}">
<a href="${committer.url}"><img class="uk-border-pill" src="${committer.avatarUrl}" width="40px" alt="name"></a>
</div>
    ''';
  }

  static String _editLogToHtml(ArticleEditLog editLog) {
    return '''
<div class="${ArticleEditLog.CLASS_NAME}">
<img class="uk-border-pill" src="${editLog.committer.avatarUrl}" width="25px" alt="${editLog.committer.name}">
${editLog.date.year} ${editLog.date.month}/${editLog.date.day} : ${editLog.comment}
</div>
    ''';
  }
}
