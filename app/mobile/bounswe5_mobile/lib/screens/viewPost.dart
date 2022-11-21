// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ViewPostPage extends StatefulWidget {
  const ViewPostPage({Key? key}) : super(key: key);

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          color: Colors.blue[300],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[500],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    minimumSize: Size(100, 40),
                  ),
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'), // MOCK DATA, WILL BE CHANGED
                          radius: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        // IMPORTANT: IF THERE IS NO LIMIT TO CHARACTERS OF USERNAME, THIS WILL CREATE PROBLEM BECAUSE OF SPACE
                        '[bengİnB+eştaŞ21#]=', // MOCK DATA, WILL BE CHANGED
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    "Face Numbing and Blurred Vision",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    "I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is ..... I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
