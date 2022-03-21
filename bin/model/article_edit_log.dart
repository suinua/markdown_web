import 'committer.dart';

class ArticleEditLog {
  final Committer committer;
  final String comment;
  final DateTime date;

  ArticleEditLog(this.committer, this.comment, this.date);
}