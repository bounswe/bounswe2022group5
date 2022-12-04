import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:path/path.dart' as p;
import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/label.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:intl/intl.dart';


/// This class handles API calls.
class ApiService {
  /// Base URL of backend
  var baseURL = "http://ec2-3-87-119-148.compute-1.amazonaws.com:8000";

  Future<int> createComment(int postID, token, String body, String longitude, String latitude, String image_uri) async {
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


  /// Returns number of posts and List of (paginaetd) Posts
  /// in a dynamic list.
  Future<dynamic> getPosts(String token, int page, int pageSize) async {
    var uri = Uri.parse("$baseURL/forum/posts?page=$page&page_size=$pageSize");

    var header;
    if(token != "-1"){
      header = {
        'Authorization': "token $token",
        'content-type': "application/json",
      };
    }
    else{
      header = {
        'content-type': "application/json",
      };
    }

    final response = await http.get(uri, headers: header);

    int count = 0;
    List<dynamic> results;
    List<Post> posts = List.empty(growable: true);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);

      results = body["results"];
      count = body["count"];

      int i;
      for(i = 0 ; i < results.length ; i++){
        int id = results[i]["id"];

        String date = results[i]["date"];
        String title = results[i]["title"];
        String postBody = results[i]["body"];
        int upvotes = results[i]["upvote"];
        int downvotes = results[i]["downvote"];
        double longitude = results[i]["longitude"];
        double latitude = results[i]["latitude"];
        bool commentedByDoctor = results[i]["commented_by_doctor"];

        var categoryraw = results[i]["category"];
        Category category = Category(-1,"","");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"], "");
        }

        List<dynamic> labelsraw = results[i]["labels"];
        List<Label> labels = List.empty(growable: true);

        for(int j = 0 ; j < labels.length; j++){
          Label label = Label(labelsraw[j]["id"],labelsraw[j]["name"]);
          labels.add(label);
        }

        int authorId = results[i]["author"]["id"];
        String authorUsername = results[i]["author"]["username"];
        String profileImage = results[i]["author"]["profile_photo"];
        bool isAuthorDoctor = results[i]["author"]["is_doctor"];
        String voteOfActiveUser = results[i]["vote"];

        PostAuthor postAuthor = PostAuthor(authorId, authorUsername, profileImage, isAuthorDoctor);

        var dateTime = DateTime.parse(date);

        Post p = Post(id,
            postAuthor,
            dateTime,
            title,
            postBody,
            upvotes: upvotes,
            downvotes: downvotes,
            isDoctorReplied: commentedByDoctor,
        );

        p.category = category;
        p.labels = labels;
        p.voteOfActiveUser = voteOfActiveUser;

        posts.add(p);
      }

    }

    List<dynamic> result = List.empty(growable: true);

    result.add(count);
    result.add(posts);

    return result;
  }


  /// Returns number of articles and List of (paginaetd) Articles
  /// in a dynamic list.
  Future<dynamic> getArticles(String token, int page, int pageSize) async {
    var uri = Uri.parse("$baseURL/articles/all?page=$page&page_size=$pageSize");

    var header;
    if(token != "-1"){
      header = {
        'Authorization': "token $token",
        'content-type': "application/json",
      };
    }
    else{
      header = {
        'content-type': "application/json",
      };
    }

    final response = await http.get(uri, headers: header);

    int count = 0;
    List<dynamic> results;
    List<Article> articles = List.empty(growable: true);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);

      count = body["count"];
      results = body["results"];


      int i;
      for(i = 0 ; i < results.length ; i++){

        int id = results[i]["id"];
        String date = results[i]["date"];

        List<dynamic> labelsraw = results[i]["labels"];
        List<Label> labels = List.empty(growable: true);

        for(int j = 0 ; j < labels.length; j++){
          Label label = Label(labelsraw[j]["id"],labelsraw[j]["name"]);
          labels.add(label);
        }

        var categoryraw = results[i]["category"];
        Category category = Category(-1,"","");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"], "");
        }

        String title = results[i]["title"];
        String articleBody = results[i]["body"];
        int upvotes = results[i]["upvote"];
        int downvotes = results[i]["downvote"];

        int authorId = results[i]["author"]["id"];
        String authorUsername = results[i]["author"]["username"];
        String profileImage = results[i]["author"]["profile_photo"];

        String voteOfActiveUser = results[i]["vote"];

        ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorUsername, profileImage);

        var dateTime = DateTime.parse(date);

        Article a = Article(
          id,
          dateTime,
          title,
          articleBody,
          articleAuthor,
          upvotes: upvotes,
          downvotes: downvotes,
        );
        articles.add(a);
      }

    }

    List<dynamic> result = List.empty(growable: true);

    result.add(count);
    result.add(articles);

    return result;
  }

  /// Preparing home page: Getting active user, number of posts, list of posts,
  /// number of articles and list of articles.
  Future<dynamic> prepareHomePage(String token, int page, int pageSize) async {

    final user = await getUserInfo(token);
    final posts = await getPosts(token, page, pageSize);
    final articles = await getArticles(token, page, pageSize);

    List<dynamic> result = List.empty(growable: true);

    print(posts[0]);

    result.add(user);
    result.add(posts[0]);
    result.add(posts[1]);
    result.add(articles[0]);
    result.add(articles[1]);

    return result;
  }

}