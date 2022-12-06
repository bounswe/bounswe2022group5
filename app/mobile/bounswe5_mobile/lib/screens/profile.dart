import 'package:bounswe5_mobile/screens/posts.dart';
import 'package:bounswe5_mobile/screens/upvotes.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
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
    return Scaffold(
      appBar: myAppBar,

      body: Column(
        children: <Widget>[
          const SizedBox(height: 35),
          ProfileWidget(
            activeUser: widget.activeUser,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(widget.activeUser),
          SizedBox(height: 20),
          ProfileListItem(
            icon: Icons.arrow_upward,
            text: 'Upvotes',
            routepage: UpvotesPage(activeUser: widget.activeUser!)
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
        ],
      ),
    );
  }
}

