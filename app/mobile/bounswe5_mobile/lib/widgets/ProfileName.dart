import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
Widget buildName(User user) => Column(
    children: [
      user.id == null?
      SizedBox.shrink():
      Text(
        user.id.toString()
      ),
      user.usertype == null?
      SizedBox.shrink():
      Text(
          (user.usertype == 1) ?
          "Doctor":"Member"
      ),
      Text(
          (user.usertype == 1 && user.hospitalName != null)?
          user.hospitalName:
          (user.email != null? user.email: ""),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
      ),
      Text(
          (user.usertype == 1 && user.fullName != null)?
          user.fullName:
          (user.username != null? user.username: ""),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    ]
);