import 'package:http/http.dart' as http;
import 'package:bounswe5_mobile/models/user.dart';
import 'dart:async';
import 'dart:convert';

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

  Future<int> createPost(String token, String title, String author, String body_, String location, String image_urls ) async {
    var uri = Uri.parse("$baseURL/forum/post");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final body = jsonEncode(<String, Object>{
      'title': title,
      'author': author,
      'body': body_,
      'image_urls': image_urls,
    });
    final response = await http.post(uri, body: body, headers: header);

    return response.statusCode;
  }

  Future<int> createArticle(String token, String title, String author, String body_) async {
    var uri = Uri.parse("$baseURL/articles/article");
    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final body = jsonEncode(<String, Object>{
      'title': title,
      'author': author,
      'body': body_,
    });
    final response = await http.post(uri, body: body, headers: header);

    return response.statusCode;
  }



}