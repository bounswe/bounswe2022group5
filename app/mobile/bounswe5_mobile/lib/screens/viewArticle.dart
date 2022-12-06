// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bounswe5_mobile/screens/imagesGrid.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/screens/home.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';

enum Menu { itemOne, itemTwo }

class ViewArticlePage extends StatefulWidget {
  const ViewArticlePage(
      {Key? key, required this.activeUser, required this.article})
      : super(key: key);
  final User activeUser;
  final Article article;

  @override
  State<ViewArticlePage> createState() => _ViewArticlePageState();
}

class _ViewArticlePageState extends State<ViewArticlePage> {
  Future<int> articleUpvote(int articleID, String token) async {
    final result = await ApiService().articleUpvote(articleID, token);
    return result;
  }

  Future<int> articleDownvote(int articleID, String token) async {
    final result = await ApiService().articleDownvote(articleID, token);
    return result;
  }

  Future<int> articleDelete(int articleID, String token) async {
    final result = await ApiService().articleDelete(articleID, token);
    return result;
  }

  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');
  @override
  Widget build(BuildContext context) {
    ApiService apiServer = ApiService();
    User activeUser = widget.activeUser;
    bool isSessionActive = activeUser.token != '-1';
    String token = activeUser.token;
    int articleid = widget.article.id;

    String tempImagePath = 'lib/assets/images/generic_user.jpg';




    return FutureBuilder(
        future: apiServer.getSingleArticle(token, articleid),
        builder: (context,snapshot){

          if( (snapshot.hasData || token == '-1') && snapshot.data != null){

            dynamic result = snapshot.data;
            Article article = result;

            List<String> listOfUrls = article.imageUrls;

            Widget pp;

            if(article.author.profileImageUrl == null || article.author.profileImageUrl == ""){
              pp = Image.asset(tempImagePath);
            }
            else{
              pp = Image.network(article.author.profileImageUrl!);
            }

            Widget categoryWidget = SizedBox.shrink();
            if(article.category != null){
              if(article.category!.name != ""){
                categoryWidget = CategoryViewer(name: article.category!.name);
              }
            }



            return Scaffold(
              appBar: myAppBar,
              body:


              ListView(children: [

                Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  color: Theme.of(context).colorScheme.surface,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: ClipOval(
                                child: pp,
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check),
                                      SizedBox(width: 5),
                                      Text(
                                        "Dr. " + article.author.fullName,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Text(
                                        "Published: " +
                                            formatter.format(article.time),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.0),
                            LayoutBuilder(builder: (context, constraints) {
                              if (activeUser.id == article.author.id) {
                                return PopupMenuButton<Menu>(
                                  onSelected: (Menu item) async {
                                    setState(() async {
                                      if(item == Menu.itemOne) {
                                        print("Edit article");
                                      }
                                      else if(item == Menu.itemTwo){
                                        print("Delete article");
                                        int deleted = await articleDelete(widget.article.id, widget.activeUser.token);
                                        if(deleted == 200){
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage(
                                                  token: activeUser.token,
                                                  index: 1,
                                                )),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(
                                                "Could not delete ${deleted}")),
                                          );
                                        }

                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<Menu>>[
                                    const PopupMenuItem<Menu>(
                                      value: Menu.itemOne,
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem<Menu>(
                                      value: Menu.itemTwo,
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              } else {
                                return PopupMenuButton<Menu>(
                                  onSelected: (Menu item) {
                                    setState(() {
                                      print("Report article");
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<Menu>>[
                                    const PopupMenuItem<Menu>(
                                      value: Menu.itemOne,
                                      child: Text('Report'),
                                    ),
                                  ],
                                );
                              }
                            })
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        width: double.infinity,
                        child: Text(
                          article.header,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        width: double.infinity,
                        child: Html(
                          data: article.body,
                          defaultTextStyle: TextStyle(
                              fontSize: 15
                          ),
                        )
                      ),
                      SizedBox(height: 18),
                      article.imageUrls.isEmpty ?
                      SizedBox.shrink():
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => imagesGrid(urls: listOfUrls)),
                          );
                        },
                        child: Text(
                          'See Images',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (() async {
                                  print("Article upvoted.");
                                  final statusCode = await articleUpvote(widget.article.id , widget.activeUser.token);
                                  if(statusCode == 200) {
                                    setState(() {
                                      if(widget.article.voteOfActiveUser == null || widget.article.voteOfActiveUser == "downvote") {
                                        widget.article.upvotes = widget.article.upvotes + 1;
                                        widget.article.voteOfActiveUser = "upvote";
                                      } else {
                                        widget.article.upvotes = widget.article.upvotes - 1;
                                        widget.article.voteOfActiveUser = null;
                                      }
                                    });
                                  }
                                }),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: widget.article.voteOfActiveUser == "upvote" ? Colors.green : Colors.black,
                                  size: 30,
                                  // color: Colors.green, // This part will be implemented later: If user upvoted, color will be green.
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(article.upvotes.toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: (() async {
                                  print("Article downvoted.");
                                  final statusCode = await articleDownvote(widget.article.id , widget.activeUser.token);
                                  if(statusCode == 200) {
                                    setState(() {
                                      if(widget.article.voteOfActiveUser == null || widget.article.voteOfActiveUser == "upvote") {
                                        widget.article.downvotes = widget.article.downvotes + 1;
                                        widget.article.voteOfActiveUser = "downvote";
                                      } else {
                                        widget.article.downvotes = widget.article.downvotes - 1;
                                        widget.article.voteOfActiveUser = null;
                                      }
                                    });
                                  }
                                }),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: widget.article.voteOfActiveUser == "downvote" ? Colors.red : Colors.black,
                                  size: 30,
                                  // color: Colors.red, // This part will be implemented later: If user downvoted, color will be red.
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(article.downvotes.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                categoryWidget,
              ]),

            );
          }
          else {
            return Scaffold(
                appBar: myAppBar,
                body: Center(child: CircularProgressIndicator()));
          }
      }
    );
  }
}

class CategoryViewer extends StatelessWidget {
  CategoryViewer({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(width: 15.0),
              Icon(
                Icons.category,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(width: 10.0),
              Text(name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
              SizedBox(width: 10.0),
            ],
          ),
        ),
      ],
    );
  }
}
