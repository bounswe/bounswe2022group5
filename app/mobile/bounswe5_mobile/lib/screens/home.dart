import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/widgets/MyDrawer.dart';
import 'package:bounswe5_mobile/widgets/ForumList.dart';
import 'package:bounswe5_mobile/widgets/ArticlesList.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/mockData.dart';
import 'package:bounswe5_mobile/screens/createPost.dart';
import 'package:bounswe5_mobile/screens/createArticle.dart';
import 'package:bounswe5_mobile/screens/postOverviewScreen.dart';
import 'package:bounswe5_mobile/screens/articleOverviewScreen.dart';
import 'package:bounswe5_mobile/screens/searchPage.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/article.dart';

/// This is the implementation of the home page.
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.token, required this.index}) : super(key: key);
  final String token;
  var index;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// currentIndex is for keeping home page status.
  /// 0 for forum, 1 for articles, 2 for chatbot (not implemented yet.)

  @override
  Widget build(BuildContext context) {
    ApiService apiServer = ApiService();
    //int currentIndex = widget.index;


    return FutureBuilder<User?>(
      future: apiServer.getUserInfo(widget.token),
      builder: (context,snapshot){

        // If widget token is -1, that means a non registered user
        // entered the home page. If snapshot has data, that means
        // a registered user entered the home page. In both cases
        // we should show the home page. Until that time, a loading
        // icon is shown.

        if( (snapshot.hasData || widget.token == '-1') && snapshot.data != null){

          dynamic result = snapshot.data;

          User activeUser = result ?? User(-1, '-1', '-1', -1);

          /*
          int numberOfPosts = result[1];
          List<Post> posts = result[2];
          int numberOfArticles = result[3];
          List<Article> articles = result[4];

           */


          /// Forum, Articles and Chatbot bodies.
          List<Widget> bodies = [
            PostsOverviewScreen(activeUser: activeUser,),
            ArticlesOverviewScreen(activeUser: activeUser,),
          ];

          // Session activity means that a registered user is entered
          // the home page.
          bool isSessionActive = widget.token != '-1';

          // Floating button that will be used to create posts/articles:
          Widget floatingButton = SizedBox.shrink();
          if (isSessionActive) {
            if (widget.index == 0) {
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
            } else if (widget.index == 1) {
              print(activeUser.specialization);
              if (activeUser.usertype == 1) {
                floatingButton = FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(builder: (context) =>
                            CreateArticlePage(activeUser: activeUser)),

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
                    'Hippocrates',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              elevation: 0.0,
              actions: <Widget>[
                // This will implement search functionality later:
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchPage(token: widget.token)),
                    );
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30.0,
                )
              ],
            ),

            // Side bar
            drawer: MyDrawer(activeUser: activeUser,),

            // Bottom navigation bar is used for switching between forum, articles and
            // chatbot.
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: widget.index,
              onTap: (index) => setState(() => widget.index = index),
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

            body: bodies[widget.index],
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


/*
class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    ApiService apiServer = ApiService();

    return FutureBuilder<dynamic>(
      future: apiServer.getSingleArticle(widget.token, 17),
      builder: (context,snapshot){
        return Container();
      },
    );

  }
}
*/