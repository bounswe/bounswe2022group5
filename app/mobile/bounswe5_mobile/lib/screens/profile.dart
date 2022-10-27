import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:pubspec/pubspec.dart';
import 'package:random_avatar/random_avatar.dart';

import '../widgets/appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ProfileWidget extends StatelessWidget{
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }
  Widget buildImage(){
    final image = NetworkImage("oguzhan.imagePath");

    return ClipOval(
      child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(
                onTap: onClicked
            ),
          )
      ),
    );
  }
  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 2,
    child: buildCircle(
      color: color,
      all: 8,
      child: InkWell(
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
        onTap: (){},
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

class ProfileListItem extends StatelessWidget{
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);
  @override
  Widget build (BuildContext context){
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 40,
      ).copyWith(
          bottom: 20
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 25),
          Text(
              this.text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
          ),
          Spacer(),
          if(this.hasNavigation)
            Icon(
              this.icon,
              size: 25,
            ),
        ],
      ),
    );
  }
}


class _ProfilePageState extends State<ProfilePage> {
  int currentIndex=0;
  bool isMember = true;
  @override
  Widget build(BuildContext  context) {
    final user = oguzhan;
    if(user.usertype == "Doctor"){
      isMember = false;
    }
    else{
      isMember = true;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:[Text(
              'Logo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )
          )],
        ),
        elevation: 0.0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath:user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),


        ],
      ),
      floatingActionButton:Expanded(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 450),
            ProfileListItem(
              icon: Icons.arrow_upward,
              text: 'Upvotes',
            ),
            ProfileListItem(
              icon: Icons.post_add_outlined,
              text: 'Posts',
            ),ProfileListItem(
              icon: CupertinoIcons.bubble_right,
              text: 'Comments',
            ),
          ],
        ),
      ),



      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Articles'
          ),
        ],
      ),

    );

  }

  Widget buildName(User user) => Column(
      children: [
        Text(
            user.usertype
        ),
        Text(
            (!isMember) ?
            user.username: user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        )
      ]
  );
}



git config user.name <your user name>
