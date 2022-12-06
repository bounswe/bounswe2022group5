import 'package:bounswe5_mobile/screens/articles.dart';
import 'package:bounswe5_mobile/screens/posts.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/screens/upvotedArticles.dart';
import 'package:bounswe5_mobile/screens/upvotedPosts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../widgets/ProfileName.dart';
import '../widgets/ProfileWidget.dart';
import '../screens/comments.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext  context) {
    bool isMember = false;
    if (widget.activeUser.usertype == 2){
      isMember = true;
    }
    return Scaffold(
      appBar: myAppBar,

      body: Column(
        children: <Widget>[
          const SizedBox(height: 25),
          ProfileWidget(
            activeUser: widget.activeUser,
            onClicked: () async {},
          ),
          const SizedBox(height: 16),
          buildName(widget.activeUser),
          SizedBox(height: 16),
          isMember? SizedBox(height: 1) :
          ProfileListItem(
              icon: Icons.library_books,
              text: 'Articles',
              routepage: ArticlesPage(activeUser: widget.activeUser!)
          ),
          ProfileListItem(
            icon: Icons.post_add_outlined,
            text: 'Posts',
            routepage: PostsPage(activeUser: widget.activeUser!),
          ),
          ProfileListItem(
            icon: CupertinoIcons.bubble_right,
            text: 'Comments',
            routepage: CommentsPage(activeUser: widget.activeUser!),
          ),
          ProfileListItem(
              icon: Icons.arrow_upward,
              text: 'Upvoted Articles',
              routepage: UpvotedArticlesPage(activeUser: widget.activeUser!)
          ),
          ProfileListItem(
              icon: Icons.arrow_upward,
              text: 'Upvoted Posts',
              routepage: UpvotedPostsPage(activeUser: widget.activeUser!)
          ),
        ],
      ),
    );
  }
}

