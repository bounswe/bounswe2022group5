import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:bounswe5_mobile/API_service.dart';


bool validateUppercase(String value){ //validator for uppercase character in password
  String  pattern = r'^(?=.*?[A-Z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateLowercase(String value){ //validator for lowercase character in password
  String  pattern = r'^(?=.*?[a-z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateNumber(String value){ //validator for number in password
  String  pattern = r'^(?=.*?[0-9]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateSpecialCharacter(String value){ //validator for special character in password
  String  pattern = r'^(?=.*?[!@#\$&*~.]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool isEmail(String em) { //validator for email
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}


const List<String> list = <String>['Member', 'Doctor'];
const List<String> branches= <String>["Anatomical Pathology","Anesthesiology",'Cardiology',"Cardiovascular-Thoracic Surgery", "Clinical Immunology-Allergy",
  "Critical Care Medicine", "Dermatology","Diagnostic Radiology", "Emergency Medicine","Endocrinology and Metabolism","Family Medicine",
  "Gastroenterology", "General Internal Medicine", "General Surgery", "General-Clinical Pathology","Geriatric Medicine",
  "Hematology","Medical Biochemistry","Medical Genetics","Medical Microbiology and Infectious Diseases",
  "Medical Oncology","Nephrology","Neurology","Neurosurgery", "Nuclear Medicine","Obstetrics-Gynecology",
  "Occupational Medicine","Ophthalmology","Orthopedic Surgery","Otolaryngology","Pediatrics","Physical Medicine and Rehabilitation (PM & R)",
  "Plastic Surgery","Psychiatry","Public Health and Preventive Medicine","Radiation Oncology","Respirology",
  "Rheumatology","Urology"];
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
  FilePickerResult? fileResult = null;
  bool isMember = true;
  String _fileText = "";

  Future<int> registerMember(String email, String password, int type, String date_of_birth, String username) async { //register API call handling function
    final result = await ApiService().memberSignUp(email, password, type, date_of_birth, username);
    return result;
  }

  Future<int> registerDoctor(String email, String password, String type, String date_of_birth, String firstname, String lastname, String branch, File doc) async { //register API call handling function
    final result = await ApiService().doctorSignUp(email, password, type, date_of_birth, firstname, lastname, branch, doc);
    return result;
  }

  @override
  Widget build(BuildContext context) {

    String dropdownValue = list.first;
    String branchValue = branches.first;
    return Scaffold(
        appBar: myAppBar,
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
                            child: DropdownButtonFormField<String>( //account type field
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
                          (!isMember) ?  const SizedBox.shrink() : //if doctor, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //username field
                              controller: _username,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(),
                                labelText: '*Username',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //name field
                              controller: _name,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: '*First name',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name.';
                                }
                                return null;
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //surname field
                              controller: _surname,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: '*Last name',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //email field
                              controller: _email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                                border: OutlineInputBorder(),
                                labelText: '*Email address',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                } else if (!isEmail(value)){
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
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
                            child: TextFormField(  //password field
                              controller: _pass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: '*Password',
                              ),
                              validator: (value) { //validate
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
                                }  else if (!validateSpecialCharacter(value)) {
                                  return 'Your password should contain at least one special character.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //confirm password field
                              controller: _confirmPass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: '*Confirm password',
                              ),
                              validator: (value) { //validate
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
                            child: TextFormField( //date of birth field
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
                                    _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ),
                          isMember ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: ElevatedButton( //document upload button
                              child: Text("Document Upload"),
                              onPressed: () async {
                                fileResult = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'pdf', 'doc'],
                                );
                              },
                            ),
                          ),
                          (isMember || fileResult == null)? const SizedBox.shrink() :
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 15.0, 5.0, 10.0, 10.0),
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                  text: "Document uploaded ✅",
                                  style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.grey)
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  int type;
                                  String date_of_birth = _date.text;
                                  if (isMember) {
                                    type = 2;
                                  } else {
                                    type = 1;
                                  }
                                  int registered = 0;
                                  if (isMember) {
                                    registered = await registerMember(_email.text, _pass.text, type, date_of_birth, _username.text);
                                  } else {
                                    if(fileResult == null) {
                                      registered = 0;
                                    } else {
                                      //File file = File(fileResult!.names[0]!);
                                      List<File> files = fileResult!.paths.map((path) => File(path!)).toList();
                                      File doc = files[0];
                                      registered = await registerDoctor(_email.text, _pass.text, type.toString() , date_of_birth, _name.text, _surname.text, branchValue, doc);
                                    }
                                  }
                                  if (registered == 200) { //if registered successfully, go to the login page
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Could not register')),
                                    );
                                  }
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB( 50.0, 20.0, 10.0, 10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text: "By creating an account, you are agreeing to our\n",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                  ]
                              ),
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

}
