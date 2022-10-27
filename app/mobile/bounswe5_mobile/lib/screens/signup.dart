import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';



bool validateUppercase(String value){
  String  pattern = r'^(?=.*?[A-Z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateLowercase(String value){
  String  pattern = r'^(?=.*?[a-z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateNumber(String value){
  String  pattern = r'^(?=.*?[0-9]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateSpeacialCharacter(String value){
  String  pattern = r'^(?=.*?[!@#\$&*~.]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool isEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

const List<String> list = <String>['Member', 'Doctor'];
const List<String> branches = <String>['Anatomical Pathology', 'Anesthesiology','Cardiology','Hematology', 'Cardiovascular & Thoracic Surgery', 'Clinical Immunology/Allergy', 'Critical Care Medicine'];
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _date = TextEditingController();
  bool isMember = true;
  String _fileText = "";

  @override
  Widget build(BuildContext context) {

    String dropdownValue = list.first;
    String branchValue = branches.first;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:[Text(
                'Logo',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                )
            )],
          ),
          elevation: 0.0,
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Container(
                      color: Colors.white54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.assignment_ind_rounded),
                                border: OutlineInputBorder(),
                                labelText: 'Account type',
                              ),
                              value: dropdownValue,
                              onChanged: (String? value) {
                                if (value! == "Doctor"){
                                  isMember = false;
                                } else {
                                  isMember = true;
                                }
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>> ((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          (!isMember) ?  const SizedBox.shrink() :
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _username,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(),
                                labelText: '*Username',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() :
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _name,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: '*First name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name.';
                                }
                                return null;
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() :
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _surname,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: '*Last name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                                border: OutlineInputBorder(),
                                labelText: '*Email address',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                } else if (!isEmail(value)){
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() :
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.assignment_ind_rounded),
                                border: OutlineInputBorder(),
                                labelText: '*Branch',
                              ),
                              value: branchValue,
                              onChanged: (String? value) {
                                setState(() {
                                  branchValue = value!;
                                });
                              },
                              items: branches.map<DropdownMenuItem<String>> ((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _pass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: '*Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 8) {
                                  return 'Your password should be longer than 8 characters.';
                                } else if (!validateUppercase(value)) {
                                  return 'Your password should contain at least one upper-case character.';
                                } else if (!validateLowercase(value)) {
                                  return 'Your password should contain at least one lower-case character.';
                                }  else if (!validateNumber(value)) {
                                  return 'Your password should contain at least one number.';
                                }  else if (!validateSpeacialCharacter(value)) {
                                  return 'Your password should contain at least one special character.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _confirmPass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: '*Confirm password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password.';
                                } else if (value != _pass.text) {
                                  return 'Passwords do not match.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(
                              controller: _date,
                              decoration: const InputDecoration (
                                prefixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder(),
                                labelText: "*Date of birth",
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1999),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  setState(() {
                                    _date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() :
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: ElevatedButton(
                              onPressed: _pickFile,
                              child: const Text('Document'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    )
                )
            )
        )
    );
  }
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg', 'pdf', 'doc']
    );

    if (result != null && result.files.single.path != null) {
      PlatformFile file = result.files.first;

      File _file = File(result.files.single.path!);
      setState(() {
        _fileText = _file.path;
      });
    } else {
      //user cancelled the picker
    }
  }

}
