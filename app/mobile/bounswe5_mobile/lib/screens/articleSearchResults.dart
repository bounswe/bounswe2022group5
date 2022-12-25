import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/screens/articleSearchOverview.dart';

class ArticleSearchResultsPage extends StatefulWidget {
  ArticleSearchResultsPage({required this.token, required this.searchType, this.category, this.keyword, this.name});
  final String token;
  final int searchType;
  final String? category;
  final String? keyword;
  final String? name;
  @override
  State<ArticleSearchResultsPage> createState() => _ArticleSearchResultsPageState();
}

class _ArticleSearchResultsPageState extends State<ArticleSearchResultsPage> {

  @override
  Widget build(BuildContext context) {
    ApiService apiServer = ApiService();


    return FutureBuilder<User?>(
      future: apiServer.getUserInfo(widget.token),
      builder: (context,snapshot){

        if( (snapshot.hasData || widget.token == '-1') && snapshot.data != null){

          dynamic result = snapshot.data;

          User activeUser = result ?? User(-1, '-1', '-1', -1);


          Widget body= ArticleSearchOverview(activeUser: activeUser, searchType: widget.searchType, category: widget.category, keyword: widget.keyword,name: widget.name,);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                  'Search Results',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
              elevation: 0.0,
            ),
            body: body,
          );
        }
        // Show a loading icon until the user data is loaded.
        else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
