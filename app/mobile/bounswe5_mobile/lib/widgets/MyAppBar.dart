import 'package:flutter/material.dart';

PreferredSizeWidget? myAppBar = AppBar(
  centerTitle: true,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Hippocrates',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ))
    ],
  ),
  elevation: 0.0,
);