import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/screens/viewPost.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';

/// A single post item shown in the Forum.
class ForumPostItem extends StatelessWidget{
  ForumPostItem({required this.activeUser, required this.post});
  final User activeUser;
  final Post post;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              ViewPostPage(activeUser: activeUser, post: post)),
        );
        },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
        height: 120,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    post.header,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 5.0,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child:

                  Text(
                    _parseHtmlString(post.body),
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: post.isDoctorReplied ? 2 : 3,
                  ),


                ),
                const SizedBox(height: 5.0,),
                // If doctor replied to a post, a banner is showed:
                post.isDoctorReplied ?
                Row(
                  children: const [
                    Icon(Icons.check_circle_outline,size: 18.0,),
                    SizedBox(width: 5.0,),
                    Text(
                        'Commented by doctors.'
                    ),
                  ],
                ) : const SizedBox.shrink(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatter.format(post.time),
                ),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: post.voteOfActiveUser == "upvote" ? Colors.green : Colors.black,
                          size: 30.0,
                        ),
                        Text(
                            post.upvotes.toString()
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: post.voteOfActiveUser == "downvote" ? Colors.red : Colors.black,
                          size: 30.0,
                        ),
                        Text(
                            post.downvotes.toString()
                        )
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

String _parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

