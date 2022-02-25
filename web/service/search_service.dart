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
          if (_isTargetArticleByTags(article) || _isTargetArticleByText(article)) filteredArticles.add(article);
        }

      } else {
        if (SearchContextPool.getText().isEmpty) {
          //タグだけ
          if (_isTargetArticleByTags(article)) filteredArticles.add(article);
        } else {
          //両方
          if (_isTargetArticleByTags(article) && _isTargetArticleByText(article)) filteredArticles.add(article);
        }
      }
    });
    return filteredArticles;
  }

  static bool _isTargetArticleByTags(Article article) {
    if (SearchContextPool.getTags().isEmpty) return false;
    var isTarget = false;
    SearchContextPool.getTags().forEach((searchTag) {
      isTarget = article.tags.contains(searchTag);
    });
    return isTarget;
  }

  static bool _isTargetArticleByText(Article article) {
    if (SearchContextPool.getText().isEmpty) return false;
    var reg = RegExp(SearchContextPool.getText());
    return reg.hasMatch(article.body) || reg.hasMatch(article.title);
  }
}
