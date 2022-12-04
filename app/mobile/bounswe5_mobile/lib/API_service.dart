

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:path/path.dart' as p;
import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';

/// This class handles API calls.
class ApiService {
  /// Base URL of backend
  var baseURL = "http://ec2-3-87-119-148.compute-1.amazonaws.com:8000";

  Future<int> postUpvote(int postID, String token) async {
    var uri = Uri.parse("$baseURL/forum/post/${postID.toString()}/upvote");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.post(uri, headers: header);
    return response.statusCode;
  }

  Future<int> postDownvote(int postID, String token) async {
    var uri = Uri.parse("$baseURL/forum/post/${postID.toString()}/downvote");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.post(uri, headers: header);
    return response.statusCode;
  }

  Future<int> commentUpvote(int commentID, String token) async {
    var uri = Uri.parse("$baseURL/forum/post/comment/${commentID.toString()}/upvote");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.post(uri, headers: header);
    return response.statusCode;
  }

  Future<int> commentDownvote(int commentID, String token) async {
    var uri = Uri.parse("$baseURL/forum/post/comment/${commentID.toString()}/downvote");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.post(uri, headers: header);
    return response.statusCode;
  }
  Future<int> articleUpvote(int articleID, String token) async {
    var uri = Uri.parse("$baseURL/articles/article/${articleID.toString()}/upvote");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.post(uri, headers: header);
    return response.statusCode;
  }

  Future<int> articleDownvote(int articleID, String token) async {
    var uri = Uri.parse("$baseURL/articles/article/${articleID.toString()}/downvote");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.post(uri, headers: header);
    return response.statusCode;
  }

  Future<int> articleDelete(int articleID, String token) async {
    var uri = Uri.parse("$baseURL/articles/article/${articleID.toString()}");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.delete(uri, headers: header);
    return response.statusCode;
  }
  Future<int> postDelete(int postID, String token) async {
    var uri = Uri.parse("$baseURL/forum/post/${postID.toString()}");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.delete(uri, headers: header);
    return response.statusCode;
  }

  Future<int> postUpdate(String token, int postID, String title, String body, String longitude, String latitude) async {
    var uri = Uri.parse("$baseURL/forum/post/${postID.toString()}");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final body_ = jsonEncode(<String, Object>{
      'title': title,
      'body': body,
      'longitude': longitude,
      'latitude': latitude,
    });
    final response = await http.post(uri, body: body_, headers: header);

    return response.statusCode;
  }

  Future<int> articleUpdate(String token, int articleID, String title, String body) async {
    var uri = Uri.parse("$baseURL/articles/article/${articleID.toString()}");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final body_ = jsonEncode(<String, Object>{
      'title': title,
      'body': body,
    });
    final response = await http.post(uri, body: body_, headers: header);

    return response.statusCode;
  }

  Future<int> createComment(int postID, token, String body, String longitude, String latitude, String image_uri) async {
    if (image_uri != "" && longitude.length != 0){
      File file = await toFile(image_uri);
      var uri = Uri.parse("${baseURL}/forum/post/${postID.toString()}/comment");
      Map<String, String> headers =  {
        'Authorization': "token $token",
        'content-type': "multipart/form-data",
      };
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields['body'] = body
        ..fields['longitude'] = longitude
        ..fields['latitude'] = latitude
        ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
      var response = await request.send();
      return response.statusCode;
    }

    if(image_uri != "" && longitude.length == 0){
      File file = await toFile(image_uri);
      var uri = Uri.parse("${baseURL}/forum/post/${postID.toString()}/comment");
      Map<String, String> headers =  {
        'Authorization': "token $token",
        'content-type': "multipart/form-data",
      };
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields['body'] = body
        ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
      var response = await request.send();
      return response.statusCode;
    }

    if(image_uri.length == 0 && longitude.length == 0) {
        var uri = Uri.parse(
            "${baseURL}/forum/post/${postID.toString()}/comment");
        Map<String, String> headers = {
          'Authorization': "token $token",
          'content-type': "multipart/form-data",
        };
        var request = http.MultipartRequest('POST', uri)
          ..headers.addAll(headers)
          ..fields['body'] = body;
        var response = await request.send();
        return response.statusCode;
      }

    var uri = Uri.parse("${baseURL}/forum/post/${postID.toString()}/comment");
    Map<String, String> headers =  {
      'Authorization': "token $token",
      'content-type': "multipart/form-data",
    };
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['body'] = body
      ..fields['longitude'] = longitude
      ..fields['latitude'] = latitude;
    var response = await request.send();
    return response.statusCode;


  }

  Future<int> memberSignUp(String email, String password, int type, String date_of_birth, String username) async {
    var uri = Uri.parse("$baseURL/auth/register");
    final body = jsonEncode(<String, Object>{
      'email': email,
      'password': password,
      'type': type,
      'date_of_birth': date_of_birth,
      'username': username
    });
    final response = await http.post(uri, body: body, headers: {'content-type': "application/json"});

    return response.statusCode;
  }

