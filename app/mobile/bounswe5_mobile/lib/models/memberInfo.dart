import 'package:flutter/material.dart';

/// This model is for recording Personal Information
/// of a Member.
class MemberInfo {

  String firstName;
  String lastName;
  double weight;
  double height;
  int age;
  String pastIllnesses;
  String allergies;
  String chronicDiseases;
  String undergoneOperations;
  String usedDrugs;

  MemberInfo({
    this.firstName = "",
    this.lastName = "",
    this.weight = -1,
    this.height = -1,
    this.age = -1,
    this.pastIllnesses = "",
    this.allergies = "",
    this.chronicDiseases = "",
    this.undergoneOperations = "",
    this.usedDrugs = ""
  });
}