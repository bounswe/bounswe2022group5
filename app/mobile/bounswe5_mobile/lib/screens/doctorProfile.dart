import 'package:bounswe5_mobile/screens/articles.dart';
import 'package:bounswe5_mobile/screens/posts.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/screens/upvotedArticles.dart';
import 'package:bounswe5_mobile/screens/upvotedPosts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/DoctorProfileWidget.dart';
import '../widgets/ProfileListItem.dart';
import '../widgets/ProfileName.dart';
import '../widgets/ProfileWidget.dart';
import '../screens/comments.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key, required this.profilePicture, required this.fullName, required this.specialization, required this.hospitalName}) : super(key: key);

  final String profilePicture;
  final String fullName;
  final String specialization;
  final String hospitalName;

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  @override
  Widget build(BuildContext  context) {
    bool isMember = false;
    return Scaffold(
      appBar: myAppBar,
      body: Column(
        children: <Widget>[
          const SizedBox(height: 25),
          DoctorProfileWidget(
          profilePicture: widget.profilePicture,
          fullName: widget.fullName,
          specialization: widget.specialization,
          hospitalName: widget.hospitalName
          ),
          const SizedBox(height: 16),
        Column(
            children: [
              Text("Doctor"),
              Text(
                  widget.hospitalName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              ),
              Text(
                widget.fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
              ),
              Text(
                  widget.specialization,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              ),
            ]
        ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

