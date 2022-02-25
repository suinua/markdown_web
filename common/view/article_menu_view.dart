import '../model/article.dart';
import '../model/article_edit_log.dart';
import '../model/committer.dart';
import '../model/tag.dart';

class ArticleMenuView {
  static String html(Article article, List<ArticleEditLog> logs,
      List<Committer> committerList) {
    var logsHtml = logs.map((e) => _editLogToHtml(e)).join();
    var committerHtml = committerList.map((e) => _committerToHtml(e)).join();
    var tagsAsHtml =
        article.tags.map((tag) => _tagToArticleMenuHtml(tag)).toList().join();


    return '''
<div class="article-menu">
    <div class="article-menu-tags">$tagsAsHtml</div>
    <div class="article-detail">
      <div class="article-menu-committer-list">$committerHtml</div>
      <div class="article-menu-logs">$logsHtml</div>
    </div>
    <div class="article-menu-index"></div>
</div>
''';
  }

  static String _tagToArticleMenuHtml(Tag tag) {
    return '''<div class="${Tag.ON_ARTICLE_MENU_CLASS_NAME}">#${tag.text}</div>''';
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
