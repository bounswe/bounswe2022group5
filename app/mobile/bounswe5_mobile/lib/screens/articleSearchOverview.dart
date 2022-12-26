/*
This code is adapted from the following website:
https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/
 */

import 'package:flutter/material.dart';

import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/widgets/ArticleItem.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';

class ArticleSearchOverview extends StatefulWidget {
  ArticleSearchOverview({required this.activeUser, required this.searchType, this.category, this.keyword, this.name});
  final User activeUser;
  final int searchType;
  final String? category;
  final String? keyword;
  final String? name;

  @override
  _ArticleSearchOverviewState createState() => _ArticleSearchOverviewState();
}
class _ArticleSearchOverviewState extends State<ArticleSearchOverview> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 15;
  late List<Article> _articles;
  final int _nextPageTrigger = 2;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    _articles = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try{
      List<dynamic> articleInfo = [];
      if(widget.searchType == 0) { //category search
        articleInfo = await ApiService().articleSearchCategory(
            widget.activeUser.token, _pageNumber, _numberOfPostsPerRequest,
            widget.category!);
      } else if(widget.searchType == 1) { //keyword search
        articleInfo = await ApiService().articleSearchKeyword(widget.activeUser.token, _pageNumber, _numberOfPostsPerRequest, widget.keyword!);
      } else if(widget.searchType == 2) { //name
        //postInfo = await ApiService().searchPostCategory(widget.activeUser.token, _pageNumber, _numberOfPostsPerRequest, widget.category!);
      }
      int totalNofArticles = articleInfo[0];
      //print("/forum/posts?page=$_pageNumber&page_size=$_numberOfPostsPerRequest");
      //print("total posts: $totalNofPosts");
      List<Article> articleList = articleInfo[1];
      setState(() {

        _loading = false;
        _pageNumber = _pageNumber + 1;
        _articles.addAll(articleList);
        _isLastPage = articleList.isEmpty;
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
    if (_articles.isEmpty) {
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
        itemCount: _articles.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {

          if (index == _articles.length - _nextPageTrigger) {
            fetchData();
          }
          if (index == _articles.length) {
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
          final Article article = _articles[index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ArticleItem(activeUser: widget.activeUser,article: article,)
          );
        });
  }

}
