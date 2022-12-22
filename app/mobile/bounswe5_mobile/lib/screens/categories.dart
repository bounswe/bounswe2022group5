import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key, required User this.activeUser})
      : super(key: key);
  final User activeUser;
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
    );
  }
}
