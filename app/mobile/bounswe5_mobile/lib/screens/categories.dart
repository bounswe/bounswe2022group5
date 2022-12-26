// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      body: ListView(children: [
        CategoryItem(name: "name", isFollowed: false)
      ]),
    );
  }
}

class CategoryItem extends StatelessWidget{

  CategoryItem({required this.name, required this.isFollowed});
  final String name;
  final bool isFollowed;

  @override
  Widget build(BuildContext context){

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: EdgeInsets.all(2),
      height: 45,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 2),
              Column(children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.green,
                  )
                ],
              ),
              SizedBox(
                width: 2,
              )
            ],
          ),
        ],
      ),
    );
  }

}
