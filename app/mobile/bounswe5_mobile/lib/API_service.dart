

import 'dart:ffi';
import 'dart:io';
import 'dart:math';
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
import 'package:bounswe5_mobile/models/comment.dart';
import 'package:bounswe5_mobile/models/textAnnotation.dart';
import 'package:intl/intl.dart';


/// This class handles API calls.
class ApiService {
  /// Base URL of backend
  var baseURL = "http://ec2-3-87-119-148.compute-1.amazonaws.com:8000";
  var annoURL = "http://ec2-18-209-24-202.compute-1.amazonaws.com:8000/";
  var frontURL = "http://3.91.54.225:3000";

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

  Future<int> commentDelete(int commentID, String token) async {
    var uri = Uri.parse("$baseURL/forum/post/comment/${commentID.toString()}");
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
        Category specialization = Category(-1,specializationName); // doctor
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


  /// Returns number of posts and List of (paginated) Posts
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
        double? longitude = results[i]["longitude"];
        double? latitude = results[i]["latitude"];
        bool commentedByDoctor = results[i]["commented_by_doctor"];

        var categoryraw = results[i]["category"];
        Category category = Category(-1,"");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"]);
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
        String? voteOfActiveUser = results[i]["vote"];

        PostAuthor postAuthor = PostAuthor(authorId, authorUsername, isAuthorDoctor);
        postAuthor.profileImageUrl = profileImage;

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


  /// Returns number of articles and List of (paginated) Articles
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
        Category category = Category(-1,"");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"]);
        }

        String title = results[i]["title"];
        String articleBody = results[i]["body"];
        int upvotes = results[i]["upvote"];
        int downvotes = results[i]["downvote"];

        int authorId = results[i]["author"]["id"];
        String authorUsername = results[i]["author"]["username"];
        String profileImage = results[i]["author"]["profile_photo"];

