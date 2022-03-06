import 'dart:html';

import '../common/view/folder_structure_menu_view.dart';

void main() {
  FolderStructureMenuViewController.setUp();

  querySelector('.github-button')!.onClick.listen((event) {
    var userName = window.location.host.replaceAll(RegExp('(.*)\.'), '');
    var repositoryName = window.location.pathname?.replaceFirst('/', '').replaceFirst(RegExp('/(.*)'), '');
    var url = 'https://github.com/$userName/$repositoryName';
    window.open(url, '_blank');
  });
}
