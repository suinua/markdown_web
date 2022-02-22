import '../model/article.dart';
import '../pool/articles_pool.dart';
import '../pool/search_context_pool.dart';

class SearchService {
  static List<Article> filterBySearchContext() {
    var articles = ArticlesPool.data().getAllArticles();
    var filteredArticles = <Article>[];
    articles.forEach((article) {
      if (_isTargetArticle(article)) filteredArticles.add(article);
    });
    return filteredArticles;
  }
  
  static bool _isTargetArticle(Article article) {
    var isTarget = false;
    SearchContextPool.getTags().forEach((searchTag) {
      isTarget = article.tags.contains(searchTag);
    });
    return isTarget;
  }
}