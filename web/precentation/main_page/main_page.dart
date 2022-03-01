import 'dart:html';

import '../../pool/search_context_pool.dart';
import '../../service/search_service.dart';
import 'main_page_controller.dart';

class MainPage {
  static setup() {
    querySelectorAll('.folder').forEach((folder) {
      folder.onClick.listen((event) => MainPageController.foldOrUnfoldFolder(event, folder));
    });

    querySelectorAll('.folder-structure-menu-tag').forEach((tag) {
      tag.onClick.listen((event) => MainPageController.selectTag(event, tag));
    });

    _setupArticleMenuEvent();

    querySelectorAll('.tag-button').forEach((tagButton) {
      tagButton.onClick.listen((event) {
        var uuid = tagButton.attributes['article-uuid'];
        querySelectorAll('tags').forEach((tagsElement) {
          if (tagsElement.attributes['article-uuid'] == uuid) {
            tagsElement.style.display =
                tagsElement.style.display == 'none' ? '' : 'none';
          }
        });
      });
    });

    var searchInput = querySelector('.search-input')! as InputElement;
    searchInput.onInput.listen((event) {
      SearchContextPool.setText(searchInput.value!);
      MainPageController.displayFilteredArticles(
          SearchService.filterBySearchContext());
    });
  }

  static void _setupArticleMenuEvent() {
    var closeButtonContainer =
        querySelector('.article-menu-close-button-container')!;
    var closeButton = querySelector('.article-menu-close-button')!;
    closeButton.onClick.listen((event) {
      print('click');
      var articleMenu = querySelector('.article-menu')!;
      var isOpen = ['19%', ''].contains(articleMenu.style.width);

      articleMenu.style.width = isOpen ? 'auto' : '19%';
      articleMenu.children.forEach((child) {
        if (child.className != closeButtonContainer.className) {
          child.style.display = isOpen ? 'none' : 'block';
        }
      });

      //記事のサイズ変更
      querySelector('.article-context-wrap')!.style.width = isOpen ? '85%' : '70%';
    });
  }
}
