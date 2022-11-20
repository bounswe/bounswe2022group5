import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/category.dart';


/// This model is represents Doctor User.
class Doctor {

  final int id;
  final int userid;
  final String fullName;
  final Category specialization; // Every doctor has 1 and only 1 specialization (?)
  final String hospitalName;

  Doctor(
      this.id,
      this.userid,
      this.fullName,
      this.specialization,
      this.hospitalName,
      );

}

