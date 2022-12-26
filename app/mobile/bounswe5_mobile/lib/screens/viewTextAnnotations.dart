import 'package:bounswe5_mobile/models/textAnnotation.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/widgets/TextAnnotationItem.dart';

class TextAnnotationsList extends StatefulWidget {
  const TextAnnotationsList({Key? key, required this.token, required this.type, required this.id}) : super(key: key);
  final String token;
  final String type; // "POST" or "ARTICLE"
  final int id; // id of the post or article
  @override
  State<TextAnnotationsList> createState() => _TextAnnotationsListState();
}

class _TextAnnotationsListState extends State<TextAnnotationsList> {
  @override
  Widget build(BuildContext context) {

    ApiService apiService = ApiService();

    return FutureBuilder<List<TextAnnotation>>(
        future: apiService.getTextAnnotations(widget.token, widget.type, widget.id),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<TextAnnotation> annos = snapshot.data!;

            return Scaffold(
              appBar: myAppBar,
              body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: annos.length+1,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0){
                    return Column(
                      children: [
                        Text(
                          "Text Annotations",
                          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                        ),
                        annos.isEmpty ?
                            const Text(
                              "No annotations yet.",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ):
                            const SizedBox.shrink(),
                      ],
                    );
                  }

                  final annotation = annos[index-1];

                  return TextAnnotationItem(annotation: annotation);
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            );
          }
          else{
            return Scaffold(
              appBar: myAppBar,
              body: const Center(child: CircularProgressIndicator()),
            );
          }

        }
    );
  }
}
