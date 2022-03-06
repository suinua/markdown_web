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
    window.navigator.clipboard?.writeText(copyLinkButton.getAttribute('text')!);

    querySelector('.copied-message')!.style.display = 'inline-block';

    await Future.delayed(Duration(seconds: 1));
    querySelector('.copied-message')!.style.display = 'none';
  });
}
