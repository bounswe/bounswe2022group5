/*
This code is adapted from the following website:
https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/
 */

import 'package:flutter/material.dart';

import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/widgets/ArticleItem.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';

class ArticlesOverviewScreen extends StatefulWidget {
  ArticlesOverviewScreen({required this.activeUser});
  final User activeUser;

  @override
  _ArticlesOverviewScreenState createState() => _ArticlesOverviewScreenState();
}
class _ArticlesOverviewScreenState extends State<ArticlesOverviewScreen> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfArticlesPerRequest = 7;
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
      List<dynamic> articlesInfo = await ApiService().getArticles(widget.activeUser.token, _pageNumber, _numberOfArticlesPerRequest);
      List<Article> articlesList = articlesInfo[1];
      setState(() {
        _isLastPage = articlesList.length < _numberOfArticlesPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _articles.addAll(articlesList);
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
          Text('An error occurred when fetching the articles.',
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
      body: buildArticlesView(),
    );
  }

  Widget buildArticlesView() {
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
