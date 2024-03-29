// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

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
import 'package:bounswe5_mobile/screens/viewTextAnnotations.dart';
import 'package:bounswe5_mobile/CustomSelectionControls.dart';
import 'package:bounswe5_mobile/screens/createTextAnnotation.dart';

import 'doctorProfile.dart';

enum Menu { itemOne, itemTwo, itemThree }

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
                            InkWell(
                              onTap: () async {
                                final result = await ApiService().getDoctorInfo(article.author.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DoctorProfilePage(profilePicture: result![3],fullName: result![0],specialization: result![1],hospitalName: result![2])),
                                );
                              },
                              child: CircleAvatar(
                                  radius: 20,
                                  child: ClipOval(
                                    child: pp,
                                  )
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
                                      InkWell(
                                        onTap: () async {
                                          final result = await ApiService().getDoctorInfo(article.author.id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => DoctorProfilePage(profilePicture: result![3],fullName: result![0],specialization: result![1],hospitalName: result![2])),
                                          );
                                        },
                                        child: Text(
                                            "Dr. " + article.author.fullName,
                                        ),
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
                                      else if(item == Menu.itemThree){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TextAnnotationsList(token: token, type: "ARTICLE", id: articleid)
                                            )
                                        );
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
                                    const PopupMenuItem<Menu>(
                                      value: Menu.itemThree,
                                      child: Text('See Text Annotations'),
                                    ),
                                  ],
                                );
                              } else if(isSessionActive) {
                                return PopupMenuButton<Menu>(
                                  onSelected: (Menu item) {
                                    setState(() {
                                      if(item == Menu.itemOne) {
                                        print("Report article");
                                      }
                                      else if(item == Menu.itemTwo){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TextAnnotationsList(token: token, type: "ARTICLE", id: articleid)
                                            )
                                        );
                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<Menu>>[
                                    const PopupMenuItem<Menu>(
                                      value: Menu.itemOne,
                                      child: Text('Report'),
                                    ),
                                    const PopupMenuItem<Menu>(
                                      value: Menu.itemTwo,
                                      child: Text('See Text Annotations'),
                                    ),
                                  ],
                                );
                              }
                              else{
                                return PopupMenuButton<Menu>(
                                  onSelected: (Menu item) {
                                    setState(() {
                                      if(item == Menu.itemOne) {
                                        print("Report article");
                                      }
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
                      Container(
                        padding: EdgeInsets.all(5.0),
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        width: double.infinity,
                        child:
                        categoryWidget,
                      ),
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
                        child: containsListTags(article.body) ?
                        // due to a bug in SelectableHtml class, html texts containing
                        // list tags such as <ol>,<ul> cannot be displayed. So, annotation
                        // function does not work for these texts.
                        Html(data:article.body):
                        SelectableHtml(
                          data: article.body,
                          style: {
                            "*": Style(
                              fontSize: FontSize(18),
                            )
                          },
                          selectionControls: isSessionActive ? CustomTextSelectionControls(customButton: (start, end) {

                            var selectedText = removeHtmlTags(article.body).substring(start, end);

                            Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateTextAnnotationPage(type: "ARTICLE", id: widget.article.id, start: start, end: end, activeUser: activeUser, selectedText: selectedText)
                              ),
                            );


                          }): MaterialTextSelectionControls(),

                        ),
                      ),
                      SizedBox(height: 10,),

                      article.labels!.isEmpty || (article.labels!.length == 1 && article.labels![0].name == "")?
                      SizedBox.shrink():
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: RichText(
                          text: TextSpan(
                            text: "Labels:  ",
                            style: TextStyle(color: Colors.black),
                            children: [for(var label in article.labels!) TextSpan(
                              text:"#" + label.name + "  ",
                              style: TextStyle(
                                color: randomColor(),
                                fontStyle: FontStyle.italic,
                              ),
                            )],
                          ),
                        ),
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
              Container(width: 150,
                  child: Text(name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary))),
              SizedBox(width: 10.0),
            ],
          ),
        ),
      ],
    );
  }
}

bool containsListTags(String htmlString){
  return htmlString.contains(RegExp(r'</?[uo]l>')) || htmlString.contains(RegExp(r'</?li>'));
}

String removeHtmlTags(String htmlString){
  String cleaned = htmlString.replaceAll(RegExp(r"</p>"), ' ');
  cleaned = cleaned.replaceAll(RegExp(r"\n+"), '\n');
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  return cleaned.replaceAll(exp, '');
}


Color randomColor(){

  List<dynamic> lst = [0xA50D0D, 0X0DA256, 0x1D0DA5, 0xa50d57, 0x7ba50d, 0x1a174d, 0x05695e, 0x311a80, 0x711111, 0x1a1a97, 0x1616c8, 0x000ae6];
  return Color(lst[Random().nextInt(lst.length)].toInt()).withOpacity(1.0);
}