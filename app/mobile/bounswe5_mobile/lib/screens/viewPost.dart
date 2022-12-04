// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/comment.dart';
import 'package:bounswe5_mobile/screens/createComment.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';

enum Menu { itemOne, itemTwo }

class ViewPostPage extends StatefulWidget {
  const ViewPostPage(
      {Key? key, required User this.activeUser, required this.post})
      : super(key: key);
  final User activeUser;
  final Post post;

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  List filedata = [
    {
      'name': 'benginbestas',
      'pic':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'message': 'I am sorry',
      'date': '2022-02-01 12:00',
      'upvote': '7',
      'downvote': '3',
    },
    {
      'name': 'benginbestas',
      'pic':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'message': 'Very cool',
      'date': '2022-01-04 12:00',
      'upvote': '2',
      'downvote': '5',
    },
    {
      'name': 'benginbestas',
      'pic':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'message': 'ty for replies',
      'date': '2022-05-02 12:00',
      'upvote': '342',
      'downvote': '3',
    },
    {
      'name': 'benginbestas',
      'pic':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'message': 'Very cool',
      'date': '2022-02-08 12:00',
      'upvote': '732',
      'downvote': '315',
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isSessionActive = widget.activeUser.token != '-1';

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
                      backgroundImage: AssetImage(tempImagePath),
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
                                widget.post.author.username,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text(
                                "Published: " +
                                    formatter.format(widget.post.time),
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
                      if (widget.activeUser == widget.post.author) {
                        return PopupMenuButton<Menu>(
                          onSelected: (Menu item) {
                            setState(() {
                              //_selectedMenu = item.name;
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<Menu>>[
                            const PopupMenuItem<Menu>(
                              value: Menu.itemOne,
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<Menu>(
                              value: Menu.itemOne,
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      } else {
                        return PopupMenuButton<Menu>(
                          onSelected: (Menu item) {
                            setState(() {
                              //_selectedMenu = item.name;
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
                    /*
                    PopupMenuButton<Menu>(
                      onSelected: (Menu item) {
                        setState(() {
                          //_selectedMenu = item.name;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<Menu>>[
                        const PopupMenuItem<Menu>(
                          value: Menu.itemOne,
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<Menu>(
                          value: Menu.itemOne,
                          child: Text('Delete'),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: double.infinity,
                child: Text(
                  widget.post.header,
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
                child: Text(
                  widget.post.body,
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
                            Text(widget.post.upvotes.toString(),
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
                            Text(widget.post.downvotes.toString(),
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
                                        postID: widget.post.id)),
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
            for (var i = 0; i < filedata.length; i++)
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          backgroundImage: NetworkImage(filedata[i]['pic']),
                          radius: 20,
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
                                      Text(filedata[i]['name']),
                                      Text(filedata[i]['date']),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.more_vert),
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
                              filedata[i]['message'],
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
                                        Text(filedata[i]['upvote'],
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
                                        Text(filedata[i]['downvote'],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ],
                                ),
                                /*
                                ElevatedButton(
                                  onPressed: ((){}),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:Theme.of(context).colorScheme.error,
                                    minimumSize: Size(0,0)
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.report),
                                      SizedBox(width: 2),
                                      Text('Report'),
                                    ],
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),

        /////////////////////////////
      ]),
    );
  }
}

/*
CommentItem can be a class by itself

Instead of separate User and Doctor models, it will be better
to have a single User model since some entities can be created
by both doctors and members.
 */