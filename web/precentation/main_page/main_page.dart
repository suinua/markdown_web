import 'dart:html';

import 'main_page_controller.dart';

class MainPage {
  static bool _dragging = false;

  static setup() {
    querySelectorAll('.folder').forEach((folder) {
      folder.children[0].onClick.listen(
          (event) => MainPageController.foldOrUnfoldFolder(event, folder));
    });

    querySelectorAll('.article').forEach((article) {
      article.onClick
          .listen((event) => MainPageController.displayArticle(event, article));
    });

    querySelectorAll('.tag').forEach((tag) {
      tag.onClick.listen((event) => MainPageController.selectTag(event, tag));
    });

    _setupDraggableDivider();
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
        querySelector('.side-menu')!.style.width = '$mainPercentage%';
        querySelector('.ghostbar')!.style.display = 'none';
        _dragging = false;
      }
    });
  }
}
