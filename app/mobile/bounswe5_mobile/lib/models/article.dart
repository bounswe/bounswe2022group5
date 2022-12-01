import 'package:bounswe5_mobile/models/user.dart';

/// Article is the main element of the Articles section.
class Article {
  final int id;
  final User author;
  final DateTime time;
  final String header;
  final String body;
  int upvotes;
  int downvotes;

  Article(
      this.id,
      this.author,
      this.time,
      this.header,
      this.body,
      {this.upvotes = 0,
        this.downvotes = 0}
      );
}
