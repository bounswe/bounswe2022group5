import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/widgets/MyDrawer.dart';
import 'package:bounswe5_mobile/widgets/ForumList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    Color mainColor = const Color(0xFF1565C0);
    var height = MediaQuery.of(context).size.height;
    User activeUser = posts[0].sender; // To be changed
    bool isSessionActive = true; // To be changed
    List<Widget> bodies = [ForumList(posts: posts,), Container(), Container()];

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
              'Logo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
            iconSize: 30.0,

          )
        ],
      ),

      drawer: MyDrawer(color: mainColor, activeUser: activeUser,),

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

      floatingActionButton: // If user not signed in, do not show create post button in the forum
      isSessionActive && currentIndex == 0 ?
      FloatingActionButton(
        onPressed: (){},
        backgroundColor: mainColor,
        child: const Icon(Icons.create),
      ) : const SizedBox.shrink(),

      body: bodies[currentIndex],
    );
  }
}
