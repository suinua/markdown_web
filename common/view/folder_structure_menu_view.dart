import 'package:universal_html/html.dart';

import '../../web/pool/search_context_pool.dart';
import '../../web/service/search_service.dart';
import '../model/article.dart';
import '../model/folder.dart';
import '../model/tag.dart';

class FolderStructureMenuView {
  static String html(Folder folder) {
    var children = '';
    var index = 0;
    folder.articles.forEach((article) {
      children += _articleToHtml(article, index == folder.articles.length - 1);
      index++;
    });

    var folders = folder.folders;
    folders.sort((a, b) =>
        (b.folders.length + b.articles.length).compareTo(
            a.folders.length + a.articles.length));
    folders.forEach((folder) {
      children += html(folder);
    });

    return '''
<div class="folder" folder-uuid="${folder.uuid}">
    <div class="folder-text">
      <span uk-icon="chevron-down"></span>${folder.name} 
      <span uk-icon="folder"></span>${folder.folders.length}
      <span uk-icon="file-text"></span>${folder.articles.length}
    </div><div class="folder-divider"></div>
</div>
<div class="folder-children" folder-uuid="${folder.uuid}">
    $children
</div>
''';
  }

  static String _articleToHtml(Article article, bool isLast) {
    return '''
<div class="article-menu-item">
  <div class="article-on-menu">
      <div class="article-title">${isLast ? '└─' : '├─'}<div class="article-title-text" article-uuid="${article.uuid}"><a class="uk-link-reset" href="${article.url}"  target="_blank">${article.title}</a></div></div>
  </div>
  <div class="tags" article-uuid="${article.uuid}">${article.tags.map((tag) => _tagToFolderStructureMenuHtml(tag)).toList().join()}</div>
</div>
''';
  }

  static String _tagToFolderStructureMenuHtml(Tag tag) {
    return '''<a class="folder-structure-menu-tag" tag-text="${tag.text}">#${tag.text}</a>''';
  }
}

class FolderStructureMenuViewController {
  static void setUp() {
    querySelectorAll('.folder-structure-menu-tag').forEach((tagElement) {
      tagElement.onClick.listen((event) => selectTag(event, tagElement));
    });

    var searchInputs = querySelectorAll('.search-input').cast<InputElement>();
    searchInputs.forEach((searchInput) {
      searchInput.onInput.listen((event) {
        SearchContextPool.setText(searchInput.value!);
        highlightArticles(SearchService.filterBySearchContext());
        searchInputs.forEach((e) => e.value = searchInput.value);
      });
    });

    querySelectorAll('.folder').forEach((folder) {
      folder.onClick.listen((event) => foldOrUnfoldFolder(event, folder));
    });
  }

  static void foldOrUnfoldFolder(MouseEvent event, Element clickedFolder) {
    var folderChildrenList = querySelectorAll('.folder-children');
    folderChildrenList.forEach((folderChildren) {
      if (folderChildren.attributes['folder-uuid'] ==
          clickedFolder.attributes['folder-uuid']) {
        folderChildren.style.display =
        folderChildren.style.display == 'block' ? 'none' : 'block';
      }
    });

    event.stopImmediatePropagation();
  }

  static void selectTag(MouseEvent event, Element clickedTag) {
    var tagText = clickedTag.attributes['tag-text']!;
    var result = SearchContextPool.addTag(Tag(tagText));
    if (!result) return;

    var _htmlValidator = NodeValidatorBuilder.common()
      ..allowElement('a', attributes: ['uk-icon', 'tag-text']);
    var selectedTagHtml = '''<div class="selected-tag"><a class="remove-selected-tag-button" tag-text="$tagText" uk-icon="close"></a><div class="selected-tag-text">$tagText</div></div>''';

    var selectedTagsElements = querySelectorAll('.selected-tags');
    selectedTagsElements.forEach((selectedTagsElement) {
      selectedTagsElement.setInnerHtml(
          selectedTagsElement.innerHtml! + selectedTagHtml,
          validator: _htmlValidator);

      highlightArticles(SearchService.filterBySearchContext());
      event.stopImmediatePropagation();

      querySelectorAll('.remove-selected-tag-button').forEach((buttonElement) {
        buttonElement.onClick.listen((event) => unselectTag(event, buttonElement));
      });
    });
  }

  static void unselectTag(MouseEvent event, Element clickedButtonElement) {
    SearchContextPool.removeTag(
        Tag(clickedButtonElement.attributes['tag-text']!));

    querySelectorAll('.remove-selected-tag-button').forEach((button) {
      if (button.getAttribute('tag-text') ==
          clickedButtonElement.getAttribute('tag-text')) {
        button.parent?.remove();
      }
    });

    highlightArticles(SearchService.filterBySearchContext());
  }

  static void highlightArticles(List<Article> filteredArticles) {
    querySelectorAll('.article-title-text').forEach((articleTitleTextElement) {
      var isTarget = filteredArticles.any((article) =>
      article.uuid == articleTitleTextElement.attributes['article-uuid']);

      articleTitleTextElement.style.background = '';
      if (isTarget) {
        articleTitleTextElement.style.background =
        'linear-gradient(to top, #8392ff 10%, transparent 10%)';
      }
    });
  }
}