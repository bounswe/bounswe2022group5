import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/widgets/ArticleItem.dart';
import 'package:intl/intl.dart';

class ArticlesList extends StatelessWidget{
  ArticlesList({required this.articles});
  final List<Article> articles;

  @override
  Widget build(BuildContext context){
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articles[index];
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        return ArticleItem(index: index, article: article, formatter: formatter);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}