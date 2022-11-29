import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bounswe5_mobile/models/user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:path/path.dart' as p;

/// This class handles API calls.
class ApiService {
  /// Base URL of backend
  var baseURL = "http://ec2-3-87-119-148.compute-1.amazonaws.com:8000";

  Future<int> signUp(String email, String password, int type) async {
    var uri = Uri.parse("$baseURL/auth/register");
    final body = jsonEncode(<String, Object>{
      'email': email,
      'password': password,
      'type': type,
    });
    final response = await http.post(uri, body: body, headers: {'content-type': "application/json"});

    return response.statusCode;
  }

  Future<String> login(String email, String password) async {
    var uri = Uri.parse("$baseURL/auth/login");

    final body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });
    final response = await http.post(uri, body: body, headers: {'content-type': "application/json"});

    if (response.statusCode == 200){
      return jsonDecode(response.body)["token"];
    } else {
      return "Error";
    }
  }

  Future<bool> logout(String token) async {
    var uri = Uri.parse("$baseURL/auth/logout");

    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200){
      return true;
    } else {
      return false;
    }
  }

  Future<User?> getUserInfo(String token) async {
    var uri = Uri.parse("$baseURL/auth/me");

    final header = {
    'Authorization': "token $token",
    'content-type': "application/json",
    };
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      String email = body["email"];
      int userType = body["type"];
      User user;
      user = User(-1, token, email, userType);
      return user;
    } else{
      return null;
    }

  }

  Future<int> createPost(String token, String title, String body_, String longitude, String latitude, String image_uri ) async {

    File file = await toFile(image_uri);
    var uri = Uri.parse("${baseURL}/forum/post");
    Map<String, String> headers =  {
      'Authorization': "token $token",
      'content-type': "multipart/form-data",
    };
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['title'] = title
      ..fields['body'] = body_
      ..fields['longitude'] = longitude
      ..fields['latitude'] = latitude
      ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
    var response = await request.send();
    return response.statusCode;

  /*  var uri = Uri.parse("$baseURL/forum/post");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final body = jsonEncode(<String, Object>{
      'title': title,
      'body': body_,
      'longitude': longitude,
      'latitude': latitude,
      'image_urls': image_urls,
    });
    final response = await http.post(uri, body: body, headers: header);

    return response.statusCode;*/
  }

  Future<int> createArticle(String token, String title, String body_, String image_uri) async {
    File file = await toFile(image_uri);
    var uri = Uri.parse("${baseURL}/articles/article");
    Map<String, String> headers =  {
      'Authorization': "token $token",
      'content-type': "multipart/form-data",
    };
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['title'] = title
      ..fields['body'] = body_
      ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
    var response = await request.send();
    return response.statusCode;
  }



}