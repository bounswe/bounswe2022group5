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
    var uri = Uri.parse("${baseURL}/forum/post/${postID.toString()}/comment");
    if(image_uri != "") {
      File file = await toFile(image_uri);
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