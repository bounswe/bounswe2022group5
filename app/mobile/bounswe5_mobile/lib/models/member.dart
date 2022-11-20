import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';

/// This model represents Member User.
class Member {

  final int id;
  final int userid;
  String username;
  String avatarUrl;
  MemberInfo info;

  Member(
      this.id,
      this.userid,
      this.username,
      this.avatarUrl,
      ) : info = MemberInfo();

  set setUsername(String newUsername){
    username = newUsername;
  }

  set setAvatarUrl(String newUrl){
    avatarUrl = newUrl;
  }

  set setMemberInfo(MemberInfo newInfo){
    info = newInfo;
  }
}

