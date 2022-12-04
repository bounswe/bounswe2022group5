import 'package:bounswe5_mobile/screens/editprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:flutter_svg/svg.dart';

class ProfileWidget extends StatelessWidget{

  final VoidCallback onClicked;
  final User activeUser;

  const ProfileWidget({
    Key? key,
    required this.activeUser,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color, context),
          ),
        ],
      ),
    );
  }
  Widget buildImage(BuildContext context){
    Widget pp;
    String tempImagePath = 'lib/assets/images/generic_user.jpg';
    if(activeUser!.profileImageUrl == null){
      pp = Image.asset(tempImagePath);
    }
    else if(activeUser!.usertype == 1){
      pp = Image.network(activeUser!.profileImageUrl!);
    }
    else{
      pp = SvgPicture.network(activeUser!.profileImageUrl!);
    }
    return CircleAvatar(
      radius: 100.0,
      child: ClipOval(
        child: pp,
)
);
  }
  Widget buildEditIcon(Color color, BuildContext context) => buildCircle(
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
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                EditProfilePage(activeUser: activeUser!)),
          );
          },
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