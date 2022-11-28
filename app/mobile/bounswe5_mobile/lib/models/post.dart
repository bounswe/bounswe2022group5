import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/member.dart';

/// Post is the main element of the forum.
class Post {
  /// To get the author, we should first call API to get the post,
  /// and then call API again using id of the author to get the
  /// author.
  final int id;
  final Member author;
  final DateTime time;
  final String header;
  final String body;
  int upvotes;
  int downvotes;
  bool isDoctorReplied;

  Post(
      this.id,
      this.author,
      this.time,
      this.header,
      this.body,
      {this.upvotes = 0,
        this.downvotes = 0,
        this.isDoctorReplied = false,}
      );
}