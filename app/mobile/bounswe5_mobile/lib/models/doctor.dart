import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/user.dart';


/// This model is represents Doctor User.
class Doctor extends User{

  final int doctorid;
  final String fullName;
  final Category specialization; // Every doctor has 1 and only 1 specialization (?)
  final String hospitalName;

  Doctor(
      super.id,
      super.token,
      super.email,
      super.usertype,
      this.doctorid,
      this.fullName,
      this.specialization,
      this.hospitalName,
      );

}

