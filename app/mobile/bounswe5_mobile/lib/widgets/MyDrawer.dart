import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';

class MyDrawer extends StatelessWidget{
  MyDrawer({required this.color, this.activeUser});
  final Color color;
  final User? activeUser;

  @override
  Widget build(BuildContext context){
    bool isSessionActive = activeUser != null;
    String userName = isSessionActive ? (activeUser!.name + " " + activeUser!.surname) : "Sign in";
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: color
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: const TextStyle(
                        fontSize:22.0,
                        fontWeight: FontWeight.bold,
                        color:Colors.white
                    ),
                  )
                ],
              ),
            ),
            onTap: (){},
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
        ],
      ),
    );
  }
}