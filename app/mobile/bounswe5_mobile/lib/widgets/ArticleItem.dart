import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/screens/viewArticle.dart';
import 'package:bounswe5_mobile/models/user.dart';

class ArticleItem extends StatelessWidget{
  ArticleItem({required this.activeUser, required this.article});
  final User activeUser;
  final Article article;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewArticlePage(
                    article: article,
                    activeUser: activeUser,
                  )),
        );
        },
      child: Container(
          margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          height: 155,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ]),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(article.header.toUpperCase(),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Dr. " + article.author.fullName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 15.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  formatter.format(article.time),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                size: 30.0,
                              ),
                              Text(article.upvotes.toString())
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                size: 30.0,
                              ),
                              Text(article.downvotes.toString())
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
