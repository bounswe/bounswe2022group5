import 'package:bounswe5_mobile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/screens/login.dart';

class MyDrawer extends StatelessWidget{
  MyDrawer({required this.color, this.activeUser});
  final Color color;
  final User? activeUser;

  @override
  Widget build(BuildContext context){
    bool isSessionActive = activeUser != null;
    String userName;
    if(isSessionActive){
      if(activeUser!.usertype == "Member"){
        userName = activeUser!.username;
      } else{
        userName = activeUser!.name + " " + activeUser!.surname;
      }
    }else{
      userName = "Please sign in";
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: color
            ),
            child: Column(
              children: [
                InkWell(
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(activeUser!.imagePath),
                  ),
                  onTap: (){
                    if(isSessionActive) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ProfilePage(activeUser: activeUser!)),
                      );
                    }else{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            LoginPage()),
                      );
                    }

                  },
                ),
                const SizedBox(height: 12),
                InkWell(
                  child: Text(
                    userName,
                    style: const TextStyle(
                        fontSize:22.0,
                        fontWeight: FontWeight.bold,
                        color:Colors.white
                    ),
                  ),
                  onTap: (){
                    if(isSessionActive) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ProfilePage(activeUser: activeUser!)),
                      );
                    }else{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            LoginPage()),
                      );
                    }

                  },
                )
              ],
            ),
          ),

          isSessionActive ?
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ): SizedBox.shrink(),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),

          isSessionActive ?
          ListTile(
            // Log out
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>
                    LoginPage()),
              );
            },

          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}