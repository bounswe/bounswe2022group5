import 'package:bounswe5_mobile/screens/viewPost.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';

const List<String> categories = <String>['Anatomical Pathology', 'Anesthesiology','Cardiology','Hematology', 'Cardiovascular & Thoracic Surgery', 'Clinical Immunology/Allergy', 'Critical Care Medicine'];

class CreateCommentPage extends StatefulWidget {
  const CreateCommentPage({Key? key, required User this.activeUser, required Post this.post}) : super(key: key);
  final User activeUser;
  final Post post;
  @override
  State<CreateCommentPage> createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _body = TextEditingController();
  File? image;
  Position? _currentPosition;

  Future<int> comment(int postID, String token, String body, String longitude, String latitude, String image_uri) async { //register API call handling function
    final result = await ApiService().createComment(postID, token, body, longitude, latitude, image_uri);
    return result;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch(e) {
      print("Failed to pick image: $e");
    }

  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    int postID = widget.post.id;
    ApiService apiServer = ApiService();
    return  FutureBuilder<User?>(
        future: apiServer.getUserInfo(widget.activeUser.token),
        builder: (context,snapshot) {
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
                                  child: TextFormField( //body field
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                    controller: _body,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Comment',
                                      alignLabelWithHint: true,
                                    ),
                                    validator: (value) { //validate
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your comment';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 5.0, 0.0),
                                        child: ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.add_photo_alternate,
                                            size: 24.0,
                                          ),
                                          label: const Text('Add an Image'),
                                          onPressed: () async {
                                            pickImage();
                                          },
                                        )
                                    ),
                                    (this.image == null)? const SizedBox.shrink() :
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB( 0.0, 30.0, 10.0, 10.0),
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: const TextSpan(
                                            text: "✅",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 5.0, 0.0),
                                        child: ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.location_pin,
                                            size: 24.0,
                                          ),
                                          label: const Text('Add Location'),
                                          onPressed: () async {
                                            if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
                                              _getCurrentPosition();
                                              // Either the permission was already granted before or the user just granted it.
                                            }
                                          },
                                        )
                                    ),
                                    (this._currentPosition == null)? const SizedBox.shrink() :
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB( 0.0, 30.0, 10.0, 10.0),
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: const TextSpan(
                                            text: "✅",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    children: [
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent),
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 0.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // Validate returns true if the form is valid, or false otherwise.
                                                if (_formKey.currentState!.validate()) {
                                                  String longitude = "";
                                                  String latitude = "";
                                                  String image_uri = "";
                                                  String token = snapshot.data!.token;
                                                  if(_currentPosition != null) {
                                                    longitude = _currentPosition!.longitude.toString();
                                                    latitude = _currentPosition!.latitude.toString();
                                                  }
                                                  if(image != null){
                                                    image_uri = "${image!.uri}";
                                                  }
                                                  int commented = await comment(postID, token, _body.text, longitude, latitude, image_uri);
                                                  if (commented == 200) {
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ViewPostPage(activeUser: widget.activeUser, post:widget.post)
                                                        )
                                                    );

                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Could not comment ${commented}")),
                                                    );
                                                  }
                                                }
                                              },
                                              child: const Text('Comment'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),

                              ],
                            ),
                          )
                      )
                  )
              )
          );
        }
    );
  }

}
