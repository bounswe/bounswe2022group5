import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';

class Post {
  final User sender;
  final DateTime time;
  final String header;
  final String body;
  int upvotes;
  int downvotes;
  bool isDoctorReplied;

  Post(
      this.sender,
      this.time,
      this.header,
      this.body,
      {this.upvotes = 0,
        this.downvotes = 0,
        this.isDoctorReplied = false,}
      );
}

// Mock Data:

List<Post> posts = [
  Post(
    burak,
    DateTime.utc(2022, 11, 9),
    'Lorem ipsum dolor sit amet 1',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    upvotes : 12,
    downvotes : 3,
    isDoctorReplied : false,
  ),
  Post(
    oguzhan,
    DateTime.utc(2022, 11, 10),
    'Lorem ipsum dolor sit amet 2',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    upvotes : 8,
    downvotes : 1,
    isDoctorReplied : true,
  ),
  Post(
    kardelen,
    DateTime.utc(2022, 11, 14),
    'Lorem ipsum dolor sit amet 3',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    upvotes : 5,
    downvotes : 2,
    isDoctorReplied : false,
  ),
  Post(
    bengin,
    DateTime.utc(2022, 11, 16),
    'Lorem ipsum dolor sit amet 4',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    upvotes : 15,
    downvotes : 7,
    isDoctorReplied : true,
  ),
  Post(
    burak,
    DateTime.utc(2022, 11, 19),
    'Lorem ipsum dolor sit amet 5',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    upvotes : 0,
    downvotes : 0,
    isDoctorReplied : false,
  ),
  Post(
    bengin,
    DateTime.utc(2022, 11, 20),
    'Lorem ipsum dolor sit amet 6',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    upvotes : 1,
    downvotes : 0,
    isDoctorReplied : false,
  ),
];