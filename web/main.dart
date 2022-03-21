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
  [1,2,3,4,5,6].forEach((e) => headers.addAll(querySelectorAll('h$e')));
  var navItems = querySelectorAll('.scroll-nav-item').whereType<AnchorElement>().toList();

  navItems.forEach((navItem) {
    navItem.onClick.listen((event) {
      var id = navItem.href!.replaceFirst(RegExp('(.*)#'), '');
      var target = document.getElementById(id)!;
      navItem.onClick.listen((event) async {
        await Future.delayed(Duration(milliseconds: 400));
        window.scrollTo(0, target.offsetTop+50);
      });
    });
  });
  document.onScroll.listen((event) {
    headers.forEach((header) {
      //ここが変「、一番近くで上50いないで、下の要素を超えない　」判定にしろ
      if (header.offsetTop - window.scrollY <= 50 && header.offsetTop - window.scrollY >= 0) {
        activeScrollNavItem(navItems, header.id);
      }
    });
  });

  querySelectorAll('.article-index-item').forEach((element) {
    var anchorElement = element.children[0] as AnchorElement;
    var id = anchorElement.href!.replaceFirst(RegExp('(.*)#'), '');
    var target = document.getElementById(id)!;
    element.onClick.listen((event) async {
      await Future.delayed(Duration(milliseconds: 400));
      window.scrollTo(0, target.offsetTop+10);
    });
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