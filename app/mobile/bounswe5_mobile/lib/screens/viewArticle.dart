// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/models/user.dart';

class ViewArticlePage extends StatefulWidget {
  const ViewArticlePage({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  State<ViewArticlePage> createState() => _ViewArticlePageState();
}

class _ViewArticlePageState extends State<ViewArticlePage> {

  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
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
                              Icon(Icons.check),
                              SizedBox(width: 5),
                              Text(
                                "Dr. " + widget.article.author.fullName,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text(
                                "Published: " + formatter.format(widget.article.time),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(5.0),
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: double.infinity,
                child: Text(
                  widget.article.header,
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
                  widget.article.body,
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
                        onTap: ((){
                          print("Article upvoted.");
                        }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.article.upvotes.toString(),
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                      )
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
                        onTap: ((){
                          print("Article downvoted.");
                        }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.article.downvotes.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        CategoryViewer(name: "Pediatry"),
      ]),
    );
  }
}


class CategoryViewer extends StatelessWidget{
  CategoryViewer({required this.name});
  final String name;

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.all(15),
          height: 35,
          width: 120,
          child: Row(
            children: [
              SizedBox(width: 15.0),
              Icon(
                Icons.category,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(width: 10.0),
              Text(name, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}