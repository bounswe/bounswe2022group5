/*
This code is adapted from the following website:
https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/
 */

import 'package:flutter/material.dart';

import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/widgets/ForumPostItem.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';

class PostsSearchOverview extends StatefulWidget {
  PostsSearchOverview({required this.activeUser, required this.searchType, this.longitude, this.latitude, this.category, this.keyword, this.name, this.dist});
  final User activeUser;
  final int searchType;
  final String? longitude;
  final String? latitude;
  final String? category;
  final String? keyword;
  final String? name;
  final String? dist;

  @override
  _PostsSearchOverviewState createState() => _PostsSearchOverviewState();
}
class _PostsSearchOverviewState extends State<PostsSearchOverview> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 15;
  late List<Post> _posts;
  final int _nextPageTrigger = 2;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    _posts = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try{
      List<dynamic> postInfo = [];
      if(widget.searchType == 0) { //category search
        postInfo = await ApiService().searchPostCategory(
            widget.activeUser.token, _pageNumber, _numberOfPostsPerRequest,
            widget.category!);
      } else if(widget.searchType == 1) { //keyword search
        postInfo = await ApiService().searchPostKeyword(widget.activeUser.token, _pageNumber, _numberOfPostsPerRequest, widget.keyword!);
      } else if(widget.searchType == 2) { //geolocation
        print("DIST ${widget.dist}");
        print("LONGITUDE ${widget.longitude}");
        print("LATITUDE ${widget.latitude}");
        postInfo = await ApiService().searchPostGeolocation(
            widget.activeUser.token, _pageNumber, _numberOfPostsPerRequest,
            widget.dist!, widget.longitude!, widget.latitude!);
        print(postInfo);
      }
      int totalNofPosts = postInfo[0];
      //print("/forum/posts?page=$_pageNumber&page_size=$_numberOfPostsPerRequest");
      //print("total posts: $totalNofPosts");
      List<Post> postList = postInfo[1];
      setState(() {

        _loading = false;
        _pageNumber = _pageNumber + 1;
        _posts.addAll(postList);
        _isLastPage = postList.isEmpty;
        //_isLastPage = _posts.length == totalNofPosts; // Actual code

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
          Text('An error occurred when fetching the posts.',
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
      body: buildPostsView(),
    );
  }

  Widget buildPostsView() {
    if (_posts.isEmpty) {
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
        itemCount: _posts.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {

          if (index == _posts.length - _nextPageTrigger) {
            fetchData();
          }
          if (index == _posts.length) {
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
          final Post post = _posts[index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ForumPostItem(activeUser: widget.activeUser,post: post,)
          );
        });
  }

}
