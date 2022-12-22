import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';

class CreateTextAnnotationPage extends StatefulWidget {
  const CreateTextAnnotationPage({Key? key}) : super(key: key);

  @override
  State<CreateTextAnnotationPage> createState() => _CreateTextAnnotationPageState();
}

class _CreateTextAnnotationPageState extends State<CreateTextAnnotationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _body = TextEditingController();

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
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
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
