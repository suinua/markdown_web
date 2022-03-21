import '../model/article_folder.dart';

class FolderStructureMenu {
  static String html(ArticleFolder topFolder) {
    var children = '';

    topFolder.files.forEach((file) {
      var tagsHtml =
      file.tags.map((e) => '<div class="tag">#${e.text}</div>').join('\n');
      children += '''
<li>
    <div class="menu-article">${file.fileName}
        <div class="tags">
           $tagsHtml
        </div>
    </div>
 </li>
''';
    });

    topFolder.folders.forEach((folder) {
      children += _html(folder);
    });

    return '''
<div class="folder-structure-menu">
  <ul class="children">
     $children
  </ul>
</div>
    ''';
  }

  static String _html(ArticleFolder baseFolder) {
    var children = '';

    baseFolder.files.forEach((file) {
      var tagsHtml =
          file.tags.map((e) => '<div class="tag">#${e.text}</div>').join('\n');
      children += '''
<li>
    <div class="menu-article">${file.fileName}
        <div class="tags">
           $tagsHtml
        </div>
    </div>
 </li>
''';
    });

    baseFolder.folders.forEach((folder) {
      children += _html(folder);
    });

    return '''
<li>
    <div class="menu-folder"><i class="zmdi zmdi-folder zmdi-hc-lg"></i>${baseFolder.name}</div>
    <ul class="children">
      $children
    </ul>
</li>
''';
  }
}