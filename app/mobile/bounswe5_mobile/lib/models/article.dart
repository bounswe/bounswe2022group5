import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/label.dart';

/// Article is the main element of the Articles section.
class Article {
  final int id;
  final DateTime time;
  List<Label>? labels;
  Category? category;
  final String header;
  final String body;
  int upvotes;
  int downvotes;
  final ArticleAuthor author;
  String? voteOfActiveUser;

  Article(
      this.id,
      this.time,
      this.header,
      this.body,
      this.author,
      {this.upvotes = 0,
        this.downvotes = 0}
      );
}


class ArticleAuthor {
  final int id;
  final String fullName;
  final String profileImageUrl;

  ArticleAuthor(
      this.id,
      this.fullName,
      this.profileImageUrl,
      );
}
