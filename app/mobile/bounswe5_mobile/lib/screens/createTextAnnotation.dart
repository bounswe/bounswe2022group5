import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/textAnnotation.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/models/user.dart';

class CreateTextAnnotationPage extends StatefulWidget {
  const CreateTextAnnotationPage({Key? key, required this.type, required this.id, required this.start, required this.end, required User this.activeUser, required String this.selectedText}) : super(key: key);

  final String type;
  final int id; // id of the post or article
  final int start;
  final int end;
  final User activeUser;
  final String selectedText;

  @override
  State<CreateTextAnnotationPage> createState() => _CreateTextAnnotationPageState();
}

class _CreateTextAnnotationPageState extends State<CreateTextAnnotationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _body = TextEditingController();
  ApiService apiService = ApiService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: Container(
        padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Annotated text: ",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: "\""+ widget.selectedText +"\"",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )
                        )
                      ]
                    )

                  ),
                ),
              ),
              const SizedBox(height:10),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: _body,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {

                      var creatorName = widget.activeUser.usertype == 1 ? widget.activeUser.fullName : widget.activeUser.username;

                      TextAnnotation anno = TextAnnotation(DateTime.now(), widget.activeUser.id, creatorName, _body.text, widget.selectedText, widget.start, widget.end);

                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        apiService.createTextAnnotation(widget.activeUser.token, widget.type, widget.id, anno).then(
                          (statusCode) {
                            if(statusCode == 200){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Successfully Created Annotation')),
                              );
                              Navigator.pop(context);
                            } else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('An error occurred. Error code: $statusCode')),
                              );
                            }
                          }
                        );
                        
                      }
                    },
                    child: const Text('Create Annotation'),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
