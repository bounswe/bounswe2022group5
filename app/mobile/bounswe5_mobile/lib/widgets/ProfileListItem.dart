import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/comments.dart';


class ProfileListItem extends StatelessWidget{
  final IconData icon;
  final text;
  final bool hasNavigation;
  final routepage;

  const ProfileListItem({
    Key? key,
    required this.icon,
    this.text,
    this.hasNavigation = true,
    this.routepage,
  }) : super(key: key);
  @override
  Widget build (BuildContext context){
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 40,
      ).copyWith(
          bottom: 20
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).backgroundColor,
      ),

      child: InkWell(
        onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => routepage),
        );}, // Navigate to a page
        child: Row(
          children: <Widget>[
            SizedBox(width: 25),
            Text(
                this.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
            ),
            Spacer(),
            if(this.hasNavigation)
              Icon(
                this.icon,
                size: 25,
              ),
          ],
        ),

      ),
    );
  }
}