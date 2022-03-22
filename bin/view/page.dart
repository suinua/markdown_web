import 'package:path/path.dart' as path;

import '../model/article_file.dart';
import '../model/article_folder.dart';
import '../model/article_tag.dart';
import '../service/github_action_service.dart';
import '../service/github_service.dart';
import 'folder_structure_menu.dart';
import 'index_menu.dart';

class Page {
  //todo:description
  static Future<String> html(ArticleFolder topFolder, ArticleFile articleFile) async {
    return '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:url" content="${GithubActionService.getGhPageUrl(articleFile)}">
    <meta property="og:title" content="${articleFile.articleTitle}">
    <meta property="og:image" content="${path.join(GithubActionService.getThumbnailsUrl(), articleFile.articleTitle)}.png">
    <meta property="og:description" content="">
    <title>${articleFile.articleTitle}</title>

    <!-- UIkit CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/css/uikit.min.css" />

    <!-- UIkit JS -->
    <script src="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/js/uikit.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/js/uikit-icons.min.js"></script>

    <!-- Material Icons -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
        
    <!-- Highlight.js -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/default.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>

    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}style.css" />
    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}card.css" />
    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}folder-structre-menu.css" />
    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}article.css" />
    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}side-menu.css" />
    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}note.css" />
    <link rel="stylesheet" href="${GithubActionService.getGhPageIndexUrl()}smartphone.css" media="screen and (max-width: 1000px)">
    <script src="${GithubActionService.getGhPageIndexUrl()}main.js" defer></script>
</head>

<body>
    <nav class="nav-bar uk-navbar uk-navbar-container uk-margin">
        <div class="site-name">
            markdown-web
        </div>
        <button id="github-repository-button" class="uk-button uk-button-secondary github-button"><span
                uk-icon="github"></span> Github</button>
    </nav>
    <div class="smartphone-nav">
        <div class="smartphone-folder-structure-menu-button">
            記事<span uk-icon="icon: chevron-down; ratio: 2"></span>
        </div>
        <div class="smartphone-index-menu-button">
            <span uk-icon="icon: menu; ratio: 2.5"></span>
        </div>
        ${IndexMenu.smartphoneHtml(articleFile.indexList)}

        <div class="smartphone-folder-structure-menu-wrap">
            <div class="sticky-element">
                <div class="search-form">
                    <form class="uk-search uk-search-default">
                        <input class="search-input uk-search-input" type="search" placeholder="Search">
                        <span uk-icon="icon: close; ratio: 1"></span>
                    </form>
                    <div class="selected-tags">
                    </div>
                </div>
                ${FolderStructureMenu.html(topFolder)}
              </div>
        </div>
    </div>
    
    <article class="view-container">
        <div class="left">
            <div class="folder-structure-menu-wrap">
                <div class="sticky-element">
                    <div class="search-form">
                        <form class="uk-search uk-search-default">
                            <input class="uk-search-input" type="search" placeholder="Search">
                            <span uk-icon="icon: close; ratio: 1"></span>
                        </form>
                        <div class="selected-tags">
                        </div>
                    </div>
                    ${FolderStructureMenu.html(topFolder)}
                </div>
            </div>

            <div class="article-wrap">
                <div class="article-title">
                    ${articleFile.articleTitle}
                </div>
                <div class="article-context">
                    ${_articleTagsHtml(articleFile.tags)}
                    ${articleFile.htmlBody}
                </div>

                ${_shareHtml(articleFile)}

                ${await _committerListHtml(articleFile)}

                <div class="recommends-wrap">
                    <p>recommends</p>
                    <div class="recommends">
                        <div class="recommend">
                            <img src="thumbnail.png" alt="thumbnail">
                        </div>
                        <div class="recommend">
                            <img src="thumbnail.png" alt="thumbnail">
                        </div>
                    </div>
                    <div class="recommends">
                        <div class="recommend">
                            <img src="thumbnail.png" alt="thumbnail">
                        </div>
                        <div class="recommend">
                            <img src="thumbnail.png" alt="thumbnail">
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <aside class="right">
          ${IndexMenu.pcHtml(articleFile.indexList)}
        </aside>
    </article>
</body>

</html>
    ''';
  }

  static String _articleTagsHtml(List<ArticleTag> tags) {
    var children = '';
    tags.forEach((tag) {
      children += '<div class="article-tag">#${tag.text}</div>\n';
    });
    return '''
<div class="article-tags">
    $children
</div>
''';
  }

  static String _shareHtml(ArticleFile articleFile) {
    return '''
<div class="share">
    <span url="https://twitter.com/intent/tweet?ref_src=twsrc%5Etfw&url=${articleFile.articleTitle} ${GithubActionService.getGhPageUrl(articleFile)}"
        class="uk-icon-button uk-margin-small-right twitter-button" uk-icon="twitter"></span>
    <span text="copy text" class="uk-icon-button uk-margin-small-right copy-link-button"
        uk-icon="link"></span>
    <div class="copied-message">Copied!</div>

    <button id="github-edit-button" class="uk-button uk-button-secondary github-button"><span uk-icon="github"></span> view on github</button>
</div>
''';
  }

  static Future<String> _committerListHtml(ArticleFile articleFile) async {
    var committers = GithubService.getCommitterList(
        await GithubService.getLogs(articleFile));
    var html = committers.map((e) => '''
<div class="committer">
<img class="uk-border-circle" src="${e.avatarUrl}" alt="">
<p>${e.name}</p>
</div>''').join('\n');

    return '''
<div class="committers-wrap">
    <p>Contributors</p>
    <div class="committers">
      $html
    </div>
</div>
    ''';
  }
}
