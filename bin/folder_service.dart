import '../common/model/folder.dart';
import 'article_service.dart';

class FolderService {
  static void saveAsHtml(
      String path, Folder folder, Folder topParentFolder) {
      folder.articles.forEach((article) {
        ArticleService.saveFile(path, topParentFolder, article);
      });

      folder.folders.forEach((folder) {
        saveAsHtml(path, folder, topParentFolder);
      });
  }
}
