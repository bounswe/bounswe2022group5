import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../screens/profile.dart';
import '../widgets/ProfileWidget.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar
    );
  }
}