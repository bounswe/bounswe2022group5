import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/widgets/ForumPostItem.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';

/// List of forum items
class ForumList extends StatelessWidget{
  ForumList({required this.activeUser, required this.posts});
  final User activeUser;
  final List<Post> posts;

  @override
  Widget build(BuildContext context){
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        return ForumPostItem(activeUser: activeUser, index: index, post: post, formatter: formatter);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}