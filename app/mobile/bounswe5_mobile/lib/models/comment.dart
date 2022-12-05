
class Comment {
  final int id;
  final DateTime time;
  final String body;
  int upvotes;
  int downvotes;
  double? longitude;
  double? latitude;
  final CommentAuthor author;
  int postid;
  String? voteOfActiveUser;
  List<String> imageUrls = [];

  Comment(
      this.id,
      this.time,
      this.body,
      this.author,
      this.postid,
      {this.upvotes = 0,
        this.downvotes = 0,}
      );

  setVoteOfActiveUser(String vote){
    voteOfActiveUser = vote;
  }

  setLongitude(double newLongitude){
    longitude = newLongitude;
  }

  setLatitude(double newLatitude){
    latitude = newLatitude;
  }

}

class CommentAuthor {
  final int id;
  final String username;
  String? profileImageUrl;
  final bool isDoctor;

  CommentAuthor(
      this.id,
      this.username,
      this.isDoctor
      );

  setProfileImageUrl(String url) {
    profileImageUrl = url;
  }
}