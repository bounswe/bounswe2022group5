import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/post.dart';

class Comment {
  final int id;
  final Post post;
  final User author;
  final DateTime time;
  final String body;
  int upvotes;
  int downvotes;

  Comment(
      this.id,
      this.post,
      this.author,
      this.time,
      this.body,
      {this.upvotes = 0,
        this.downvotes = 0,}
      );
}
