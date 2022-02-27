import 'dart:html';

import '../../pool/search_context_pool.dart';
import '../../service/search_service.dart';
import 'main_page_controller.dart';

class MainPage {
  static bool _dragging = false;

  static setup() {
    querySelectorAll('.folder').forEach((folder) {
      folder.onClick.listen(
          (event) => MainPageController.foldOrUnfoldFolder(event, folder));
    });

    querySelectorAll('.article-on-menu').forEach((article) {
      article.onClick
          .listen((event) => MainPageController.displayArticle(event, article));
    });

    querySelectorAll('.folder-structure-menu-tag').forEach((tag) {
      tag.onClick.listen((event) => MainPageController.selectTag(event, tag));
    });

    _setupDraggableDivider();

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

    var closeButtonContainer =
        querySelector('.article-menu-close-button-container')!;
    var closeButton = querySelector('.article-menu-close-button')!;
    closeButton.onClick.listen((event) {
      var articleMenu = querySelector('.article-menu')!;
      var isOpen = ['19%', ''].contains(articleMenu.style.width);

      articleMenu.style.width = isOpen ? 'auto' : '19%';
      articleMenu.children.forEach((child) {
        if (child.className != closeButtonContainer.className) {
          child.style.display = isOpen ? 'none' : 'block';
        }
      });

      //記事のサイズ変更
      querySelector('.article-context')!.style.width = isOpen ? '75%' : '60%';
    });

    querySelector('.folder-structure-menu-close-button')!.onClick.listen((event) {
      querySelector('.article-container')!.style.width = '97.5%';
      querySelector('.folders-container')!.style.display = 'none';
      querySelector('.folder-structure-menu')!.style.width = 'auto';
      querySelector('.ghostbar')!.style.display = 'none';
      querySelector('.search-input')!.style.display = 'none';
    });
  }

  static void _setupDraggableDivider() {
    querySelector('.dragbar')!.onMouseDown.listen((event) {
      event.preventDefault();
      _dragging = true;
      var ghostbar = querySelector('.ghostbar')!
        ..style.height =
            '${querySelector('.article-container')!.offsetHeight}px'
        ..style.display = '';

      document.onMouseMove.listen((event) {
        ghostbar.style.left = '${event.page.x + 2}px';
      });
    });

    document.onMouseUp.listen((event) {
      if (_dragging) {
        var percentage = (event.page.x / window.innerWidth!) * 100;
        var mainPercentage = 100 - percentage;

        querySelector('.article-container')!.style.width = '$percentage%';
        querySelector('.folder-structure-menu')!.style.width = '$mainPercentage%';
        querySelector('.ghostbar')!.style.display = 'none';
        _dragging = false;
      }
    });
  }
}
