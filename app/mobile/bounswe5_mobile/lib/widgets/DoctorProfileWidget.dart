import 'package:bounswe5_mobile/screens/editprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:flutter_svg/svg.dart';

class DoctorProfileWidget extends StatelessWidget{

  final String profilePicture;
  final String fullName;
  final String specialization;
  final String hospitalName;


  const DoctorProfileWidget({
    Key? key,
    required this.profilePicture,
    required this.fullName,
    required this.specialization,
    required this.hospitalName
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(context),
        ],
      ),
    );
  }
  Widget buildImage(BuildContext context){
    Widget pp;
    String tempImagePath = 'lib/assets/images/generic_user.jpg';
    if(profilePicture == null){
      pp = Image.asset(tempImagePath);
    }
    else{
      pp = Image.network(
        profilePicture, // this image doesn't exist
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(tempImagePath);
        },
      );
    }
    return CircleAvatar(
        radius: 100.0,
        child: ClipOval(
          child: pp,
        )
    );
  }

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