// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';

enum Menu { itemOne, itemTwo }

PreferredSizeWidget? myAppBar = AppBar(
  centerTitle: true,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Logo',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ))
    ],
  ),
  elevation: 0.0,
);

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
  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
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
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Logo',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                elevation: 0.0,
              ),
              body: ListView(children: [
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
                                  onSelected: (Menu item) {
                                    setState(() {
                                      if(item == Menu.itemOne) {
                                        print("Edit article");
                                      }
                                      else if(item == Menu.itemTwo){
                                        print("Delete article");
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
                        child: Text(
                          article.body,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
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
                                child: Icon(
                                  Icons.arrow_upward,
                                  size: 30,
                                  // color: Colors.green, // This part will be implemented later: If user upvoted, color will be green.
                                ),
                                onTap: (() {
                                  print("Article upvoted.");
                                }),
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
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 30,
                                  // color: Colors.red, // This part will be implemented later: If user downvoted, color will be red.
                                ),
                                onTap: (() {
                                  print("Article downvoted.");
                                }),
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
