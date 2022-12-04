import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/widgets/ArticleItem.dart';
import 'package:bounswe5_mobile/models/user.dart';

// Active user may be empty don't forget
class ArticlesList extends StatelessWidget {
  ArticlesList({required this.activeUser, required this.articles});
  final User activeUser;
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articles[index];
        return ArticleItem(
            activeUser: activeUser, index: index, article: article);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
