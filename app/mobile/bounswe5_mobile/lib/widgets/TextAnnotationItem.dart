import 'package:bounswe5_mobile/API_service.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/textAnnotation.dart';
import 'package:intl/intl.dart';
import 'package:bounswe5_mobile/screens/viewTextAnnotations.dart';

ApiService apiService = ApiService();

class TextAnnotationItem extends StatefulWidget {
  const TextAnnotationItem({Key? key, required this.activeUserToken, required this.type, required this.annotation, required this.id}) : super(key: key);
  final String activeUserToken;
  final String type;
  final TextAnnotation annotation;
  final int id;
  @override
  State<TextAnnotationItem> createState() => _TextAnnotationItemState();
}

class _TextAnnotationItemState extends State<TextAnnotationItem> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.10,),
                  Text(
                    "“"+widget.annotation.selectedText+"”",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  IconButton(onPressed: () async{
                    await apiService.deleteTextAnnotation(widget.activeUserToken, widget.type, widget.annotation.annoId).then(
                      (statusCode) {
                        if(statusCode == 200){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TextAnnotationsList(token: widget.activeUserToken, type: widget.type, id: widget.id,)
                              )
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Successfully deleted annotation."),)
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("An error occurred. Error code: $statusCode"),
                            )
                          );
                        }
                      }
                    );
                  }, icon: Icon(Icons.delete)),
                ],
              ),
              const SizedBox(height: 10,),
              Text(
                widget.annotation.annotationBody,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatter.format(widget.annotation.created),
                  ),
                  Text(
                      "-"+widget.annotation.creatorName
                  )
                ],
              )
            ]
        )
    );
  }
}
