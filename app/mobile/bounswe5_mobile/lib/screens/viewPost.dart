// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/comment.dart';
import 'package:bounswe5_mobile/screens/createComment.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:flutter_html/flutter_html.dart';

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
  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

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
                                  setState(() {
                                    if(item == Menu.itemOne) {
                                      print("Edit Post");
                                    }
                                    else if(item == Menu.itemTwo){
                                      print("Delete Post");
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
                                    print("Report Post");
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
                      child: Html(
                          data:post.body,
                      ),

                      /*
                      Text(
                        post.body,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                      */

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
                                    onTap: (() {
                                      if (isSessionActive) {
                                        print("Post upvoted.");
                                      }
                                    }),
                                    child: Icon(
                                      Icons.arrow_upward,
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
                                          fontSize: 20))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (() {
                                      if (isSessionActive) {
                                        print("Post downvoted.");
                                      }
                                    }),
                                    child: Icon(
                                      Icons.arrow_downward,
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
                                        postID: post.id)),
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
  @override
  Widget build(BuildContext context) {

    User activeUser = widget.activeUser;
    Comment comment = widget.comment;
    Post post = widget.post;
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

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
                            Text(comment.author.username),
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
                              setState(() {
                                if(item == Menu.itemOne) {
                                  print("Edit comment");
                                }
                                else if(item == Menu.itemTwo){
                                  print("Delete comment");
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
                                onTap: (() {
                                  if (isSessionActive) {
                                    print("Post upvoted.");
                                  }
                                }),
                                child: Icon(
                                  Icons.arrow_upward,
                                  size: 30,
                                  // color: Colors.green, // This part will be implemented later: If user upvoted, color will be green.
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
                                onTap: (() {
                                  if (isSessionActive) {
                                    print("Comment downvoted.");
                                  }
                                }),
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 30,
                                  // color: Colors.red, // This part will be implemented later: If user downvoted, color will be red.
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




/*
CommentItem can be a class by itself

Instead of separate User and Doctor models, it will be better
to have a single User model since some entities can be created
by both doctors and members.
 */