import 'dart:html';

import '../../pool/search_context_pool.dart';
import '../../service/search_service.dart';
import 'main_page_controller.dart';

class MainPage {
  static bool _dragging = false;
  static bool _isFolderStructureMenuOpen = true;
  static String _lastFolderStructureMenuWidth = '';
  static String _lastArticleContainerWidth = '';

  static setup() {
    //todo:article-menuだけイベント再設定しろ
    querySelectorAll('.folder').forEach((folder) {
      folder.onClick.listen(
          (event) => MainPageController.foldOrUnfoldFolder(event, folder));
    });

    querySelectorAll('.article-on-menu').forEach((article) {
      article.onClick.listen((event) {
        MainPageController.displayArticle(event, article);
      });
    });

    querySelectorAll('.folder-structure-menu-tag').forEach((tag) {
      tag.onClick.listen((event) => MainPageController.selectTag(event, tag));
    });

    _setupDraggableDivider();

    querySelectorAll('.tag-button').forEach((tagButton) {
      tagButton.onClick.listen((event) {
        var uuid = tagButton.attributes['article-uuid'];
        querySelectorAll('tags').forEach((tagsElement) {
          if (tagsElement.attributes['article-uuid'] == uuid) {
            tagsElement.style.display =
                tagsElement.style.display == 'none' ? '' : 'none';
          }
        });
      });
    });

    var searchInput = querySelector('.search-input')! as InputElement;
    searchInput.onInput.listen((event) {
      SearchContextPool.setText(searchInput.value!);
      MainPageController.displayFilteredArticles(
          SearchService.filterBySearchContext());
    });

    var closeButtonContainer =
        querySelector('.article-menu-close-button-container')!;
    var closeButton = querySelector('.article-menu-close-button')!;
    closeButton.onClick.listen((event) {
      var articleMenu = querySelector('.article-menu')!;
      var isOpen = ['19%', ''].contains(articleMenu.style.width);

      articleMenu.style.width = isOpen ? 'auto' : '19%';
      articleMenu.children.forEach((child) {
        if (child.className != closeButtonContainer.className) {
          child.style.display = isOpen ? 'none' : 'block';
        }
      });

      //記事のサイズ変更
      querySelector('.article-context')!.style.width = isOpen ? '80%' : '60%';
    });

    querySelector('.folder-structure-menu-close-button')!
        .onClick
        .listen((event) {
      var articleContainer = querySelector('.article-container')!;
      var folderStructureMenu = querySelector('.folder-structure-menu')!;
      var foldersContainer = querySelector('.folders-container')!;
      if (_isFolderStructureMenuOpen) {
        _lastArticleContainerWidth = articleContainer.style.width;
        _lastFolderStructureMenuWidth = folderStructureMenu.style.width;
      }

      articleContainer.style.width =
          _isFolderStructureMenuOpen ? '97.5%' : _lastArticleContainerWidth;
      foldersContainer.style.display = _isFolderStructureMenuOpen ? 'none' : '';
      folderStructureMenu.style.width = _isFolderStructureMenuOpen
          ? '${document.body!.clientWidth - articleContainer.clientWidth}px'
          : _lastFolderStructureMenuWidth;
      querySelector('.search-input')!.style.display =
          _isFolderStructureMenuOpen ? 'none' : '';

      _isFolderStructureMenuOpen = !_isFolderStructureMenuOpen;
    });
  }

  static void _setupDraggableDivider() {
    querySelector('.dragbar')!.onMouseDown.listen((event) {
      if (!_isFolderStructureMenuOpen) return;
      event.preventDefault();
      _dragging = true;
      var ghostbar = querySelector('.ghostbar')!
        ..style.height =
            '${querySelector('.article-container')!.offsetHeight}px'
        ..style.display = '';

      document.onMouseMove.listen((event) {
        ghostbar.style.left = '${event.page.x + 2}px';
      });
    });

    document.onMouseUp.listen((event) {
      if (_dragging) {
        var percentage = (event.page.x / window.innerWidth!) * 100;
        var mainPercentage = 100 - percentage;

        querySelector('.article-container')!.style.width = '$percentage%';
        querySelector('.folder-structure-menu')!.style.width =
            '$mainPercentage%';
        querySelector('.ghostbar')!.style.display = 'none';
        _dragging = false;
      }
    });
  }
}
