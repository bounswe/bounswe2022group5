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
import 'package:bounswe5_mobile/screens/postSearchResults.dart';


class PostSearchByKeywordPage extends StatefulWidget {
  const  PostSearchByKeywordPage({Key? key, required String this.token}) : super(key: key);
  final String token;

  @override
  State<PostSearchByKeywordPage> createState() => _PostSearchByKeywordPageState();
}

class _PostSearchByKeywordPageState extends State<PostSearchByKeywordPage> {

  final TextEditingController _keyword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        body: SingleChildScrollView(
            child: Form(
                child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 20.0, 10.0, 0),
                          child: TextFormField( //title field
                            controller: _keyword,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.key),
                              labelText: 'keyword',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0),
                          child:  ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PostSearchResultsPage(token: widget.token, searchType: 1, keyword: _keyword.text,)),
                              );

                            }, child: const Text("Search"),
                          ),
                        ),
                      ],
                    )
                )
            )
        )
    );
  }

}
