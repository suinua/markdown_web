import '../model/article.dart';
import '../model/folder.dart';
import 'article_menu_view.dart';
import 'article_view.dart';

class ArticlePage {
  static Future<String> html(Folder topFolder, Article article) async {
    return '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>${article.title}</title>
    <link rel="stylesheet" href="main.css">
    <link rel="stylesheet" href="article_menu.css">
    <link rel="stylesheet" href="folder_like_menu.css">
    <link rel="stylesheet" href="article.css">

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
    ${await ArticleView.html(article)}
    ${ArticleMenuView.html(topFolder, article)}
<script src="main.js"></script>
</body>

</html>
''';
  }
}
