import 'package:bounswe5_mobile/screens/articleSearchResults.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class ArticleSearchByKeywordPage extends StatefulWidget {
  const  ArticleSearchByKeywordPage({Key? key, required String this.token}) : super(key: key);
  final String token;

  @override
  State<ArticleSearchByKeywordPage> createState() => _ArticleSearchByKeywordPageState();
}

class _ArticleSearchByKeywordPageState extends State<ArticleSearchByKeywordPage> {

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
                                        ArticleSearchResultsPage(token: widget.token, searchType: 1, keyword: _keyword.text,)),
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
