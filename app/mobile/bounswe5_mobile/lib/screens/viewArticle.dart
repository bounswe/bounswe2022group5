// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ViewArticlePage extends StatefulWidget {
  const ViewArticlePage({Key? key}) : super(key: key);

  @override
  State<ViewArticlePage> createState() => _ViewArticlePageState();
}

class _ViewArticlePageState extends State<ViewArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Logo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        elevation: 0.0,
      ),
      body: ListView(children: [
        Container(
          constraints: BoxConstraints(maxHeight: double.infinity),
          color: Colors.grey,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.hindustantimes.com/img/2022/03/07/550x309/Patrick_Stewart_1_1646645757381_1646645774641.jpg"),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("professor xavier"),
                            Text("26/11/2022 15.35"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(Icons.more_vert),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: double.infinity,
                child: Text(
                  "\tCategory: Burns or something",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(5.0),
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: double.infinity,
                child: Text(
                  "\tAcnelyste Burns Occurred",
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
                  "\tI have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.2,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "13",
                            style: TextStyle(
                              color: Colors.green[900],
                              fontStyle: FontStyle.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.thumb_down),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "7",
                            style: TextStyle(
                              color: Colors.red[900],
                              fontStyle: FontStyle.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          Icon(Icons.comment),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Comment"),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 0.2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        /////////////////////////////
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.all(10),
              width: 120,
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  Icon(
                    Icons.comment_rounded,
                    color: Colors.white,
                  ),
                  Text("Comments", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.all(10),
              width: 30,
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  Text("1", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
        //////////////////////////////////////////////////
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              constraints: BoxConstraints(maxHeight: double.infinity),
              width: 320,
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                          radius: 20,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("benginbestas"),
                                Text("26/11/2022 14.00"),
                              ],
                            ),
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
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    width: double.infinity,
                    child: Text(
                      "\tYou can do whatever you want, you are fine.",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 0.2,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "135",
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontStyle: FontStyle.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.thumb_down),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                  color: Colors.red[900],
                                  fontStyle: FontStyle.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 220.0,
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
        /////////////////////////////
      ]),
    );
  }
}
