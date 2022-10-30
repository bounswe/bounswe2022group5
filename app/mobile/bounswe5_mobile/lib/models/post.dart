import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';

/// Post is the main element of the forum.
class Post {
  //final User sender; // For now, we do not have a sender user.
  final DateTime time;
  final String header;
  final String body;
  int upvotes;
  int downvotes;
  bool isDoctorReplied;

  Post(
      //this.sender,
      this.time,
      this.header,
      this.body,
      {this.upvotes = 0,
        this.downvotes = 0,
        this.isDoctorReplied = false,}
      );
}

// Mock Post Data:

List<Post> posts = [
  Post(
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
    isDoctorReplied : true,
  ),
  Post(
    DateTime.utc(2022, 2, 11),
    'Lotion For Hair Eczema',
    'I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do? away? Please help',
    upvotes : 6,
    downvotes : 2,
    isDoctorReplied : false,
  ),
  Post(
    DateTime.utc(2022, 3, 17),
    'Face Numbing and Blurred Vision',
    'I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is .....',
    upvotes : 16,
    downvotes : 1,
    isDoctorReplied : false,
  ),
  Post(
    DateTime.utc(2022, 3, 21),
    'Iron Level in my Blood Test',
    'As a result of the blood test I had, iron was found to be 211.117. Ferritin 53.99. My doctor said it was not anemia. Is it normal for iron to be this high? What do you suggest?',
    upvotes : 7,
    downvotes : 2,
    isDoctorReplied : true,
  ),
];