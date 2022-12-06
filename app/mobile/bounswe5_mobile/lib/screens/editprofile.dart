import 'package:bounswe5_mobile/models/memberInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/ProfileListItem.dart';
import '../screens/profile.dart';
import '../widgets/ProfileWidget.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final myController = TextEditingController();
  Future<int> changeUserInfo(User user, String name) async { //register API call handling function
    final result = await ApiService().updateUserInfo(user, name);
    return result;
  }
  Future<int> changeHospitalName(String token, String hospitalName) async { //register API call handling function
    final result = await ApiService().changeHospitalName(token, hospitalName);
    return result;
  }
  Future<int?> getAvatar(String token) async { //register API call handling function
    final result = await ApiService().getAvatar(token);
    return result;
  }
  Future<int> changeAvatar(String token, int avatar) async { //register API call handling function
    int result = await ApiService().changeAvatar(token, avatar);
    return result;
  }
  @override
  Widget build(BuildContext context) {
    Future<String>? futureObject;
    ApiService apiServer = ApiService();
    bool isMember = false;
    String imagePath;
    Future<int?> userAvatar = apiServer.getAvatar(widget.activeUser.token);
    Widget pp;
    String tempImagePath = 'lib/assets/images/generic_user.jpg';
    if(widget.activeUser!.profileImageUrl == null){
      pp = Image.asset(tempImagePath);
    }
    else if(widget.activeUser!.usertype == 1){
      pp = Image.network(widget.activeUser!.profileImageUrl!);
    }
    else{
      pp = SvgPicture.network(widget.activeUser!.profileImageUrl!);
    }
    if (widget.activeUser.usertype == 2){
      isMember = true;
    }
    return Scaffold(
      appBar: myAppBar,
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              isMember?
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pp = SvgPicture.network(widget.activeUser!.profileImageUrl!);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/1.png"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 2);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/2.png"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 3);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/3.png"),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 4);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/4.png"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 5);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/5.png"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 6);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/6.png"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 7);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/7.png"),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 8);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/8.png"),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            changeAvatar(widget.activeUser.token, 9);
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://api.multiavatar.com/9.png"),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ):
              CircleAvatar(
                  radius: 100.0,
                  child: ClipOval(
                    child: pp,
                  )
              ),
              const SizedBox(height: 25),
              TextField(
                decoration: InputDecoration(
                  labelText: isMember? "Username": "Hospital Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: isMember? widget.activeUser.username:widget.activeUser.hospitalName,
                ),
                controller: myController,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 2.2
                        ),
                      )
                  ),
                  const SizedBox(width: 25),
                  ElevatedButton(
                      onPressed: () async {
                        int changed;
                        changed = await changeUserInfo(widget.activeUser, myController.text );
                        if(isMember){
                          setState(() {
                          widget.activeUser.username = myController.text;
                        });}
                        else{
                          setState(() {
                            widget.activeUser.hospitalName = myController.text;
                          });
                        }
                        if (changed == 200) {
                          Navigator.pop(context);
                        }
                        else {
                          print(changed);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not changed')),
                          );
                        }},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green, // Text Color
                      ),
                      child: const Text("SUBMIT",
                        style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 2.2,
                            color: Colors.white
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}