import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:intl/intl.dart';

class ForumPostItem extends StatelessWidget{
  ForumPostItem({required this.index, required this.post, required this.formatter});
  final int index;
  final Post post;
  final DateFormat formatter;

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){print("$index tapped.");},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
        height: 120,
        decoration: const BoxDecoration(
            color: Colors.white54,
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
                  child: Text(
                    post.body,
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
                        InkWell(
                          onTap: (){print('upvoted $index');},
                          child: const Icon(
                            Icons.arrow_upward,
                            size: 30.0,
                          ),
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
                        InkWell(
                          onTap: (){print('downvoted $index');},
                          child: const Icon(
                            Icons.arrow_downward,
                            size: 30.0,
                          ),
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

