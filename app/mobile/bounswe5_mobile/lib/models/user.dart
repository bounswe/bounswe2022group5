import 'package:flutter/material.dart';

/// This model is for logging the logged in
/// user info.
class User {
  /// Token comes from the API. A different string for
  /// every login.
  final String token;
  final String email;
  /// 0 for Admin, 1 for Doctor, 2 for Member
  final int usertype;

  User(
      this.token,
      this.email,
      this.usertype,
      );
}