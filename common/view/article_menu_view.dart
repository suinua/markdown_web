import '../model/article.dart';
import '../model/article_index.dart';
import '../model/folder.dart';
import '../model/tag.dart';
import 'folder_structure_menu_view.dart';

class ArticleMenuView {
  static String html(Folder topFolder, Article article) {
    var tagsAsHtml =
        article.tags.map((tag) => _tagToArticleMenuHtml(tag)).toList().join();

    var context = '''
    <div class="article-menu-tags">
       $tagsAsHtml
    </div>
    <div class="article-menu-index">
    <div class="article-menu-title">目次</div>
    ${_indexListToHtml(article.indexList)}
    </div>
    
     <div class="search-and-folders-container">
        <label><input class="search-input" type="search" placeholder="Search"></label>
        <div class="selected-tags"></div>
        <div class="folders-container"> ${FolderStructureMenuView.html(topFolder)}</div>
      </div>
''';

    return '''
<div class="article-menu">
    $context
</div>
<div id="offcanvas-slide" uk-offcanvas>
    <div class="uk-offcanvas-bar">
        $context
    </div>
</div>
''';
  }

  static String _tagToArticleMenuHtml(Tag tag) {
    return '''<div class="${Tag.ON_ARTICLE_MENU_CLASS_NAME}">#${tag.text}</div>''';
  }

  static String _indexListToHtml(List<ArticleIndex> indexList) {
    var indexListHtml = indexList.map((e) => '''
<li class="article-index-item article-index-item-${e.level.toString()} uk-flex">
    <a href="#${Uri.parse(e.href)}" class="uk-flex uk-link-reset">
    <div class="mark-filled">${e.text}</div>
    </a>
</li>
''');

    return '''
<ul uk-scrollspy-nav="closest: li" class="article-nav uk-overflow-auto">
  ${indexListHtml.join()}
</ul>
''';
  }
}