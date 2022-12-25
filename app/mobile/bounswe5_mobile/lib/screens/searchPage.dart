import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/screens/searchPost.dart';
import 'package:bounswe5_mobile/screens/searchArticle.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required String this.token}) : super(key: key);
  final String token;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: myAppBar,
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB( 10.0, 0, 10.0, 10.0),
                      child:  ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchPostPage(token: widget.token)),
                          );

                        }, child: const Text("Search Post"),
                        style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB( 10.0, 0, 10.0, 10.0),
                      child:  ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchArticlePage(token: widget.token)),
                          );

                        }, child: const Text("Search Article"),
                        style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
                      ),
                    ),
                  ],
                ),
            )
        )
    );
  }

}
