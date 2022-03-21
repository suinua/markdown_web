import '../model/article_index.dart';

class IndexMenu {
  static String pcHtml(List<ArticleIndex> indexList) {
    var children = '';
    indexList.forEach((index) {
      children += '''
<li class="scroll-nav-item-wrap uk-flex">
    <a href="#${index.href}" class="scroll-nav-item uk-flex uk-link-reset">
        <div class="mark-filled">${index.text}</div>
    </a>
</li>
''';
    });

    return '''
<div class="side-menu">
     <div class="sticky-element">
        <div class="side-menu-title">Index</div>
        <ul class="side-menu-index uk-grid-small" uk-grid>
          $children
        </ul>
    </div>
</div>
''';
  }

  static String smartphoneHtml(List<ArticleIndex> indexList) {
    var children = '';
    indexList.forEach((index) {
      children += '''
<li class="scroll-nav-item-wrap uk-flex">
    <a href="#${index.href}" class="scroll-nav-item uk-flex uk-link-reset">
        <div class="mark-filled">${index.text}</div>
    </a>
</li>
''';
    });

    return '''
<div class="smartphone-index">
    <ul class="side-menu-index uk-grid-small" uk-grid>
        $children
    </ul>
</div>
''';
  }
}
