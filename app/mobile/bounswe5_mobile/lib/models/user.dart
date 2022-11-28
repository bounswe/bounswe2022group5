import 'package:bounswe5_mobile/models/memberInfo.dart';
import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/mockData.dart';

/// This model is for logging the logged in
/// user info.
class User {
  /// Token comes from the API. A different string for
  /// every login.
  final int id;
  final String token;
  final String email;
  /// 1 for Member, 2 for Doctor
  final int usertype;

  // Member specific fields:
  final int memberid;
  String username;
  String avatarUrl;
  MemberInfo info;

  //Doctor specific fields:
  final int doctorid;
  final String fullName;
  Category specialization; // Every doctor has 1 and only 1 specialization (?)
  final String hospitalName;


  User(
      this.id,
      this.token,
      this.email,
      this.usertype,
      {
        this.memberid = -1,
        this.username = "",
        this.avatarUrl = "",

        this.doctorid = -1,
        this.fullName = "",
        this.specialization = const Category(-1,"",""),
        this.hospitalName = "",
      }
      ) : info = MemberInfo();
}