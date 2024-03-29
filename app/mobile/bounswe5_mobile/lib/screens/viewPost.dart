// ignore_for_file: prefer_const_constructors


import 'dart:math';

import 'package:bounswe5_mobile/screens/doctorProfile.dart';
import 'package:bounswe5_mobile/screens/createTextAnnotation.dart';
import 'package:bounswe5_mobile/screens/viewTextAnnotations.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/comment.dart';
import 'package:bounswe5_mobile/screens/createComment.dart';
import 'package:bounswe5_mobile/screens/home.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:bounswe5_mobile/screens/imagesGrid.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/CustomSelectionControls.dart';
import 'package:html/parser.dart';

enum Menu { itemOne, itemTwo, itemThree }

class ViewPostPage extends StatefulWidget {
  const ViewPostPage(
      {Key? key, required User this.activeUser, required this.post})
      : super(key: key);
  final User activeUser;
  final Post post;

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

CommentAuthor ca = CommentAuthor(7,'deneme',false);

class _ViewPostPageState extends State<ViewPostPage> {
  Future<int> postUpvote(int postID, String token) async {
    final result = await ApiService().postUpvote(postID, token);
    return result;
  }

  Future<int> postDownvote(int postID, String token) async {
    final result = await ApiService().postDownvote(postID, token);
    return result;
  }

  Future<int> postDelete(int postID, String token) async {
    final result = await ApiService().postDelete(postID, token);
    return result;
  }

  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

  List<Comment> mockcomments = [
    Comment(
      1,
      DateTime(1,1,1,1,1),
      'hey',
      ca,
      1
    )
  ];


