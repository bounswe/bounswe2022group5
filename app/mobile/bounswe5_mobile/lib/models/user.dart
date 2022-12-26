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
  /// 1 for Doctor, 2 for Member
  final int usertype;

  // Member specific fields:
  final int memberid;

  String? profileImageUrl;

  String? dateOfBirth;
  String? registerDate;

  String username;
  MemberInfo info;

  //Doctor specific fields:
  final int doctorid;
  final String fullName;
  Category? specialization; // Every doctor has 1 and only 1 specialization (?)
  String hospitalName;

  final bool verified;

  String? documentUrl;

  User(
      this.id,
      this.token,
      this.email,
      this.usertype,
      {
        this.memberid = -1,
        this.username = "",
        this.doctorid = -1,
        this.fullName = "",
        this.specialization,
        this.hospitalName = "",
        this.verified = false,
      }
      ) : info = MemberInfo();
}