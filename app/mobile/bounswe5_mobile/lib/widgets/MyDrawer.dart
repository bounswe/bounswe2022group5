import 'package:bounswe5_mobile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/API_service.dart';

/// This is the drawer used in the home page. Using this drawer,
/// a registered user can reach his/her user page, notification center, or settings.
/// A nonregistered user can log in or reach generic settings.
class MyDrawer extends StatelessWidget{
  MyDrawer({required this.color, this.activeUser});
  final ApiService apiServer = ApiService();
  final Color color;
  final User? activeUser;

  /// Function used for logging out
  Future<bool> logout(String token) async {
    final result = await ApiService().logout(token);
    return result;
  }

  // For now, we used a temporary image for our users.
  String tempImagePath = 'lib/assets/images/generic_user.jpg';
  @override
  Widget build(BuildContext context){
    bool isSessionActive = activeUser != null;
    String displayName;

    // While session is active, username or name will be displayed.
    // If not, a "sign in" text is showed.
    if(isSessionActive){
      displayName = "John";
    }else{
      displayName = "Please sign in";
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: color,
            ),

            child: Column(
              children: [
                InkWell(
                  // Profile image
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: AssetImage(tempImagePath),
                  ),
                  onTap: (){
                    // If session is active, user is directed to the profile page
                    // when he/she click on profile image. If not, directed to the
                    // log in page.
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
                  // Name displayed in the drawer
                  child: Text(
                    displayName,
                    style: const TextStyle(
                        fontSize:22.0,
                        fontWeight: FontWeight.bold,
                        color:Colors.white
                    ),
                  ),
                  onTap: (){
                    // If session is active, user is directed to the profile page
                    // when he/she click on his/her name. If not, directed to the
                    // log in page
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

          // If session is active, notifications section is shown.
          isSessionActive ?
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Later, he/she will be directed to the notifications page.
              Navigator.pop(context);
            },
          ): SizedBox.shrink(),

          // Settings section:
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // If session is active, a log out button is shown.
          isSessionActive ?
          ListTile(
            // Log out
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              // Log out logic is implemented here.
              final navigator = Navigator.of(context);
              bool loggedout = await logout(activeUser!.token);
              if(loggedout) {
                // After successfully logging out, switch to the login page.
                navigator.pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage())
                );
              } else{
                // There can be a problem: // THINK ABOUT THIS SECTION
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: const Text('Error'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('Couldn\'t log out.'),
                            ],
                          ),
                        ),
                      );
                    }
                );
              }
            },

          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}