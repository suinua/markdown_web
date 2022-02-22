import 'dart:html';

import '../../model/article.dart';
import '../../pool/search_context_pool.dart';

class MainPageController {
  static void foldOrUnfoldFolder(MouseEvent event, Element clickedFolder) {
    var children = querySelectorAll('#${clickedFolder.id}-children');
    children.style.display =
        children.style.display == 'block' ? 'none' : 'block';

    event.stopImmediatePropagation();
  }

  static void displayArticle(MouseEvent event, Element clickedArticle) {
    var articleContainer = querySelector('#article-container');
    HttpRequest.getString(
            window.location.href + 'articles/${clickedArticle.id}')
        .then((value) {
      articleContainer?.innerHtml = value;
    });
  }

  static void selectTag(MouseEvent event, Element clickedTag) {
    SearchContextPool.addTag(Tag(clickedTag.id));

    var  _htmlValidator= NodeValidatorBuilder.common()
      ..allowElement('a', attributes: ['uk-icon']);
    var selectedTagHtml =
        '''<div class="selected-tag"><a uk-icon="close"></a><div class="selected-tag-text">${clickedTag.id}</div></div>''';
    var selectedTagsElement = querySelector('.selected-tags');
    selectedTagsElement?.setInnerHtml(selectedTagsElement.innerHtml! + selectedTagHtml, validator: _htmlValidator);
  }
}
