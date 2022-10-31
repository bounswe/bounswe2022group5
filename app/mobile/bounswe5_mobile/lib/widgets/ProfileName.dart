import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
Widget buildName(User user) => Column(
    children: [
      Text(
          (user.usertype == 1) ?
          "Doctor":"Member"
      ),
      Text(
          user.email,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ]
);