        String? voteOfActiveUser = results[i]["vote"];

        ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorUsername);
        articleAuthor.setProfileImageUrl(profileImage);

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


    result.add(user);
    result.add(posts[0]);
    result.add(posts[1]);
    result.add(articles[0]);
    result.add(articles[1]);

    return result;
  }
  
  Future<int> updateUserInfo(User user, String name) async {
    var token = user.token;
    var uri = Uri.parse("$baseURL/profile/update_personal_info");
    var body;
    if(user.usertype == 2 ){
      body = jsonEncode(<String, Object>{
        'member_username': name
      });
    }
    else if(user.usertype == 1 ){
      body = jsonEncode(<String, Object>{
        'hospital_name': name
      });
    }
    final response = await http.post(uri, body: body, headers: {
      'Authorization': "token $token",
      'content-type': "application/json",
    });
    return response.statusCode;

  }
  
  Future<int> changeHospitalName(String token, String hospitalName) async {
    var uri = Uri.parse("$baseURL/profile/update_personal_info");
    Map<String, String> headers =  {
      'Authorization': "token $token",
      'content-type': "multipart/form-data",
    };
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields['hospital_name'] = hospitalName;

    final body = jsonEncode(<String, String>{
      'member_username': hospitalName
    });
    var response = await request.send();
    return response.statusCode;
  }
  
  Future<int?> getAvatar(String token) async {
    var uri = Uri.parse("$baseURL/profile/get_personal_info");

    final header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      int avatar = body["avatar"];
      return avatar;
    } else{
      return null;
    }
  }

  Future<int> changeAvatar(String token, int avatar) async {
    var uri = Uri.parse("$baseURL/profile/update_personal_info");
    Map<String, String> headers =  {
      'Authorization': "token $token",
      'content-type': "multipart/form-data",
    };
    final body = jsonEncode(<String, int>{
      'avatar': avatar
    });
    final response = await http.post(uri, body: body, headers: headers);
    return response.statusCode;
  }


  /// Returns a specific post and its comments
  Future<dynamic> getSinglePost(String token, int postid) async {
    var uri = Uri.parse("$baseURL/forum/post/$postid");

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
    Post? post;

    List<Comment> comments = List.empty(growable: true);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);

      dynamic rawpost = body["post"];

      int id = rawpost["id"];

      String date = rawpost["date"];
      String title = rawpost["title"];
      String postBody = rawpost["body"];
      int upvotes = rawpost["upvote"];
      int downvotes = rawpost["downvote"];
      double? longitude = rawpost["longitude"];
      double? latitude = rawpost["latitude"];
      bool commentedByDoctor = rawpost["commented_by_doctor"];

      var categoryraw = rawpost["category"];
      Category category = Category(-1,"");
      if(categoryraw != null){
        category = Category(categoryraw["id"], categoryraw["name"], );
      }

      List<dynamic> labelsraw = rawpost["labels"];
      List<Label> labels = List.empty(growable: true);

      for(int j = 0 ; j < labelsraw.length; j++){
        Label label = Label(labelsraw[j]["id"],labelsraw[j]["name"]);
        labels.add(label);
      }

      dynamic rawauthor = rawpost["author"];

      int authorId = rawauthor["id"];
      String authorUsername = rawauthor["username"];
      String profileImage = rawauthor["profile_photo"];
      bool isAuthorDoctor = rawauthor["is_doctor"];

      String? voteOfActiveUser = rawpost["vote"];

      PostAuthor postAuthor = PostAuthor(authorId, authorUsername, isAuthorDoctor);
      postAuthor.setProfileImageUrl(profileImage);

      List<dynamic> rawImageUrls = body["image_urls"];

      List<String> imageUrls = [];
      for(int i = 0 ; i < rawImageUrls.length ; i++){
        String url = rawImageUrls[i];
        imageUrls.add(url);
      }

      var dateTime = DateTime.parse(date);

      post = Post(id,
        postAuthor,
        dateTime,
        title,
        postBody,
        upvotes: upvotes,
        downvotes: downvotes,
        isDoctorReplied: commentedByDoctor,
      );

      post.category = category;
      post.labels = labels;
      post.voteOfActiveUser = voteOfActiveUser;
      post.imageUrls = imageUrls;
      post.longitude = longitude;
      post.latitude = latitude;

      List<dynamic> rawcomments = body["comments"];

      for(int i = 0 ; i < rawcomments.length ; i++){

        dynamic rawcomment = rawcomments[i]["comment"];

        int commentid = rawcomment["id"];
        String commentdate = rawcomment["date"];
        var commentDateTime = DateTime.parse(commentdate);
        String commentbody = rawcomment["body"];
        int commentupvotes = rawcomment["upvote"];
        int commentdownvotes = rawcomment["downvote"];
        double? commentlongitude = rawcomment["longitude"];
        double? commentlatitude = rawcomment["latitude"];

        dynamic rawcommentauthor = rawcomment["author"];

        int authorId = rawcommentauthor["id"];
        String authorUsername = rawcommentauthor["username"];
        String profileImage = rawcommentauthor["profile_photo"];
        bool isAuthorDoctor = rawcommentauthor["is_doctor"];

        CommentAuthor commentAuthor = CommentAuthor(authorId, authorUsername, isAuthorDoctor);
        commentAuthor.setProfileImageUrl(profileImage);

        int postidOfComment = rawcomment["post"];
        String? voteOfActiveUserForComment = rawcomment["vote"];

        Comment c  = Comment(
          commentid,
          commentDateTime,
          commentbody,
          commentAuthor,
          postidOfComment,
        );

        dynamic rawCommentImageUrls = rawcomments[i]["image_urls"];
        List<String> commentImageUrls = [];
        for(int i = 0 ; i < rawCommentImageUrls.length ; i++){
          String url = rawCommentImageUrls[i];
          commentImageUrls.add(url);
        }

        c.latitude = commentlatitude;
        c.longitude = commentlongitude;
        c.upvotes = commentupvotes;
        c.downvotes = commentdownvotes;
        c.voteOfActiveUser = voteOfActiveUserForComment;
        c.imageUrls = commentImageUrls;

        comments.add(c);
      }
    }

    List<dynamic> result = List.empty(growable: true);

    result.add(post);
    result.add(comments);

    return result;
  }


  /// Returns a specific article
  Future<dynamic> getSingleArticle(String token, int articleid) async {
    var uri = Uri.parse("$baseURL/articles/article/$articleid");

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

    Article? article;

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);

      dynamic rawarticle = body["article"];

      int id = rawarticle["id"];
      String date = rawarticle["date"];
      List<dynamic> labelsraw = rawarticle["labels"];
      List<Label> labels = List.empty(growable: true);

      for(int j = 0 ; j < labelsraw.length; j++){
        Label label = Label(labelsraw[j]["id"],labelsraw[j]["name"]);
        labels.add(label);
      }

      var categoryraw = rawarticle["category"];


      Category category = Category(-1,"");
      if(categoryraw != null){
        category = Category(categoryraw["id"], categoryraw["name"]);
      }

      String articleTitle = rawarticle["title"];
      String articleBody = rawarticle["body"];
      int upvotes = rawarticle["upvote"];
      int downvotes = rawarticle["downvote"];

      dynamic rawauthor = rawarticle["author"];
      int authorId = rawauthor["id"];
      String authorUsername = rawauthor["username"];
      String profileImage = rawauthor["profile_photo"];

      ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorUsername);
      articleAuthor.setProfileImageUrl(profileImage);

      String? voteOfActiveUser = rawarticle["vote"];

      List<dynamic> rawImageUrls = body["image_urls"];

      List<String> imageUrls = [];
      for(int i = 0 ; i < rawImageUrls.length ; i++){
        String url = rawImageUrls[i];
        imageUrls.add(url);
      }

      var dateTime = DateTime.parse(date);

      article = Article(
        id,
        dateTime,
        articleTitle,
        articleBody,
        articleAuthor,
        upvotes: upvotes,
        downvotes: downvotes,
      );

      article.category = category;
      article.labels = labels;
      article.voteOfActiveUser = voteOfActiveUser;
      article.imageUrls = imageUrls;

    }

    return article;
  }

  Future<dynamic> getDoctorArticles(User user, int page, int pageSize) async {
    var userid = user.id;
    var token = user.token;
    var uri = Uri.parse("$baseURL/articles/article/user/$userid");

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
        Category category = Category(-1,"");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"]);
        }

        String title = results[i]["title"];
        String articleBody = results[i]["body"];
        int upvotes = results[i]["upvote"];
        int downvotes = results[i]["downvote"];

        int authorId = user.id;
        String authorFullName = user.fullName;


        String voteOfActiveUser = results[i]["vote"];

        ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorFullName);

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

  Future<dynamic> getUserPosts(User user, int page, int pageSize) async {
    var token = user.token;
    var userid = user.id;
    var uri = Uri.parse("$baseURL/forum/post/user/$userid?page=$page&page_size=$pageSize");
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
        Category category = Category(-1,"");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"]);
        }

        List<dynamic> labelsraw = results[i]["labels"];
        List<Label> labels = List.empty(growable: true);

        for(int j = 0 ; j < labels.length; j++){
          Label label = Label(labelsraw[j]["id"],labelsraw[j]["name"]);
          labels.add(label);
        }

        int authorId = results[i]["author"];
        String voteOfActiveUser = results[i]["vote"];


        bool isAuthorDoctor = false;
        String name = user.username;
        if(user.usertype == 1){
          isAuthorDoctor = true;
          name = user.fullName;
        }

        PostAuthor postAuthor = PostAuthor(authorId, user.username, isAuthorDoctor);

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

  Future<dynamic> getUpvotedPosts(User user, int page, int pageSize) async {

    var token = user.token;
    var userid = user.id;
    var uri = Uri.parse("$baseURL/profile/upvoted_posts?page=$page&page_size=$pageSize&sort=desc");

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
        Category category = Category(-1,"");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"]);
        }

        List<dynamic> labelsraw = results[i]["labels"];
        List<Label> labels = List.empty(growable: true);

        for(int j = 0 ; j < labels.length; j++){
          Label label = Label(labelsraw[j]["id"],labelsraw[j]["name"]);
          labels.add(label);
        }

        int authorId = results[i]["author"]["id"];
        String voteOfActiveUser = results[i]["vote"];


        bool isAuthorDoctor = false;
        String name = user.username;
        if(user.usertype == 1){
          isAuthorDoctor = true;
          name = user.fullName;
        }

        PostAuthor postAuthor = PostAuthor(authorId, user.username, isAuthorDoctor);

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

  Future<dynamic> getUpvotedArticles(User user, int page, int pageSize) async {
    var userid = user.id;
    var token = user.token;
    var uri = Uri.parse("$baseURL/profile/upvoted_articles?page=$page&page_size=$pageSize&sort=desc");
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
        Category category = Category(-1,"");
        if(categoryraw != null){
          category = Category(categoryraw["id"], categoryraw["name"]);
        }

        String title = results[i]["title"];
        String articleBody = results[i]["body"];
        int upvotes = results[i]["upvote"];
        int downvotes = results[i]["downvote"];

        int authorId = user.id;
        String authorFullName = user.fullName;


        String voteOfActiveUser = results[i]["vote"];

        ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorFullName);

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

    Future<dynamic> getUserComments(User user, int page, int pageSize) async {
      var token = user.token;
      var userid = user.id;
      var uri = Uri.parse("$baseURL/forum/post/user/$userid/comment?page=$page&page_size=$pageSize");
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
      List<Comment> comments = List.empty(growable: true);
      List<Post> posts = List.empty(growable: true);
      if (response.statusCode == 200){

        var body = jsonDecode(response.body);

        results = body["results"];
        count = body["count"];

        int i;
        for(i = 0 ; i < results.length ; i++){
          int id = results[i]["id"];

          String date = results[i]["date"];
          String commentBody = results[i]["body"];
          int upvotes = results[i]["upvote"];
          int downvotes = results[i]["downvote"];
          double longitude = results[i]["longitude"];
          double latitude = results[i]["latitude"];
          int authorId = results[i]["author"];
          int postId = results[i]["post"];
          String voteOfActiveUser = results[i]["vote"];


          bool isAuthorDoctor = false;
          String name = user.username;
          if(user.usertype == 1){
            isAuthorDoctor = true;
            name = user.fullName;
          }
          List<dynamic> result = await getSinglePost(token, postId);
          Post p = result[0];

          posts.add(p);

          CommentAuthor commentAuthor = CommentAuthor(authorId, name, isAuthorDoctor);

          var dateTime = DateTime.parse(date);

          Comment c = Comment(
            id,
            dateTime,
            commentBody,
            commentAuthor,
            postId,
            upvotes: upvotes,
            downvotes: downvotes,
          );

          c.longitude = longitude;
          c.latitude = latitude;
          c.voteOfActiveUser = voteOfActiveUser;

          comments.add(c);
        }

      }

      List<dynamic> result = List.empty(growable: true);

      result.add(count);
      result.add(comments);
      result.add(posts);
      return result;
    }

    Future<dynamic> searchPostCategory(String token, int page, int pageSize, String category) async {
      var uri = Uri.parse("$baseURL/forum/posts?page=$page&page_size=$pageSize&c=$category");

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
          double? longitude = results[i]["longitude"];
          double? latitude = results[i]["latitude"];
          bool commentedByDoctor = results[i]["commented_by_doctor"];

          var categoryraw = results[i]["category"];
          Category category = Category(-1,"");
          if(categoryraw != null){
            category = Category(categoryraw["id"], categoryraw["name"]);
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
          String? voteOfActiveUser = results[i]["vote"];

          PostAuthor postAuthor = PostAuthor(authorId, authorUsername, isAuthorDoctor);
          postAuthor.profileImageUrl = profileImage;

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

    Future<dynamic> searchPostKeyword(String token, int page, int pageSize, String keyword) async {
      var uri = Uri.parse("$baseURL/forum/posts?page=$page&page_size=$pageSize&q=$keyword");

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
          double? longitude = results[i]["longitude"];
          double? latitude = results[i]["latitude"];
          bool commentedByDoctor = results[i]["commented_by_doctor"];

          var categoryraw = results[i]["category"];
          Category category = Category(-1,"");
          if(categoryraw != null){
            category = Category(categoryraw["id"], categoryraw["name"]);
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
          String? voteOfActiveUser = results[i]["vote"];

          PostAuthor postAuthor = PostAuthor(authorId, authorUsername, isAuthorDoctor);
          postAuthor.profileImageUrl = profileImage;

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


    Future<dynamic> searchPostGeolocation(String token, int page, int pageSize, String dist, String longitude, String latitude) async {
      var uri = Uri.parse("$baseURL/forum/posts?page=$page&page_size=$pageSize&dist=$dist&longitude=$longitude&latitude=$latitude");

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
          double? longitude = results[i]["longitude"];
          double? latitude = results[i]["latitude"];
          bool commentedByDoctor = results[i]["commented_by_doctor"];

          var categoryraw = results[i]["category"];
          Category category = Category(-1,"");
          if(categoryraw != null){
            category = Category(categoryraw["id"], categoryraw["name"]);
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
          String? voteOfActiveUser = results[i]["vote"];

          PostAuthor postAuthor = PostAuthor(authorId, authorUsername, isAuthorDoctor);
          postAuthor.profileImageUrl = profileImage;

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

    Future<dynamic> articleSearchCategory(String token, int page, int pageSize, String category) async {
      var uri = Uri.parse("$baseURL/articles/all?page=$page&page_size=$pageSize&c=$category");

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


      print("RESPONSE: ${response.statusCode}");
      print("CAT $category");

      int count = 0;
      List<dynamic> results;
      List<Article> articles = List.empty(growable: true);

      if (response.statusCode == 200){
        var body = jsonDecode(response.body);

        print("BODY $body");

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
          Category category = Category(-1,"");
          if(categoryraw != null){
            category = Category(categoryraw["id"], categoryraw["name"]);
          }

          String title = results[i]["title"];
          String articleBody = results[i]["body"];
          int upvotes = results[i]["upvote"];
          int downvotes = results[i]["downvote"];

          int authorId = results[i]["author"]["id"];
          String authorUsername = results[i]["author"]["username"];
          String profileImage = results[i]["author"]["profile_photo"];

          String? voteOfActiveUser = results[i]["vote"];

          ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorUsername);
          articleAuthor.setProfileImageUrl(profileImage);

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


    Future<dynamic> articleSearchKeyword(String token, int page, int pageSize, String keyword) async {
      var uri = Uri.parse("$baseURL/articles/all?page=$page&page_size=$pageSize&q=$keyword");

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
          Category category = Category(-1,"");
          if(categoryraw != null){
            category = Category(categoryraw["id"], categoryraw["name"]);
          }

          String title = results[i]["title"];
          String articleBody = results[i]["body"];
          int upvotes = results[i]["upvote"];
          int downvotes = results[i]["downvote"];

          int authorId = results[i]["author"]["id"];
          String authorUsername = results[i]["author"]["username"];
          String profileImage = results[i]["author"]["profile_photo"];

          String? voteOfActiveUser = results[i]["vote"];

          ArticleAuthor articleAuthor = ArticleAuthor(authorId, authorUsername);
          articleAuthor.setProfileImageUrl(profileImage);

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

    /// This function gets all text annotations of a post or an article.
    Future<List<TextAnnotation>> getTextAnnotations(String token, String type, int id) async {
      // type is either "POST" or "ARTICLE"
      var uri = Uri.parse("$annoURL/annotation/$id?type=$type");

      var header = {
        'Authorization': "token $token",
        'content-type': "application/json",
      };

      final response = await http.get(uri, headers: header);

      List<dynamic> rawAnnos = List.empty(growable: true);

      List<TextAnnotation> annos = List.empty(growable: true);

      if (response.statusCode == 200){
        var body = jsonDecode(response.body);

        rawAnnos = body["text_annotations"];

        for(int i = 0 ; i < rawAnnos.length ; i++){

          var annotation = rawAnnos[i];
          var annoBody = annotation["body"][0];
          String dateCreatedRaw = annoBody["created"];

          DateTime created = DateTime.parse(dateCreatedRaw);

          String creatorLink = annoBody["creator"]["id"];
          String profileUrl = "$frontURL/profile/";
          String creatorIdStr = creatorLink.substring(profileUrl.length);
          int creatorId = int.parse(creatorIdStr);

          String creatorName = annoBody["creator"]["name"];

          String annotationBody = annoBody["value"];

          String annotationId = annotation["id"];

          String selectedText = annotation["target"]["selector"][0]["exact"];
          int start = annotation["target"]["selector"][1]["start"];
          int end = annotation["target"]["selector"][1]["end"];

          TextAnnotation anno = TextAnnotation(annotationId, created, creatorId, creatorName, annotationBody, selectedText, start, end);
          annos.add(anno);
        }
      }

      return annos;
    }

  Future<int> createTextAnnotation(String token, String type, int id, TextAnnotation anno) async {

    // type is either "POST" or "ARTICLE"

    var uri = Uri.parse("$annoURL/annotation/text/$id?type=$type");

    var header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };


    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSSSS');

    var reqbody = {
      "@context" : "http://www.w3.org/ns/anno.jsonld",

      "body": [
        {
          "created" : formatter.format(anno.created),
          "creator" : {
            "id" : "http://3.91.54.225:3000/profile/" + anno.creatorId.toString(),
            "name": anno.creatorName
          },
          "modified" : formatter.format(anno.created),
          "purpose": "commenting",
          "type" : "TextualBody",
          "value" : anno.annotationBody,
        }
      ],

      "id" : anno.annoId,
      "target" : {
        "selector": [
          {
            "exact" : anno.selectedText,
            "type" : "TextQuoteSelector"

          },
          {
            "start": anno.start,
            "end": anno.end,
            "type": "TextPositionSelector"
          }
        ]
      },
      "type": "Annotation"


    };

    final response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(reqbody),
    );

    return response.statusCode;

  }

  Future<List?> getDoctorInfo(int doctorId) async {
    var uri = Uri.parse("$baseURL/profile/get_doctor_profile/$doctorId");


    final header = {
      'content-type': "application/json",
    };
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      String fullName = body["full_name"];
      String specialization = body["specialization"];
      String hospitalName = body["hospital_name"];
      String profilePicture = body["profile_picture"];
      List doctorInfo = [fullName, specialization, hospitalName, profilePicture];

      return doctorInfo;

    }
  }

  Future<List<Category>> getAllCategories(String token) async {
    var uri1 = Uri.parse("$baseURL/forum/categories");

    var header1 = {
      'content-type': "application/json",
    };

    var uri2 = Uri.parse("$baseURL/profile/followed_categories");

    var header2 = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };

    final allCategoriesResponse = await http.get(uri1, headers: header1);
    final followedCategoryIdsResponse = await http.get(uri2, headers: header2);

    List<Category> categories = List.empty(growable: true);

    if (allCategoriesResponse.statusCode == 200 && followedCategoryIdsResponse.statusCode == 200){

      var allCategories = jsonDecode(allCategoriesResponse.body);
      var followedCategoryIds = jsonDecode(followedCategoryIdsResponse.body);

      for(int i = 0 ; i < allCategories.length ; i++){
        int id = allCategories[i]["id"];
        String name = allCategories[i]["name"];
        bool isFollowed = followedCategoryIds.contains(id);
        Category category = Category(id, name, isFollowed:isFollowed);
        categories.add(category);
      }
    }

    categories.sort((a,b) => a.name.compareTo(b.name));

    return categories;
  }

  Future<int> followOrUnfollowCategory(String token, int categoryid) async{
    var uri = Uri.parse("$baseURL/profile/follow_category/$categoryid");

    var header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };

    final response = await http.post(uri, headers: header);

    return response.statusCode;

  }

  Future<int> deleteTextAnnotation(String token, String type, String annoId) async{
    var uri = Uri.parse("$annoURL/annotation/text/delete?type=$type");

    var header = {
      'Authorization': "token $token",
      'content-type': "application/json",
    };

    var reqbody = {
      "id" : annoId
    };

    final response = await http.delete(uri, headers: header, body: jsonEncode(reqbody));

    return response.statusCode;

  }

}