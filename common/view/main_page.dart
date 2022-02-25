import '../article_edit_log_service.dart';
import '../model/article.dart';
import '../model/folder.dart';
import 'article_menu_view.dart';
import 'article_view.dart';
import 'folder_structure_menu_view.dart';

class MainPage {
  static Future<String> generate(
      Folder folder, String outputPath, Article indexArticle) async {
    var logs = await ArticleEditLogService.getLogs(indexArticle);
    return '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
  <div class="container-box">
    <div class="article-container">
      <span class="position"></span>
      <div class="dragbar"></div>
      <div class="ghostbar"></div>
      <div class="article-context-box">
        ${ArticleView.html(indexArticle)}
        ${ArticleMenuView.html(indexArticle, logs, ArticleEditLogService.getCommitterList(logs))}
      </div>
    </div>
    <div class="folder-like-menu">
        <div class="uk-margin">
            <form class="uk-search uk-search-default" id="search-input">
                <a href="" class="uk-search-icon-flip" uk-search-icon></a>
                <input class="uk-search-input" type="search" placeholder="Search">
            </form>
        </div>
      <div class="selected-tags"></div>
      <div class="folders-container">
        ${FolderLikeMenuView.html(folder)}
      </div>
    </div>
  </div>
<script src="main.js"></script>
</body>

</html>
''';
  }
}
