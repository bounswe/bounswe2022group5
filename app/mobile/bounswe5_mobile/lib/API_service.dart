import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ApiService {
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

}