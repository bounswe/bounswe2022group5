import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

class imagesGrid extends StatelessWidget {
  const imagesGrid({required this.urls, Key? key}) : super(key: key);
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: urls.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Image.network(urls[index])),
              );
            }
        ),
      );
  }
}
