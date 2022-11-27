import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';

const List<String> categories = <String>['Anatomical Pathology', 'Anesthesiology','Cardiology','Hematology', 'Cardiovascular & Thoracic Surgery', 'Clinical Immunology/Allergy', 'Critical Care Medicine'];

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key, required User this.activeUser}) : super(key: key);
  final User activeUser;
  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {

  List tags = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final GlobalKey<TagsState> _tagKey = GlobalKey<TagsState>();
  String _fileText = "";
  File? image;
  Position? _currentPosition;

  Future<int> post(String token, String title, String author, String body, String location, String image_urls) async { //register API call handling function
    final result = await ApiService().createPost(token, title, author, body, location, image_urls);
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

    String categoryValue = categories.first;
    ApiService apiServer = ApiService();
    return  FutureBuilder<User?>(
        future: apiServer.getUserInfo(widget.activeUser.token),
        builder: (context,snapshot) {
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
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(),
                                      labelText: '*Category',
                                    ),
                                    value: categoryValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        categoryValue = value!;
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
                                    padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                    child: Tags(
                                      key: _tagKey,
                                      itemCount: tags.length,
                                      columns: 6,
                                      textField: TagsTextField(

                                        onSubmitted: (string) {
                                          setState(() {
                                            tags.add(Item(title: string));
                                          });
                                        },
                                      ),
                                      itemBuilder: (index) {
                                        final Item currentItem = tags[index];
                                        return ItemTags(
                                          index: index,
                                          title: currentItem.title,
                                          customData: currentItem.customData,
                                          textStyle: const TextStyle(fontSize: 14),
                                          combine: ItemTagsCombine.withTextBefore,
                                          removeButton: ItemTagsRemoveButton(
                                            onRemoved: () {
                                              setState(() {
                                                tags.removeAt(index);
                                              });
                                              return true;
                                            },
                                          ),


                                        );
                                      },
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                  child: TextFormField( //title field
                                    controller: _title,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Title',
                                    ),
                                    validator: (value) { //validate
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a title';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                                  child: TextFormField( //body field
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                    controller: _body,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'What is your discomfort?',
                                      alignLabelWithHint: true,
                                    ),
                                    validator: (value) { //validate
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the body of the post';
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
                                                  String location = "";
                                                  String image_urls = "[]";
                                                  String token = snapshot.data!.token;
                                                  String author = snapshot.data!.id.toString();
                                                  if(_currentPosition != null) {
                                                    location = "[ ${_currentPosition!.longitude.toString()} , ${_currentPosition!.latitude.toString()} ]";
                                                }
                                                  if(image != null){
                                                    image_urls = "[ ${image!.uri} ]";
                                                  }
                                                  int posted = await post(token, _title.text, author, _body.text, location, image_urls);
                                                  if (posted == 200) {
                                                    Navigator.pop(context);
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text("Could not post")),
                                                    );
                                                  }
                                                }
                                              },
                                              child: const Text('Post'),
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
