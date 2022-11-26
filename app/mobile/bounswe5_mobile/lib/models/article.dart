import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/doctor.dart';

/// Article is the main element of the Articles section.
class Article {
  final int id;
  final Doctor author;
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

