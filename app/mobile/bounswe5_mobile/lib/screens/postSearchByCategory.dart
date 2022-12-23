import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/screens/searchPost.dart';
import 'package:bounswe5_mobile/screens/searchArticle.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/screens/postSearchResults.dart';

const List<String> categories = <String>["Anatomical Pathology","Anesthesiology",'Cardiology',"Cardiovascular-Thoracic Surgery", "Clinical Immunology-Allergy",
  "Critical Care Medicine", "Dermatology","Diagnostic Radiology", "Emergency Medicine","Endocrinology and Metabolism","Family Medicine",
  "Gastroenterology", "General Internal Medicine", "General Surgery", "General-Clinical Pathology","Geriatric Medicine",
  "Hematology","Medical Biochemistry","Medical Genetics","Medical Microbiology and Infectious Diseases",
  "Medical Oncology","Nephrology","Neurology","Neurosurgery", "Nuclear Medicine","Obstetrics-Gynecology",
  "Occupational Medicine","Ophthalmology","Orthopedic Surgery","Otolaryngology","Pediatrics","Physical Medicine and Rehabilitation (PM & R)",
  "Plastic Surgery","Psychiatry","Public Health and Preventive Medicine","Radiation Oncology","Respirology",
  "Rheumatology","Urology"];

class PostSearchByCategoryPage extends StatefulWidget {
  const  PostSearchByCategoryPage({Key? key, required String this.token}) : super(key: key);
  final String token;

  @override
  State<PostSearchByCategoryPage> createState() => _PostSearchByCategoryPageState();
}

class _PostSearchByCategoryPageState extends State<PostSearchByCategoryPage> {

  String categoryValue = categories.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        body: SingleChildScrollView(
              child: Form(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 20.0, 10.0, 0),
                          child:  DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                              labelText: '*Category',
                            ),
                            value: categoryValue,
                            onChanged: (String? value) {
                              setState(() {
                                categoryValue = value!;
                                print("VALUE $value");
                              });
                            },
                            items: categories.map<DropdownMenuItem<String>> ((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0),
                          child:  ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PostSearchResultsPage(token: widget.token, searchType: 0,category: categoryValue,)),
                              );

                            }, child: const Text("Search"),
                          ),
                        ),
                  ],
                  )
                )
              )
            )
    );
  }

}
