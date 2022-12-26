/*
This code is adapted from the following website:
https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/
 */

import 'package:bounswe5_mobile/models/comment.dart';
import 'package:bounswe5_mobile/screens/viewPost.dart';
import 'package:flutter/material.dart';

import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/widgets/ArticleItem.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';

import '../models/post.dart';

class UserCommentsOverviewScreen extends StatefulWidget {
  UserCommentsOverviewScreen({required this.activeUser});
  final User activeUser;

  @override
  _UserCommentsOverviewScreenState createState() => _UserCommentsOverviewScreenState();
}
class _UserCommentsOverviewScreenState extends State<UserCommentsOverviewScreen> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfArticlesPerRequest = 7;
  late List<Comment> _comments;
  late List<Post> _posts;
  final int _nextPageTrigger = 5;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    _comments = [];
    _posts = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try{
      List<dynamic> commentsInfo = await ApiService().getUserComments(widget.activeUser, _pageNumber, _numberOfArticlesPerRequest);
      List<Comment> commentsList = commentsInfo[1];
      List<Post> postsList = commentsInfo[2];
      setState(() {
        _isLastPage = commentsList.length < _numberOfArticlesPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _comments.addAll(commentsList);
        _posts.addAll(postsList);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorDialog({required double size}){
    return SizedBox(
      height: 180,
      width: 200,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('An error occurred when fetching the comments.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
              onPressed:  ()  {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                  print("1");
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildCommentsView(),
    );
  }

  Widget buildCommentsView() {
    if (_comments.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
            child: errorDialog(size: 20)
        );
      }
    }
    return ListView.builder(
        itemCount: _comments.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {

          if (index == _comments.length - _nextPageTrigger) {
            print("1");
            fetchData();
          }
          if (index == _comments.length) {
            if (_error) {
              return Center(
                  child: errorDialog(size: 15)
              );
            } else {
              return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
            }
          }
          final Comment comment = _comments[index];
          final Post post = _posts[index];
          print("2");
          return Padding(
              padding: const EdgeInsets.all(6.0),
              child: InkWell(
                child: CommentItem(activeUser: widget.activeUser,comment: comment, post: post,),
                onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewPostPage(activeUser: widget.activeUser, post: post)),
                  );},
              )
          );
        });
  }

}
