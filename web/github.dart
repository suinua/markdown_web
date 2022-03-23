import 'dart:html';

import 'package:path/path.dart' as path;

String getOwnerName() {
  return window.location.host.replaceAll(RegExp('\\.(.*)'), '');
}

String getRepoName() {
  return window.location.pathname!
      .replaceFirst('/', '')
      .replaceFirst(RegExp('/(.*)'), '');
}

String getDataUrl() {
  return path.join(window.location.origin, getRepoName(), 'data.json').toString();
}