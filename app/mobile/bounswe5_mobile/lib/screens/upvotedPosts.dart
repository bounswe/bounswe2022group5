import 'package:bounswe5_mobile/screens/upvotedPostsOverviewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../screens/profile.dart';
import '../widgets/ProfileWidget.dart';

class UpvotedPostsPage extends StatefulWidget {
  const UpvotedPostsPage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;
  @override
  State<UpvotedPostsPage> createState() => _UpvotedPostsPageState();
}

class _UpvotedPostsPageState extends State<UpvotedPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [Text(
              'Logo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )
          )
          ],
        ),
        elevation: 0.0,
      ),
      body: UpvotedPostsOverviewScreen(activeUser: widget.activeUser),
    );
  }
}