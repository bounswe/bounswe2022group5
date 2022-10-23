import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String name;
  final String surname;

  User(
      this.id,
      this.username,
      this.name,
      this.surname,
      );
}

// Mock Data:

final User burak = User(
  0,
  'burak',
  'Burak',
  'Pala',
);

final User bengin = User(
  1,
  'bengin',
  'Bengin',
  'Bestas',
);

final User kardelen = User(
  2,
  'kardelen',
  'Kardelen',
  'Demiral',
);

final User oguzhan = User(
  3,
  'oguz',
  'Oguzhan',
  'Senol',
);