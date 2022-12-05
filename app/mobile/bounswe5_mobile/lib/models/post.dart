import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/label.dart';

/// Post is the main element of the forum.
class Post {
  /// To get the author, we should first call API to get the post,
  /// and then call API again using id of the author to get the
  /// author.
  final int id;
  final DateTime time;
  final PostAuthor author;
  final String header;
  final String body;
  int upvotes;
  int downvotes;
  bool isDoctorReplied;
  double? longitude;
  double? latitude;
  List<String>? imageUrls; //????

  Category? category;
  List<Label>? labels;

  String? voteOfActiveUser;

  Post(
      this.id,
      this.author,
      this.time,
      this.header,
      this.body,
      {this.upvotes = 0,
        this.downvotes = 0,
        this.isDoctorReplied = false,
      }
      );
}

class PostAuthor {
  final int id;
  final String username;
  final String profileImageUrl;
  final bool isDoctor;

  PostAuthor(
      this.id,
      this.username,
      this.profileImageUrl,
      this.isDoctor
      );
}