import 'dart:html';

import 'pool/articles_pool.dart';

void main() {
  ArticlesPool();
  querySelectorAll('.folder').forEach((folder) {
    folder.children[0].onClick.listen((event) {
      var children = querySelectorAll('#${folder.id}-children');
      children.style.display =
          children.style.display == 'block' ? 'none' : 'block';
      event.stopImmediatePropagation();
    });
  });

  querySelectorAll('.article').forEach((article) {
    var articleContainer = querySelector('#article-container');
    article.onClick.listen((event) {
      HttpRequest.getString(window.location.href + 'articles/${article.id}').then((value){
        articleContainer?.innerHtml = value;
      });
    });
  });
}
