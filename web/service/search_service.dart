import '../../common/model/article.dart';
import '../pool/articles_pool.dart';
import '../pool/search_context_pool.dart';

class SearchService {
  static List<Article> filterBySearchContext() {
    var articles = ArticlesPool.data().getAllArticles();
    var filteredArticles = <Article>[];
    articles.forEach((article) {
      if (SearchContextPool.getTags().isEmpty) {
        if (SearchContextPool.getText().isEmpty) {
          //両方が空
        } else {
          //テキストだけ
          if (_isTargetArticleByTags(article) ||
              _isTargetArticleByText(article)) filteredArticles.add(article);
        }
      } else {
        if (SearchContextPool.getText().isEmpty) {
          //タグだけ
          if (_isTargetArticleByTags(article)) filteredArticles.add(article);
        } else {
          //両方
          if (_isTargetArticleByTags(article) &&
              _isTargetArticleByText(article)) filteredArticles.add(article);
        }
      }
    });
    return filteredArticles;
  }

  //すべてのタグを含んでるもののみ
  static bool _isTargetArticleByTags(Article article) {
    if (SearchContextPool.getTags().isEmpty) return false;
    var isTarget = true;
    SearchContextPool.getTags().forEach((searchTag) {
      if (!article.tags.contains(searchTag)) {
        isTarget = false;
      }
    });
    return isTarget;
  }

  static bool _isTargetArticleByText(Article article) {
    if (SearchContextPool.getText().isEmpty) return false;
    var reg = RegExp(SearchContextPool.getText());
    return reg.hasMatch(article.body) || reg.hasMatch(article.title);
  }
}