  Future<int> doctorSignUp(String email, String password, String type, String date_of_birth, String first_name, String last_name, String branch, File doc) async {
    //File file = await toFile(doc_uri);
    var uri = Uri.parse("${baseURL}/auth/register");
    Map<String, String> headers =  {
      'content-type': "multipart/form-data",
    };
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['email'] = email
      ..fields['password'] = password
      ..fields['type'] = type
      ..fields['date_of_birth'] = date_of_birth
      ..fields['firstname'] = first_name
      ..fields['lastname'] = last_name
      ..fields['branch'] = branch
      ..files.add(http.MultipartFile.fromBytes('file', doc.readAsBytesSync(), filename: 'test'));
    var response = await request.send();
    return response.statusCode;
  }

  Future<int> signUp(String email, String password, int type) async {
    var uri = Uri.parse("$baseURL/auth/register");
    final body = jsonEncode(<String, Object>{
      'email': email,
      'password': password,
      'type': type,
    });
    final response = await http.post(uri, body: body, headers: {'content-type': "application/json"});
    print(response.body.toString());
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
      print("Response body:");
      print(response.body.toString());
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
    var uri = Uri.parse("$baseURL/profile/get_personal_info");

    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      int id = body["id"];
      String email = body["email"];
      int userType = body["type"];
      String registerDate = body["register_date"];
      String dateOfBirth = body["date_of_birth"];
      String profileImageUrl = body["profile_image"];

      MemberInfo memberinfo = MemberInfo();
      User user;

      if(userType == 1) { // doctor
        String fullName = body["full_name"]; // doctor
        String specializationName = body["specialization"]; // doctor
        String hospitalName = body["hospital_name"]; // doctor
        bool verified = body["verified"]; // doctor
        String document = body["document"]; // doctor
        Category specialization = Category(-1,specializationName,""); // doctor
        user = User(id,token,email,userType,
          fullName: fullName,
          specialization: specialization,
          hospitalName: hospitalName,
          verified: verified,
        );
        user.documentUrl = document;
      }

      else { // member
        String username = body["member_username"]; // member
        String? firstName = body["firstname"]; // member
        String? lastName = body["lastname"]; // member
        String? address = body["address"]; // member
        double? weight = body["weight"]; // member
        int? height = body["height"]; // member
        int? age = body["age"]; // member

        print("past illnesses");
        print(body["past_illnesses"].runtimeType);


        List<dynamic> pastIllnesses = body["past_illnesses"]; // member
        List<dynamic> allergies = body["allergies"]; // member
        List<dynamic> chronicDiseases = body["chronic_diseases"]; // member
        List<dynamic> undergoneOperations = body["undergone_operations"]; // member
        List<dynamic> usedDrugs = body["used_drugs"]; // member


        memberinfo.firstName = firstName;
        memberinfo.lastName = lastName;
        memberinfo.weight = weight;
        memberinfo.height = height;
        memberinfo.age = age;


        memberinfo.pastIllnesses = pastIllnesses;
        memberinfo.allergies = allergies;
        memberinfo.chronicDiseases = chronicDiseases;
        memberinfo.undergoneOperations = undergoneOperations;
        memberinfo.usedDrugs = usedDrugs;
        memberinfo.address = address;

        user = User(id,token,email,userType,
          username: username,
        );
        user.info = memberinfo;
      }
      user.profileImageUrl = profileImageUrl;
      user.dateOfBirth = dateOfBirth;
      user.registerDate = registerDate;
      return user;

    } else{
      // User with id -1 means nobody logged in.
      return User(-1, '-1', '-1', -1);
    }

  }


  Future<int> createPost(String token, String title, String body_, String longitude, String latitude, String image_uri, String category, String labels ) async {

    if (image_uri != "" && longitude.length != 0){
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
        ..fields['category'] = category
        ..fields['labels'] = labels
        ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
      var response = await request.send();
      return response.statusCode;
    }

    if(longitude.length == 0 && latitude.length == 0 && image_uri.length == 0){
      var uri = Uri.parse("${baseURL}/forum/post");
      Map<String, String> headers =  {
        'Authorization': "token $token",
        'content-type': "multipart/form-data",
      };
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields['title'] = title
        ..fields['body'] = body_
        ..fields['category'] = category
        ..fields['labels'] = labels;
      var response = await request.send();
      return response.statusCode;
    }

    if(longitude.length == 0 && latitude.length == 0 && image_uri.length != 0){
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
        ..fields['category'] = category
        ..fields['labels'] = labels
        ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
      var response = await request.send();
      return response.statusCode;
    }

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
      ..fields['category'] = category
      ..fields['labels'] = labels;
    var response = await request.send();
    return response.statusCode;


  }

  Future<int> createArticle(String token, String title, String body_, String image_uri, String category, String labels) async {
    if(image_uri != "") {
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
        ..fields['category'] = category
        ..fields['labels'] = labels
        ..files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), filename: 'test'));
      var response = await request.send();
      return response.statusCode;
    }

    var uri = Uri.parse("${baseURL}/articles/article");
    Map<String, String> headers =  {
      'Authorization': "token $token",
      'content-type': "multipart/form-data",
    };
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['title'] = title
      ..fields['body'] = body_
      ..fields['category'] = category
      ..fields['labels'] = labels;
    var response = await request.send();
    return response.statusCode;


  }
}