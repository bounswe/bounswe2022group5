import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';

/// This model represents Member User.
class Member extends User{

  final int memberid;
  String username;
  String avatarUrl;
  MemberInfo info;

  Member(
      super.id,
      super.token,
      super.email,
      super.usertype,
      this.memberid,
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

