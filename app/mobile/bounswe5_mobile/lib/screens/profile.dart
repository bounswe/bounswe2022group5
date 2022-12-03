import 'package:bounswe5_mobile/screens/posts.dart';
import 'package:bounswe5_mobile/screens/upvotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/API_service.dart';
import '../widgets/ProfileListItem.dart';
import '../widgets/ProfileName.dart';
import '../widgets/ProfileWidget.dart';
import '../screens/comments.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext  context) {
    ApiService apiServer = ApiService();
    return  FutureBuilder<User?>(
        future: apiServer.getUserInfo(widget.activeUser.token),
        builder: (context,snapshot) {
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
                  routepage: UpvotesPage(),
                ),
                const ProfileListItem(
                  icon: Icons.post_add_outlined,
                  text: 'Posts',
                  routepage: PostsPage(),
                ),
                const ProfileListItem(
                  icon: CupertinoIcons.bubble_right,
                  text: 'Comments',
                  routepage: CommentsPage(),
                ),
              ],
            ),
          );
        }
        );
  }
}

