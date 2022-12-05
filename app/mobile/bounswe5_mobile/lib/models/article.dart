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
  List<String> imageUrls = []; //????

  Article(
      this.id,
      this.time,
      this.header,
      this.body,
      this.author,
      {this.upvotes = 0,
        this.downvotes = 0}
      );

  setVoteOfActiveUser(String vote){
    voteOfActiveUser = vote;
  }

}


class ArticleAuthor {
  final int id;
  final String fullName;
  String? profileImageUrl;

  ArticleAuthor(
      this.id,
      this.fullName,
      );

  setProfileImageUrl(String url) {
    profileImageUrl = url;
  }
}
