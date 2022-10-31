import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/widgets/MyDrawer.dart';
import 'package:bounswe5_mobile/widgets/ForumList.dart';
import 'package:bounswe5_mobile/API_service.dart';

/// This is the implementation of the home page.
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.token}) : super(key: key);
  final String token;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// currentIndex is for keeping home page status.
  /// 0 for forum, 1 for articles, 2 for chatbot (not implemented yet.)
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    Color mainColor = const Color(0xFF1565C0);

    ApiService apiServer = ApiService();

    /// Forum, Articles and Chatbot bodies.
    List<Widget> bodies = [ForumList(posts: posts,), Container()];

    return FutureBuilder<User?>(
      future: apiServer.getUserInfo(widget.token),
      builder: (context,snapshot){

        // If widget token is -1, that means a non registered user
        // entered the home page. If snapshot has data, that means
        // a registered user entered the home page. In both cases
        // we should show the home page. Until that time, a loading
        // icon is shown.
        if(snapshot.hasData || widget.token == '-1'){

          // Session activity means that a registered user is entered
          // the home page.
          bool isSessionActive = widget.token != '-1';
          return Scaffold(

            // App bar is the top bar shown in the screen.
            appBar: AppBar(
              title: const Center(
                child: Text(
                  // We do not have a logo yet. When we decided on that, we can add a logo here:
                    'Logo',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
              elevation: 0.0,
              actions: <Widget>[
                // This will implement search functionality later:
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.search),
                  iconSize: 30.0,

                )
              ],
            ),

            // Side bar
            drawer: MyDrawer(color: mainColor, activeUser: snapshot.data,),

            // Bottom navigation bar is used for switching between forum, articles and
            // chatbot.
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.bubble_chart),
                  label: 'Forum',
                ),
                // For now, no chatbot implementation is available.
                /*
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: 'Chatbot',
                ),
                */
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books),
                    label: 'Articles'
                ),
              ],
            ),

            // floating action button will be used for creating a new post or article later.
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
        // Show a loading icon until the user data is loaded.
        else{
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );

  }
}
