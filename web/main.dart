import 'dart:html';


void main() {
  //Github
  querySelector('#github-repository-button')!.onClick.listen((event) {
    var userName = window.location.host.replaceAll(RegExp('\\.(.*)'), '');
    var repositoryName = window.location.pathname!.replaceFirst('/', '').replaceFirst(RegExp('/(.*)'), '');

    if (repositoryName.isEmpty) {
      var url = 'https://github.com/$userName/$userName.github.io';
      window.open(url, '_blank');
    } else {
      var url = 'https://github.com/$userName/$repositoryName';
      window.open(url, '_blank');
    }
  });
  //todo : github-edit-button

  //Share
  var twitterButton = querySelector('.twitter-button')!;
  twitterButton.onClick.listen((event) {
    window.open(twitterButton.getAttribute('url')!, '_blank');
  });

  var copyLinkButton = querySelector('.copy-link-button')!;
  copyLinkButton.onClick.listen((event) async {
    await window.navigator.clipboard?.writeText(copyLinkButton.getAttribute('text')!);

    querySelector('.copied-message')!.style.display = 'inline-block';

    await Future.delayed(Duration(seconds: 1));
    querySelector('.copied-message')!.style.display = 'none';
  });

  //Index
  var headers = <Element>[];
  [1,2].forEach((e) => headers.addAll(querySelectorAll('h$e')));
  var navItems = querySelectorAll('.scroll-nav-item').whereType<AnchorElement>().toList();
  const collision = 50;
  const navBarHeight = 64;

  //上のバーで隠れないように
  navItems.forEach((navItem) {
    navItem.onClick.listen((event) async {
      if(window.outerWidth <= 1000){
        var id = navItem.href!.replaceFirst(RegExp('(.*)#'), '');
        var target = document.getElementById(id)!;
        await Future.delayed(Duration(milliseconds: 400));
        window.scrollTo(0, target.offsetTop - navBarHeight);
      };
    });
  });

  document.onScroll.listen((event) {
    var update = false;
    headers.forEach((header) {
      //差が50以下になったとき
      var diff = header.offsetTop - window.scrollY;
      if(window.outerWidth <= 1000){
        if (0 <= diff && diff <= collision+navBarHeight) {
          activeScrollNavItem(navItems, header.id);
          update = true;
        }
      } else {
        if (0 <= diff && diff <= collision) {
          activeScrollNavItem(navItems, header.id);
          update = true;
        }
      }
    });

    //勢いの強いスクロールに対応
    if (!update) {
      var nearbyHeader = getNearbyHeader(headers);
      activeScrollNavItem(navItems, nearbyHeader.id);
    }
  });

  //Smartphone Menu
  querySelector('.smartphone-folder-structure-menu-button')!.onClick.listen((event) {
    var element = querySelector('.smartphone-folder-structure-menu-wrap')!;
    element.style.display = element.style.display == 'block' ? 'none' : 'block';
  });

  querySelector('.smartphone-index-menu-button')!.onClick.listen((event) {
    var element = querySelector('.smartphone-index')!;
    element.style.display = element.style.display == 'block' ? 'none' : 'block';
  });
}

void activeScrollNavItem(List<Element> navItems, String id) {
  navItems.forEach((navItem) {
    if (navItem is AnchorElement) {
      var navItemId = navItem.href!.replaceFirst(RegExp('(.*)#'), '');
      if (navItemId == id) {
        navItem.classes.add('active-scroll-nav-item');
      } else {
        navItem.classes.removeWhere((element) => element == 'active-scroll-nav-item');
      }
    }
  });
}

Element getNearbyHeader(List<Element> elements) {
  Element? result;
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    if (result == null) {
      result = element;
      continue;
    }
    var diff = element.offsetTop - window.scrollY;
    var resultDiff = result.offsetTop - window.scrollY;
    if (diff > 0) continue;//スクロール地点より下にあったら除外
    if (diff.abs() < resultDiff.abs()) result = element;
  }

  return result!;
}