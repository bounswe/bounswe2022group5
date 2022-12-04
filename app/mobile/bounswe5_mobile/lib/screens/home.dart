import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/widgets/MyDrawer.dart';
import 'package:bounswe5_mobile/widgets/ForumList.dart';
import 'package:bounswe5_mobile/widgets/ArticlesList.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/screens/createPost.dart';
import 'package:bounswe5_mobile/screens/createArticle.dart';
import 'package:bounswe5_mobile/screens/viewPost.dart';
import 'package:bounswe5_mobile/screens/viewArticle.dart';

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
    ApiService apiServer = ApiService();

    return FutureBuilder<User?>(
      future: apiServer.getUserInfo(widget.token),

      builder: (context,snapshot){

        // If widget token is -1, that means a non registered user
        // entered the home page. If snapshot has data, that means
        // a registered user entered the home page. In both cases
        // we should show the home page. Until that time, a loading
        // icon is shown.
        if (snapshot.hasData || widget.token == '-1') {
          print(snapshot.data);
          User activeUser = snapshot.data ?? User(-1, '-1', '-1', -1);

          /// Forum, Articles and Chatbot bodies.
          List<Widget> bodies = [
            ForumList(
              activeUser: activeUser,
              posts: posts,
            ),
            ArticlesList(
              activeUser: activeUser,
              articles: articles,
            )
          ];

          // Session activity means that a registered user is entered
          // the home page.
          bool isSessionActive = widget.token != '-1';

          print(widget.token);

          print(isSessionActive);

          // Floating button that will be used to create posts/articles:
          Widget floatingButton = SizedBox.shrink();
          if (isSessionActive) {
            if (currentIndex == 0) {
              floatingButton = FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreatePostPage(activeUser: activeUser)),
                    );
                    print("User create post");
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.create,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ));
            } else if (currentIndex == 1) {
              print(activeUser.specialization);
              if (activeUser.usertype == 1) {
                floatingButton = FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateArticlePage(activeUser: snapshot.data!)),
                      );
                      print("Doctor create article");
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.create,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ));
              }
            }
          } else {
            floatingButton = const SizedBox.shrink();
          }
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
                    )),
              ),
              elevation: 0.0,
              actions: <Widget>[
                // This will implement search functionality later:
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  iconSize: 30.0,
                )
              ],
            ),

            // Side bar
            drawer: MyDrawer(
              activeUser: snapshot.data,
            ),

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
                    icon: Icon(Icons.library_books), label: 'Articles'),
              ],
            ),

            // floating action button will be used for creating a new post or article later.
            floatingActionButton:
                floatingButton, // If user not signed in, do not show create post button in the forum

            /*
            isSessionActive && currentIndex == 0 ?
            FloatingActionButton(
              onPressed: (){},
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                  Icons.create,
                  color: Theme.of(context).colorScheme.onPrimary,
              ),
            ) : const SizedBox.shrink(),
            */
            body: bodies[currentIndex],
          );
        }
        // Show a loading icon until the user data is loaded.
        else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
