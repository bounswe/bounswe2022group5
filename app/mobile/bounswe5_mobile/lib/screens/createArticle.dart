import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';

const List<String> categories = <String>['Anatomical Pathology', 'Anesthesiology','Cardiology','Hematology', 'Cardiovascular & Thoracic Surgery', 'Clinical Immunology/Allergy', 'Critical Care Medicine'];

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {

  Future<int> share(String token, String title, String author, String body) async { //register API call handling function
    final result = await ApiService().createArticle(token, title, author, body);
    return result;
  }

  List tags = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final GlobalKey<TagsState> _tagKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {

    String categoryValue = categories.first;
    ApiService apiServer = ApiService();
    return  FutureBuilder<User?>(
        future: apiServer.getUserInfo(widget.activeUser.token),
        builder: (context,snapshot) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:[Text(
                      'Logo',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      )
                  )],
                ),
                elevation: 0.0,
              ),
              body: Container(
                  child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Container(
                            color: Colors.white54,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(),
                                      labelText: '*Category',
                                    ),
                                    value: categoryValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        categoryValue = value!;
                                      });
                                    },
                                    items: categories.map<DropdownMenuItem<String>> ((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                    child: Tags(
                                      key: _tagKey,
                                      itemCount: tags.length,
                                      columns: 6,
                                      textField: TagsTextField(

                                        onSubmitted: (string) {
                                          setState(() {
                                            tags.add(Item(title: string));
                                          });
                                        },
                                      ),
                                      itemBuilder: (index) {
                                        final Item currentItem = tags[index];
                                        return ItemTags(
                                          index: index,
                                          title: currentItem.title,
                                          customData: currentItem.customData,
                                          textStyle: const TextStyle(fontSize: 14),
                                          combine: ItemTagsCombine.withTextBefore,
                                          removeButton: ItemTagsRemoveButton(
                                            onRemoved: () {
                                              setState(() {
                                                tags.removeAt(index);
                                              });
                                              return true;
                                            },
                                          ),


                                        );
                                      },
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                  child: TextFormField( //title field
                                    controller: _title,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Title',
                                    ),
                                    validator: (value) { //validate
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a title';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                  child: TextFormField( //body field
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 15,
                                    controller: _body,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Body of the article',
                                      alignLabelWithHint: true,
                                    ),
                                    validator: (value) { //validate
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the body of the article';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                    children: [
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent),
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 0.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // Validate returns true if the form is valid, or false otherwise.
                                                if (_formKey.currentState!.validate()) {
                                                  String token = snapshot.data!.token;
                                                  String author = snapshot.data!.id.toString();
                                                  int shared = await share(token, _title.text, author, _body.text);
                                                  if (shared == 200) {
                                                    Navigator.pop(context);
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Could not share")),
                                                    );
                                                  }
                                                }
                                              },
                                              child: const Text('Share Article'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),

                              ],
                            ),
                          )
                      )
                  )
              )
          );
        }
    );
  }

}
