import 'dart:html';

import 'main_page_controller.dart';

class MainPage {
  static setup() {
    print(querySelectorAll('.tag').length);

    querySelectorAll('.folder').forEach((folder) {
      folder.children[0].onClick.listen((event) => MainPageController.foldOrUnfoldFolder(event, folder));
    });

    querySelectorAll('.article').forEach((article) {
      article.onClick.listen((event) => MainPageController.displayArticle(event, article));
    });

    querySelectorAll('.tag').forEach((tag) {
      tag.onClick.listen((event) => MainPageController.selectTag(event, tag));
    });
  }
}