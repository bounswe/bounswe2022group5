import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../screens/profile.dart';
import '../widgets/ProfileWidget.dart';
import '../screens/userArticleOverviewScreen.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;
  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: UserArticlesOverviewScreen(activeUser: widget.activeUser),
    );
  }
}