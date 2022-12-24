import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/screens/postSearchOverview.dart';

class PostSearchResultsPage extends StatefulWidget {
  PostSearchResultsPage({required this.token, required this.searchType, this.longitude, this.latitude, this.category, this.keyword, this.name, this.dist});
  final String token;
  final int searchType;
  final String? longitude;
  final String? latitude;
  final String? category;
  final String? keyword;
  final String? name;
  final String? dist;
  @override
  State<PostSearchResultsPage> createState() => _PostSearchResultsPageState();
}

class _PostSearchResultsPageState extends State<PostSearchResultsPage> {

  @override
  Widget build(BuildContext context) {
    ApiService apiServer = ApiService();


    return FutureBuilder<User?>(
      future: apiServer.getUserInfo(widget.token),
      builder: (context,snapshot){

        if( (snapshot.hasData || widget.token == '-1') && snapshot.data != null){

          dynamic result = snapshot.data;

          User activeUser = result ?? User(-1, '-1', '-1', -1);


          Widget body= PostsSearchOverview(activeUser: activeUser, searchType: widget.searchType, longitude: widget.longitude, latitude: widget.latitude, category: widget.category, keyword: widget.keyword,name: widget.name,dist: widget.dist,);

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
