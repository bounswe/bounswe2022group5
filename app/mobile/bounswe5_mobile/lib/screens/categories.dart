// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/models/category.dart';


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
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          return CategoryItem(category: categories[index],);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),

    );
  }
}


class CategoryItem extends StatefulWidget {
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool? isFollowed;

  @override
  void initState() {
    super.initState();
    isFollowed = widget.category.isFollowed;
  }

  @override
  Widget build(BuildContext context){
    String name = widget.category.name;

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.all(Radius.circular(5),
          )
      ),
      height: 60,
      margin: EdgeInsets.all(2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          isFollowed! ?
          TextButton(
              onPressed: (){
                setState(() {
                  isFollowed = !(isFollowed!);
                });
              },
              child: Text("Followed"),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              )
          ) : TextButton(
            onPressed: (){
              setState(() {
                isFollowed = !(isFollowed!);
              });
            },
            child: Text("Follow"),
          ),
          /*
          Icon(
            Icons.check,
            size: 30,
            color: Colors.green,
          ),

           */
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}


