import 'package:bounswe5_mobile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/API_service.dart';

class MyDrawer extends StatelessWidget{
  MyDrawer({required this.color, this.activeUser});
  final Color color;
  final User? activeUser;

  String tempImagePath = 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E';

  @override
  Widget build(BuildContext context){
    bool isSessionActive = activeUser != null;
    String userName;
    if(isSessionActive){
      userName = activeUser!.email;
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
                    backgroundImage: NetworkImage(tempImagePath),
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