import 'package:flutter/material.dart';

/// This model is for recording Personal Information
/// of a Member.
class MemberInfo {

  String? firstName;
  String? lastName;
  double? weight;
  int? height;
  int? age;
  String? address;
  List<dynamic>? pastIllnesses;
  List<dynamic>? allergies;
  List<dynamic>? chronicDiseases;
  List<dynamic>? undergoneOperations;
  List<dynamic>? usedDrugs;

  MemberInfo();
}