import 'dart:io';

import '../model/article.dart';
import '../model/folder.dart';
import 'article_menu_view.dart';
import 'article_view.dart';

class ArticlePage {
  static Future<String> html(Folder topFolder, Article article) async {
    var repository = Platform.environment['GITHUB_REPOSITORY'] ?? 'suinua/markdown_web';
    var userName = repository.split('/')[0];
    var repositoryName = repository.split('/')[1];
    var path = 'https://$userName.github.io/$repositoryName/';

    return '''
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>${article.title}</title>
    <link rel="stylesheet" href="${path}main.css">
    <link rel="stylesheet" href="${path}article_menu.css">
    <link rel="stylesheet" href="${path}folder_like_menu.css">
    <link rel="stylesheet" href="${path}article.css">
    <link rel="stylesheet" href="smartphone.css" media="screen and (max-width: 1000px)">

    <!-- UIkit CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/css/uikit.min.css" />

    <!-- UIkit JS -->
    <script src="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/js/uikit.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/js/uikit-icons.min.js"></script>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/default.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>
</head>

<body>
<div class="smartphone-menu ">
   <a class="uk-link-reset" href="#offcanvas-slide" uk-toggle>
       <span uk-icon="icon: menu; ratio: 3"></span>
   </a>
</div>

    ${await ArticleView.html(article)}
    ${ArticleMenuView.html(topFolder, article)}
<script src="${path}main.js"></script>
</body>

</html>
''';
  }
}
