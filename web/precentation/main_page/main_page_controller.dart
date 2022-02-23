import 'dart:html';

import '../../model/article.dart';
import '../../pool/search_context_pool.dart';
import '../../service/search_service.dart';

class MainPageController {
  static void foldOrUnfoldFolder(MouseEvent event, Element clickedFolder) {
    var children = querySelectorAll('#${clickedFolder.id}-children');
    children.style.display =
        children.style.display == 'block' ? 'none' : 'block';

    event.stopImmediatePropagation();
  }

  static void displayArticle(MouseEvent event, Element clickedArticle) {
    var articleContainer = querySelector('.article-container');
    HttpRequest.getString(window.location.href +
            'articles/${clickedArticle.attributes['url']}')
        .then((value) {
      articleContainer?.innerHtml = value;
    });

    event.stopImmediatePropagation();
  }

  static void selectTag(MouseEvent event, Element clickedTag) {
    var tagText = clickedTag.attributes['tag-text']!;
    SearchContextPool.addTag(Tag(tagText));

    var _htmlValidator = NodeValidatorBuilder.common()
      ..allowElement('a', attributes: ['uk-icon','tag-text']);
    var selectedTagHtml =
        '''<div class="selected-tag"><a class="remove-selected-tag-button" tag-text="$tagText" uk-icon="close"></a><div class="selected-tag-text">$tagText</div></div>''';
    var selectedTagsElement = querySelector('.selected-tags');
    selectedTagsElement?.setInnerHtml(
        selectedTagsElement.innerHtml! + selectedTagHtml,
        validator: _htmlValidator);

    MainPageController.displayFilteredArticles(SearchService.filterBySearchContext());
    event.stopImmediatePropagation();

    querySelectorAll('.remove-selected-tag-button').forEach((buttonElement) {
      buttonElement.onClick.listen((event) => unselectTag(event, buttonElement));
    });
  }

  static void unselectTag(MouseEvent event, Element clickedButtonElement) {
    SearchContextPool.removeTag(Tag(clickedButtonElement.attributes['tag-text']!));
    clickedButtonElement.parent?.remove();
    MainPageController.displayFilteredArticles(SearchService.filterBySearchContext());
  }

  static void displayFilteredArticles(List<Article> filteredArticles) {
    querySelectorAll('.article').forEach((articleElement) {
      var isTarget = filteredArticles.any((article) => article.uuid == articleElement.attributes['uuid']);
      var container = querySelector('#article-and-tags-container-${articleElement.attributes['uuid']}');
      if (!isTarget) {
        container?.style.display = 'none';
      } else {
        container?.style.display = '';
      }
    });
  }
}
