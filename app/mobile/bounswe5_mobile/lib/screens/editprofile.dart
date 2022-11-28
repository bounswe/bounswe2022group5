import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../screens/profile.dart';
import '../widgets/ProfileWidget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [Text(
              'Logo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )
          )
          ],
        ),
        elevation: 0.0,
      ),
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
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 175,
                        height: 175,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('lib/assets/images/generic_user.jpg')
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    children: [
                                      const SizedBox(height: 40),
                                      Dialog(
                                        child: Ink.image(
                                          image: AssetImage('lib/assets/images/generic_user.jpg'),
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/oguzhan.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/halil.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/kardelen.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/bengin.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/emre.png"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/canberk.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/irfan.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/samet.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/kerem.png"),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              //do what you want here
                                            },
                                            child: const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage("https://api.multiavatar.com/burak.png"),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 25),
              const TextField(
                decoration: InputDecoration(
                  labelText: "username",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "oguzhansnl",
                ),
              ),
                const SizedBox(height: 25),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Mail",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "oguzhansnl@mail.com",
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: (){},
                        child: const Text("CANCEL",
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 2.2
                        ),
                        )
                    ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                        onPressed: (){},
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