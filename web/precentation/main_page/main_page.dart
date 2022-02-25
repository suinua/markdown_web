import 'dart:html';

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
            tagsElement.style.display = tagsElement.style.display == 'none' ? '' : 'none';
          }
        });
      });
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
        querySelector('.folder-like-menu')!.style.width = '$mainPercentage%';
        querySelector('.ghostbar')!.style.display = 'none';
        _dragging = false;
      }
    });
  }
}
