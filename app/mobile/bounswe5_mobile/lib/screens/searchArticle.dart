import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/screens/searchPost.dart';
import 'package:bounswe5_mobile/screens/searchArticle.dart';
import 'package:bounswe5_mobile/screens/articleSearchByCategory.dart';
import 'package:bounswe5_mobile/screens/articleSearchByKeyword.dart';
import 'package:bounswe5_mobile/screens/articleSearchByName.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';




const List<String> list = <String>['Member', 'Doctor'];
const List<String> branches= <String>["Anatomical Pathology","Anesthesiology",'Cardiology',"Cardiovascular-Thoracic Surgery", "Clinical Immunology-Allergy",
  "Critical Care Medicine", "Dermatology","Diagnostic Radiology", "Emergency Medicine","Endocrinology and Metabolism","Family Medicine",
  "Gastroenterology", "General Internal Medicine", "General Surgery", "General-Clinical Pathology","Geriatric Medicine",
  "Hematology","Medical Biochemistry","Medical Genetics","Medical Microbiology and Infectious Diseases",
  "Medical Oncology","Nephrology","Neurology","Neurosurgery", "Nuclear Medicine","Obstetrics-Gynecology",
  "Occupational Medicine","Ophthalmology","Orthopedic Surgery","Otolaryngology","Pediatrics","Physical Medicine and Rehabilitation (PM & R)",
  "Plastic Surgery","Psychiatry","Public Health and Preventive Medicine","Radiation Oncology","Respirology",
  "Rheumatology","Urology"];
class SearchArticlePage extends StatefulWidget {
  const SearchArticlePage({Key? key, required String this.token}) : super(key: key);
  final String token;

  @override
  State<SearchArticlePage> createState() => _SearchArticlePageState();
}

class _SearchArticlePageState extends State<SearchArticlePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: myAppBar,
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB( 10.0, 0, 10.0, 10.0),
                    child:  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleSearchByCategoryPage(token: widget.token)),
                        );

                      }, child: const Text("Search by Category"),
                      style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB( 10.0, 0, 10.0, 10.0),
                    child:  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleSearchByKeywordPage(token: widget.token)),
                        );

                      }, child: const Text("Search By Keyword"),
                      style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }

}
