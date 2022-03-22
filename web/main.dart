import 'dart:html';

import 'model/article.dart';
import 'pool/articles_pool.dart';
import 'pool/search_context_pool.dart';
import 'service/search_service.dart';

String getOwnerName() {
  return window.location.host.replaceAll(RegExp('\\.(.*)'), '');
}

String getRepoName() {
  return window.location.pathname!
      .replaceFirst('/', '')
      .replaceFirst(RegExp('/(.*)'), '');
}

String getArticleUUID() {
  return querySelectorAll('meta')
      .whereType<MetaElement>()
      .where((element) => element.getAttribute('property') == 'uuid')
      .first
      .content;
}

void main() {
  var pool = ArticlesPool();
  _FolderStructureMenu.setUp();
  _ScrollNav.setUp();

  //Github
  querySelector('#github-repository-button')!.onClick.listen((event) {
    var userName = getOwnerName();
    var repositoryName = getRepoName();

    if (repositoryName.isEmpty) {
      var url = 'https://github.com/$userName/$userName.github.io';
      window.open(url, '_blank');
    } else {
      var url = 'https://github.com/$userName/$repositoryName';
      window.open(url, '_blank');
    }
  });
  querySelector('#github-edit-button')!.onClick.listen((event) {
    var uuid = getArticleUUID();
    var article = pool.getByID(uuid);
    window.open(article.githubFileUrl, '_blank');
  });

  //Share
  var twitterButton = querySelector('.twitter-button')!;
  twitterButton.onClick.listen((event) {
    window.open(twitterButton.getAttribute('url')!, '_blank');
  });

  var copyLinkButton = querySelector('.copy-link-button')!;
  copyLinkButton.onClick.listen((event) async {
    await window.navigator.clipboard
        ?.writeText(copyLinkButton.getAttribute('text')!);

    querySelector('.copied-message')!.style.display = 'inline-block';

    await Future.delayed(Duration(seconds: 1));
    querySelector('.copied-message')!.style.display = 'none';
  });

  //Smartphone Menu
  querySelector('.smartphone-folder-structure-menu-button')!
      .onClick
      .listen((event) {
    var element = querySelector('.smartphone-folder-structure-menu-wrap')!;
    element.style.display = element.style.display == 'block' ? 'none' : 'block';
  });

  querySelector('.smartphone-index-menu-button')!.onClick.listen((event) {
    var element = querySelector('.smartphone-index')!;
    element.style.display = element.style.display == 'block' ? 'none' : 'block';
  });
}

class _ScrollNav {
  static void setUp() {
    //Index
    var headers = <Element>[];
    [1, 2].forEach((e) => headers.addAll(querySelectorAll('h$e')));
    var navItems = querySelectorAll('.scroll-nav-item')
        .whereType<AnchorElement>()
        .toList();
    const collision = 50;
    const navBarHeight = 64;

    //上のバーで隠れないように
    navItems.forEach((navItem) {
      navItem.onClick.listen((event) async {
        if (window.outerWidth <= 1000) {
          var id = navItem.href!.replaceFirst(RegExp('(.*)#'), '');
          var target = document.getElementById(id)!;
          await Future.delayed(Duration(milliseconds: 400));
          window.scrollTo(0, target.offsetTop - navBarHeight);
        }
        ;
      });
    });

    document.onScroll.listen((event) {
      var update = false;
      headers.forEach((header) {
        //差が50以下になったとき
        var diff = header.offsetTop - window.scrollY;
        if (window.outerWidth <= 1000) {
          if (0 <= diff && diff <= collision + navBarHeight) {
            _activeScrollNavItem(navItems, header.id);
            update = true;
          }
        } else {
          if (0 <= diff && diff <= collision) {
            _activeScrollNavItem(navItems, header.id);
            update = true;
          }
        }
      });

      //勢いの強いスクロールに対応
      if (!update) {
        var nearbyHeader = _getNearbyHeader(headers);
        _activeScrollNavItem(navItems, nearbyHeader.id);
      }
    });
  }

  static void _activeScrollNavItem(List<Element> navItems, String id) {
    navItems.forEach((navItem) {
      if (navItem is AnchorElement) {
        var navItemId = navItem.href!.replaceFirst(RegExp('(.*)#'), '');
        if (navItemId == id) {
          navItem.classes.add('active-scroll-nav-item');
        } else {
          navItem.classes
              .removeWhere((element) => element == 'active-scroll-nav-item');
        }
      }
    });
  }

  static Element _getNearbyHeader(List<Element> elements) {
    Element? result;
    for (var i = 0; i < elements.length; i++) {
      var element = elements[i];
      if (result == null) {
        result = element;
        continue;
      }
      var diff = element.offsetTop - window.scrollY;
      var resultDiff = result.offsetTop - window.scrollY;
      if (diff > 0) continue; //スクロール地点より下にあったら除外
      if (diff.abs() < resultDiff.abs()) result = element;
    }

    return result!;
  }
}

class _FolderStructureMenu {
  static void setUp() {
    //タグクリックで選択
    querySelectorAll('.tag').forEach((tagElement) {
      tagElement.onClick.listen((event) => selectTag(event, tagElement));
    });

    //検索
    var searchInputs = querySelectorAll('.search-input').cast<InputElement>();
    searchInputs.forEach((searchInput) {
      searchInput.onInput.listen((event) {
        SearchContextPool.setText(searchInput.value!);
        highlightArticles(SearchService.filterBySearchContext());
        searchInputs.forEach((e) => e.value = searchInput.value);
      });
    });
  }

  static void selectTag(MouseEvent event, Element clickedTag) {
    var tagText = clickedTag.text!.replaceFirst('#', '');
    var result = SearchContextPool.addTag(tagText);
    if (!result) return;

    var _htmlValidator = NodeValidatorBuilder.common()
      ..allowElement('span', attributes: ['uk-icon', 'tag-text']);
    var selectedTagHtml =
    '''<div class="selected-tag"><span class="remove-selected-tag" tag-text="$tagText" uk-icon="icon: close; ratio: 1"></span>$tagText</div>''';

    var selectedTagsElements = querySelectorAll('.selected-tags');
    selectedTagsElements.forEach((selectedTagsElement) {
      selectedTagsElement.setInnerHtml(
          selectedTagsElement.innerHtml! + selectedTagHtml,
          validator: _htmlValidator);

      highlightArticles(SearchService.filterBySearchContext());
      event.stopImmediatePropagation();

      querySelectorAll('.remove-selected-tag').forEach((buttonElement) {
        buttonElement.onClick
            .listen((event) => unselectTag(event, buttonElement));
      });
    });
  }

  static void unselectTag(MouseEvent event, Element clickedButtonElement) {
    SearchContextPool.removeTag(clickedButtonElement.getAttribute('tag-text')!);

    querySelectorAll('.remove-selected-tag').forEach((button) {
      if (button.getAttribute('tag-text') ==
          clickedButtonElement.getAttribute('tag-text')) {
        button.parent?.remove();
      }
    });

    highlightArticles(SearchService.filterBySearchContext());
  }

  static void highlightArticles(List<Article> filteredArticles) {
    querySelectorAll('.menu-article-title').forEach((articleTitleTextElement) {
      var isTarget = filteredArticles.any((article) =>
      article.uuid == articleTitleTextElement.attributes['uuid']);

      articleTitleTextElement.classes.remove('active-menu-article-title');
      if (isTarget) {
        articleTitleTextElement.classes.add('active-menu-article-title');
      }
    });
  }
}
