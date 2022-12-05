import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
Widget buildName(User user) => Column(
    children: [
      Text(
        user.id.toString()
      ),
      Text(
          (user.usertype == 1) ?
          "Doctor":"Member"
      ),
      Text(
          user.email,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
      ),
      Text(
          (user.usertype == 1) ?
          user.fullName:user.username,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    ]
);