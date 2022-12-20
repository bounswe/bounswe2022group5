import 'package:bounswe5_mobile/screens/home.dart';
import 'package:bounswe5_mobile/screens/login.dart';
import 'package:bounswe5_mobile/screens/searchPost.dart';
import 'package:bounswe5_mobile/screens/searchArticle.dart';
import 'package:bounswe5_mobile/screens/home.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:bounswe5_mobile/API_service.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class PostSearchByGeolocationPage extends StatefulWidget {
  const  PostSearchByGeolocationPage({Key? key, required String this.token}) : super(key: key);
  final String token;

  @override
  State<PostSearchByGeolocationPage> createState() => _PostSearchByGeolocationPageState();
}

const List<String> distances = <String>["5 km", "10 km", "15 km", "20 km", "25 km" , "30 km", "50 km", "150 km", "300 km"];
class _PostSearchByGeolocationPageState extends State<PostSearchByGeolocationPage> {

  final TextEditingController _keyword = TextEditingController();
  Position? _currentPosition;

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

  void waitForPermission() async {
    if(await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      _getCurrentPosition();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide permission for location access.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    waitForPermission();
  }



  @override
  Widget build(BuildContext context) {
    String distanceValue = distances.first;
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
                              labelText: 'distance',
                            ),
                            value: distanceValue,
                            onChanged: (String? value) {
                              setState(() {
                                distanceValue = value!;
                              });
                            },
                            items: distances.map<DropdownMenuItem<String>> ((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                       // (this._currentPosition == null) ? const SizedBox.shrink() :
                        Padding(
                          padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0),
                          child:  ElevatedButton(
                            onPressed: () async {
                                while(_currentPosition == null);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         HomePage(token: widget.token, index: 0)),
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
