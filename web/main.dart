import 'dart:html';

import '../common/view/folder_structure_menu_view.dart';

void main() {
  FolderStructureMenuViewController.setUp();

  querySelector('.github-button')!.onClick.listen((event) {
    var userName = window.location.host.replaceAll(RegExp('\\.(.*)'), '');
    var repositoryName = window.location.pathname?.replaceFirst('/', '').replaceFirst(RegExp('/(.*)'), '');
    var url = 'https://github.com/$userName/$repositoryName';
    window.open(url, '_blank');
  });

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

  querySelectorAll('.article-index-item').forEach((element) {
    var anchorElement = element.children[0] as AnchorElement;
    var id = anchorElement.href!.replaceFirst(RegExp('(.*)#'), '');
    var target = querySelector('#$id')!;
    element.onClick.listen((event) async {
      await Future.delayed(Duration(milliseconds: 400));
      window.scrollTo(0, target.offsetTop+10);
    });
  });
}
