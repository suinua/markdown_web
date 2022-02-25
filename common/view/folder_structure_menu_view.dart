import '../model/article.dart';
import '../model/folder.dart';
import '../model/tag.dart';

class FolderLikeMenuView {
  static String html(Folder folder) {
    var children = '';
    var index = 0;
    folder.articles.forEach((article) {
      children += _articleToHtml(article, index == folder.articles.length - 1);
      index++;
    });

    folder.folders.forEach((folder) {
      children += html(folder);
    });

    return '''
<div class="folder" folder-uuid="${folder.uuid}">
    <span uk-icon="chevron-down"></span>${folder.name} 
    <span uk-icon="folder"></span>${folder.folders.length}
    <span uk-icon="file-text"></span>${folder.articles.length} 
    <div class="folder-children" folder-uuid="${folder.uuid}">
        $children
    </div>
</div>
''';
  }

  static String _articleToHtml(Article article, bool isLast) {

    return '''
<div class="article-menu-item">
  <div class="article-on-menu" article-uuid="${article.uuid}" url="${article.url}">
      <div class="article-title">${isLast ? '└─' : '├─' }<div class="article-title-text" article-uuid="${article.uuid}">${article.title}</div></div>
  </div>
  <div class="tag-button" article-uuid="${article.uuid}"><span uk-icon="tag"></span></div>
  <div class="tags" article-uuid="${article.uuid}">${article.tags.map((tag) => _tagToFolderStructureMenuHtml(tag)).toList().join()}</div>
</div>
''';
  }

  static String _tagToFolderStructureMenuHtml(Tag tag) {
    return '''<a class="folder-structure-menu-tag">#${tag.text}</a>''';
  }
}
