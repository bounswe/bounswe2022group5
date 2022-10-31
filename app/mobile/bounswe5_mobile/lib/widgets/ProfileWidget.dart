import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';

class ProfileWidget extends StatelessWidget{
  final String tempImagePath;
  final VoidCallback onClicked;
  final User activeUser;

  const ProfileWidget({
    Key? key,
    required this.activeUser,
    required this.tempImagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }
  Widget buildImage(){
    final image = NetworkImage(tempImagePath);
    return ClipOval(
      child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(
                onTap: onClicked
            ),
          )
      ),
    );
  }
  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 2,
    child: buildCircle(
      color: color,
      all: 8,
      child: InkWell(
        child:const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
        onTap: (){},
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

}