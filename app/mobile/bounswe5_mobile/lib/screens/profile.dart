import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../widgets/ProfileName.dart';
import '../widgets/ProfileWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;

  String get token => this.token;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext  context) {
    ApiService apiServer = ApiService();
    return  FutureBuilder<User?>(
        future: apiServer.getUserInfo(widget.token),
        builder: (context,snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [Text(
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

            body: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                ProfileWidget(
                  activeUser: widget.activeUser,
                  tempImagePath: 'lib/assets/images/generic_user.jpg',
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                buildName(widget.activeUser),
                SizedBox(height: 20),
                const ProfileListItem(
                  icon: Icons.arrow_upward,
                  text: 'Upvotes',
                ),
                const ProfileListItem(
                  icon: Icons.post_add_outlined,
                  text: 'Posts',
                ),
                const ProfileListItem(
                  icon: CupertinoIcons.bubble_right,
                  text: 'Comments',
                ),
              ],
            ),
          );
        }
        );
  }
}

