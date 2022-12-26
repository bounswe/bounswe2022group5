import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/textAnnotation.dart';
import 'package:intl/intl.dart';


const String str = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sit amet ex gravida, placerat nunc et, bibendum mi. Fusce finibus sem sit amet lobortis molestie. Nunc posuere pharetra diam non scelerisque. In quis lectus ut orci convallis ullamcorper. In auctor augue nunc, vel placerat felis luctus ac. Quisque porta ac tellus vitae pellentesque. In molestie tortor vitae lectus sagittis dignissim. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam egestas ut est sed dapibus. Sed et justo id mauris malesuada scelerisque quis vel erat. Vivamus vitae pharetra nulla, quis tincidunt velit. Pellentesque id odio eget lorem dapibus fringilla ac eget massa. Nullam luctus ut sapien quis iaculis.";


class TextAnnotationItem extends StatelessWidget {
  TextAnnotationItem({Key? key, required this.annotation}) : super(key: key);
  final TextAnnotation annotation;
  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ]
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "“"+annotation.selectedText+"”",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            annotation.annotationBody,
            style: TextStyle(
                fontSize: 18,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatter.format(annotation.created),
              ),
              Text(
                  "-"+annotation.creatorName
              )
            ],
          )
        ]
      )
    );
  }
}
