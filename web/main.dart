import 'dart:html';

void main() {
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
    HttpRequest.getString('').then((value){
      articleContainer?.innerHtml = value;
    });
  });
}
