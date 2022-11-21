import 'package:flutter/material.dart';

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

  User(
      this.id,
      this.token,
      this.email,
      this.usertype,
      );
}