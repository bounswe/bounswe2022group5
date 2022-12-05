import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/widgets/ForumPostItem.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';

/// This code was used for listing all posts but
/// it is obsolete. Kept for possible later uses.
class ForumList extends StatefulWidget{
  ForumList({required this.activeUser, required this.totalNumberOfPosts, required this.postPerPage, required this.posts});
  final User activeUser;
  final List<Post> posts;
  final int totalNumberOfPosts;
  final int postPerPage;
  int pageNumber = 1;

  @override
  State<ForumList> createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  @override
  Widget build(BuildContext context){

    int lastPageNumber = (widget.totalNumberOfPosts ~/ widget.postPerPage) + 1;
    bool isLastPage = widget.pageNumber == lastPageNumber;

    ApiService apiService = ApiService();

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: widget.posts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if(index == widget.posts.length){
          if(!(isLastPage)){
            return ElevatedButton(onPressed:(){
              setState(() {
                /*
                widget.pageNumber += 1;
                List<Post> newposts = apiService.getPosts(widget.activeUser.token, widget.pageNumber, widget.postPerPage);
                widget.posts.addAll(newposts);
                */

              });
            }, child: const Text('Load More Posts'));
          }
          else{
            return const Text("No More Posts :(");
          }

        }
        final post = widget.posts[index];
        return ForumPostItem(activeUser: widget.activeUser, post: post);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}