  @override
  Widget build(BuildContext context) {

    ApiService apiServer = ApiService();
    User activeUser = widget.activeUser;
    bool isSessionActive = activeUser.token != '-1';
    String token = activeUser.token;
    int postid = widget.post.id;

    int usertype = activeUser!.usertype; // -1 if session is not active

    String tempImagePath = 'lib/assets/images/generic_user.jpg';

    return FutureBuilder<dynamic>(
      future: apiServer.getSinglePost(token, postid),
      builder: (context,snapshot){

        if( (snapshot.hasData || token == '-1') && snapshot.data != null){

          dynamic result = snapshot.data;
          Post post = result[0];
          List<Comment> comments = result[1];

          Widget pp;
          //print(post.author.profileImageUrl);
          if(post.author.profileImageUrl == null || post.author.profileImageUrl == ""){
            pp = Image.asset(tempImagePath);
          }
          else if(post.author.isDoctor){
            pp = Image.network(post.author.profileImageUrl!);
          }
          else{
            pp = SvgPicture.network(post.author.profileImageUrl!);
          }

          Widget categoryWidget = SizedBox.shrink();
          if(post.category != null){
            if(post.category!.name != ""){
              categoryWidget = CategoryViewer(name: post.category!.name);
            }
          }

          return Scaffold(
            appBar: myAppBar,
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
                          post.author.isDoctor ?
                          InkWell(
                            onTap: () async {
                              final result = await ApiService().getDoctorInfo(post.author.id);
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
                          ):
                          CircleAvatar(
                              radius: 20,
                              child: ClipOval(
                                child: pp,
                              )
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
                                    SizedBox(width: 5),
                                    post.author.isDoctor?
                                    InkWell(
                                      onTap: () async {
                                        final result = await ApiService().getDoctorInfo(post.author.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DoctorProfilePage(profilePicture: result![3],fullName: result![0],specialization: result![1],hospitalName: result![2])),
                                        );
                                      },
                                      child: Text(
                                        post.author.username,
                                      ),
                                    ):
                                    Text(
                                      post.author.username,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      "Published: " +
                                          formatter.format(post.time),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          LayoutBuilder(builder: (context, constraints) {
                            if (widget.activeUser.id == post.author.id) {
                              return PopupMenuButton<Menu>(
                                onSelected: (Menu item) {
                                  setState(() async {
                                    if(item == Menu.itemOne) {
                                      print("Edit Post");
                                    }
                                    else if(item == Menu.itemTwo){
                                      print("Delete Post");
                                      int deleted = await postDelete(widget.post.id, widget.activeUser.token);
                                      if(deleted == 200){
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                token: token,
                                                index: 0,
                                              )),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Could not delete ${deleted}")),
                                        );
                                      }
                                    }
                                    else if(item == Menu.itemThree){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TextAnnotationsList(token: token, type: "POST", id: postid)
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
                                  )
                                ],
                              );
                            } else if(isSessionActive){
                              return PopupMenuButton<Menu>(
                                onSelected: (Menu item) {
                                  setState(() {
                                    if(item == Menu.itemOne) {
                                      print("Report Post");
                                    }
                                    else if(item == Menu.itemTwo){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TextAnnotationsList(token: token, type: "POST", id: postid)
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
                                      print("Report Post");
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
                        post.header,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      constraints: BoxConstraints(maxHeight: double.infinity),
                      width: double.infinity,
                      child: containsListTags(post.body) ?
                      // due to a bug in SelectableHtml class, html texts containing
                      // list tags such as <ol>,<ul> cannot be displayed. So, annotation
                      // function does not work for these texts.
                      Html(data:post.body):
                      SelectableHtml(
                        data: post.body,
                        style: {
                          "*": Style(
                            fontSize: FontSize(18),
                          )
                        },
                        selectionControls: isSessionActive ? CustomTextSelectionControls(customButton: (start, end) {

                          var selectedText = removeHtmlTags(post.body).substring(start, end);

                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateTextAnnotationPage(type: "POST", id: widget.post.id, start: start, end: end, activeUser: activeUser, selectedText: selectedText)
                            ),
                          );


                        }): MaterialTextSelectionControls(),

                      ),
                    ),
                    post.imageUrls.isEmpty ?
                    SizedBox.shrink():
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => imagesGrid(urls: post.imageUrls)),
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
                    SizedBox(height: 10),


                    post.labels.isEmpty || (post.labels.length == 1 && post.labels[0].name == "")?
                    SizedBox.shrink():
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: RichText(
                        text: TextSpan(
                          text: "Labels:  ",
                          style: TextStyle(color: Colors.black),
                          children: [for(var label in post.labels) TextSpan(
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
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (() async {
                                      if (isSessionActive) {
                                        print("Post upvoted.");
                                        final statusCode = await postUpvote(widget.post.id, widget.activeUser.token);
                                        if(statusCode == 200) {
                                          setState(() {
                                            if(widget.post.voteOfActiveUser == null || widget.post.voteOfActiveUser == "downvote") {
                                              widget.post.upvotes = widget.post.upvotes + 1;
                                              widget.post.voteOfActiveUser = "upvote";
                                            } else {
                                              widget.post.downvotes = widget.post.downvotes - 1;
                                              widget.post.voteOfActiveUser = null;
                                            }
                                          });
                                        }
                                      }
                                    }),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: widget.post.voteOfActiveUser == "upvote" ? Colors.green : Colors.black ,
                                      size: 30,
                                      // color: Colors.green, // This part will be implemented later: If user upvoted, color will be green.
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(post.upvotes.toString(),
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),

                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (() async {
                                      if (isSessionActive) {
                                        print("Post downvoted.");
                                        final statusCode = await postDownvote(widget.post.id, widget.activeUser.token);
                                        if(statusCode == 200) {
                                          setState(() {
                                            if(widget.post.voteOfActiveUser == null || widget.post.voteOfActiveUser == "upvote") {
                                              widget.post.downvotes = widget.post.downvotes + 1;
                                              widget.post.voteOfActiveUser = "downvote";
                                            } else {
                                              widget.post.downvotes = widget.post.downvotes - 1;
                                              widget.post.voteOfActiveUser = null;
                                            }
                                          });
                                        }
                                      }
                                    }),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: widget.post.voteOfActiveUser == "downvote" ? Colors.red : Colors.black,
                                      size: 30,
                                      // color: Colors.red, // This part will be implemented later: If user downvoted, color will be red.
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(post.downvotes.toString(),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              ),
                            ],
                          ),
                          isSessionActive
                              ? ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateCommentPage(
                                        activeUser: widget.activeUser,
                                        post: post)),
                              );
                              setState(
                                      () {}); //refresh the page so that the comment will be visible ???
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.comment,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Comment',
                                ),
                              ],
                            ),
                          )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              // Can we get the number of comments info from the API?
              /////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.all(10),
                    width: 120,
                    child: Row(
                      children: [
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.comment_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text("Comments", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  /*
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.all(10),
                  width: 30,
                  child: Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(filedata.length.toString(),
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),*/
                ],
              ),

              //////////////////////////////////////////////////

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < comments.length; i++)
                    CommentItem(activeUser: widget.activeUser, comment: comments[i], post: post,)
                ],
              ),

              /////////////////////////////
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

class CommentItem extends StatefulWidget {
  CommentItem({required this.activeUser, required this.comment, required this.post, Key? key}) : super(key: key);
  final User activeUser;
  final Comment comment;
  final Post post;
  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  Future<int> commentUpvote(int commentID, String token) async {
    final result = await ApiService().commentUpvote(commentID, token);
    return result;
  }

  Future<int> commentDownvote(int commentID, String token) async {
    final result = await ApiService().commentDownvote(commentID, token);
    return result;
  }


  Future<int> commentDelete(int commentID, String token) async {
    final result = await ApiService().commentDelete(commentID, token);
    return result;
  }


  @override
  Widget build(BuildContext context) {

    User activeUser = widget.activeUser;
    Comment comment = widget.comment;
    Post post = widget.post;
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

    bool isSessionActive = activeUser!.token != '-1';

    int usertype = activeUser!.usertype; // -1 if session is not active

    String tempImagePath = 'lib/assets/images/generic_user.jpg';
    Widget pp;

    //(comment.author.profileImageUrl);
    if(comment.author.profileImageUrl == null || comment.author.profileImageUrl == ""){
      pp = Image.asset(tempImagePath);
    }
    else if(comment.author.isDoctor){
      pp = Image.network(comment.author.profileImageUrl!);
    }
    else{
      pp = SvgPicture.network(comment.author.profileImageUrl!);
    }

    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              comment.author.isDoctor ?
              InkWell(
                onTap: () async {
                  final result = await ApiService().getDoctorInfo(comment.author.id);
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
              ):
              CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child: pp,
                  )
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            constraints: BoxConstraints(maxHeight: double.infinity),
            width: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            comment.author.isDoctor?
                            InkWell(
                              onTap: () async {
                                final result = await ApiService().getDoctorInfo(comment.author.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DoctorProfilePage(profilePicture: result![3],fullName: result![0],specialization: result![1],hospitalName: result![2])),
                                );
                              },
                              child: Text(
                                comment.author.username,
                              ),
                            ):
                            Text(
                              comment.author.username,
                            ),
                            Text(formatter.format(comment.time)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        // TODO: Inside this if statement will change with comment author api.
                        if (activeUser.id == comment.author.id) {
                          return PopupMenuButton<Menu>(
                            onSelected: (Menu item) {
                              setState(() async {
                                if(item == Menu.itemOne) {
                                  print("Edit comment");
                                }
                                else if(item == Menu.itemTwo){
                                  print("Delete comment");
                                  int deleted = await commentDelete(widget.comment.id, widget.activeUser.token);
                                  if(deleted == 200){
                                    Navigator.pushReplacement(
                                      context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewPostPage(activeUser: widget.activeUser, post:widget.post)
                                        ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Could not delete ${deleted}")),
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
                        }
                        else {
                          return PopupMenuButton<Menu>(
                            onSelected: (Menu item) {
                              setState(() {
                                print("Report Comment");
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
                  padding: EdgeInsets.all(15.0),
                  constraints:
                  BoxConstraints(maxHeight: double.infinity),
                  width: double.infinity,
                  child: Text(
                    comment.body,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                    ),
                  ),
                ),

                comment.imageUrls.isEmpty ?
                SizedBox.shrink():
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => imagesGrid(urls: comment.imageUrls)),
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

                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (() async {
                                  if (isSessionActive)  {
                                    print("Comment upvoted.");
                                    final statusCode = await commentUpvote(widget.comment.id , widget.activeUser.token);
                                    if(statusCode == 200) {
                                      setState(() {
                                        if(comment.voteOfActiveUser == null || comment.voteOfActiveUser == "downvote") {
                                          comment.upvotes = comment.upvotes + 1;
                                          comment.voteOfActiveUser = "upvote";
                                        } else {
                                          comment.upvotes = comment.upvotes - 1;
                                          comment.voteOfActiveUser = null;
                                        }
                                      });
                                    }
                                  }
                                }),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: comment.voteOfActiveUser == "upvote" ? Colors.green : Colors.black,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(comment.upvotes.toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: (() async {
                                  if (isSessionActive) {
                                    print("Comment downvoted.");
                                    final statusCode = await commentDownvote(widget.comment.id , widget.activeUser.token);
                                    if(statusCode == 200) {
                                      setState(() {
                                        if(comment.voteOfActiveUser == null || comment.voteOfActiveUser == "upvote") {
                                          comment.downvotes = comment.downvotes + 1;
                                          comment.voteOfActiveUser = "downvote";
                                        } else {
                                          comment.downvotes = comment.downvotes - 1;
                                          comment.voteOfActiveUser = null;
                                        }
                                      });
                                    }
                                  }
                                }),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: comment.voteOfActiveUser == "downvote" ? Colors.red : Colors.black,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                             Text(comment.downvotes.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
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
  String cleaned = htmlString.replaceAll(r"</p>", ' ');
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  return cleaned.replaceAll(exp, '');
}

Color randomColor(){

  List<dynamic> lst = [0xA50D0D, 0X0DA256, 0x1D0DA5, 0xa50d57, 0x7ba50d, 0x1a174d, 0x05695e, 0x311a80, 0x711111, 0x1a1a97, 0x1616c8, 0x000ae6];
  return Color(lst[Random().nextInt(lst.length)].toInt()).withOpacity(1.0);
}