import 'package:bounswe5_mobile/screens/upvotedArticlesOverviewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../screens/profile.dart';
import '../widgets/ProfileWidget.dart';

class UpvotedArticlesPage extends StatefulWidget {
  const UpvotedArticlesPage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;
  @override
  State<UpvotedArticlesPage> createState() => _UpvotedArticlesPageState();
}

class _UpvotedArticlesPageState extends State<UpvotedArticlesPage> {
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
      body: UpvotedArticlesOverviewScreen(activeUser: widget.activeUser),
    );
  }
}