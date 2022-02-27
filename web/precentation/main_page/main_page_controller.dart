import 'dart:html';

import '../../../common/model/article.dart';
import '../../../common/model/tag.dart';
import '../../pool/search_context_pool.dart';
import '../../service/search_service.dart';

class MainPageController {
  static void foldOrUnfoldFolder(MouseEvent event, Element clickedFolder) {
    var folderChildrenList = querySelectorAll('.folder-children');
    folderChildrenList.forEach((folderChildren) {
      if (folderChildren.attributes['folder-uuid'] == clickedFolder.attributes['folder-uuid']) {
        folderChildren.style.display = folderChildren.style.display == 'block' ? 'none' : 'block';
      }
    });

    event.stopImmediatePropagation();
  }

  static void displayArticle(MouseEvent event, Element clickedArticle) {
    window.history.replaceState({}, document.title, window.location.href.replaceFirst('#(.*)', ''));
    var articleContainer = querySelector('.article-context-box');
    HttpRequest.getString(window.location.href + 'articles/${clickedArticle.attributes['url']}')
        .then((value) {
      var _htmlValidator = NodeValidatorBuilder.common()
        ..allowHtml5(uriPolicy: CustomUriPolicy())
        ..allowElement('span', attributes: ['uk-icon'])
        ..allowElement('ul', attributes: ['uk-scrollspy-nav']);

      articleContainer?.setInnerHtml(value, validator: _htmlValidator);
    });

    event.stopImmediatePropagation();
  }

  static void selectTag(MouseEvent event, Element clickedTag) {
    var tagText = clickedTag.attributes['tag-text']!;
    SearchContextPool.addTag(Tag(tagText));

    var _htmlValidator = NodeValidatorBuilder.common()
      ..allowElement('a', attributes: ['uk-icon', 'tag-text']);
    var selectedTagHtml =
        '''<div class="selected-tag"><a class="remove-selected-tag-button" tag-text="$tagText" uk-icon="close"></a><div class="selected-tag-text">$tagText</div></div>''';
    var selectedTagsElement = querySelector('.selected-tags');
    selectedTagsElement?.setInnerHtml(
        selectedTagsElement.innerHtml! + selectedTagHtml,
        validator: _htmlValidator);

    MainPageController.displayFilteredArticles(
        SearchService.filterBySearchContext());
    event.stopImmediatePropagation();

    querySelectorAll('.remove-selected-tag-button').forEach((buttonElement) {
      buttonElement.onClick
          .listen((event) => unselectTag(event, buttonElement));
    });
  }

  static void unselectTag(MouseEvent event, Element clickedButtonElement) {
    SearchContextPool.removeTag(
        Tag(clickedButtonElement.attributes['tag-text']!));
    clickedButtonElement.parent?.remove();
    MainPageController.displayFilteredArticles(
        SearchService.filterBySearchContext());
  }

  static void displayFilteredArticles(List<Article> filteredArticles) {
    querySelectorAll('.article-title-text').forEach((articleTitleTextElement) {
      var isTarget = filteredArticles.any((article) => article.uuid == articleTitleTextElement.attributes['article-uuid']);

      articleTitleTextElement.style.background = '';
      if (isTarget) {
        articleTitleTextElement.style.background =
            'linear-gradient(to top, #8392ff 10%, transparent 10%)';
      }
    });
  }
}

class CustomUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) => true;
}
