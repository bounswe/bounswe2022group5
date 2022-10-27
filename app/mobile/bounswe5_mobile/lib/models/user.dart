import 'package:flutter/material.dart';

class User {
  final String usertype;
  final int id;
  final String email;
  final String password;
  final String username;
  final String name;
  final String surname;
  final String imagePath;

  User(
      this.usertype,
      this.id,
      this.email,
      this.password,
      this.username,
      this.name,
      this.surname,
      this.imagePath,
      );
}

// Mock Data:

final User burak = User(
  'Doctor',
  0,
  'burak@gmail.com',
  '1234',
  '',
  'Burak',
  'Pala',
  'https://user-images.githubusercontent.com/61624884/157100374-40037c23-328b-4054-9d7a-4655339ae3e4.jpg',
);

final User bengin = User(
  'Member',
  1,
  'bengin@gmail.com',
  '1234',
  'bengin',
  'Bengin',
  'Bestas',
  '',
);

final User kardelen = User(
  'Member',
  2,
  'kardelen@gmail.com',
  '1234',
  'kardelen',
  'Kardelen',
  'Demiral',
  'https://user-images.githubusercontent.com/74200767/156989787-c8764367-6a74-4a0d-916a-ef38d707eacf.png',
);

final User oguzhan = User(
  'Member',
  2,
  'oguzhan@gmail.com',
  '1234',
  'oguzhan',
  'Oguzhan',
  'Demiral',
  'https://user-images.githubusercontent.com/77230368/157037220-7955c228-f259-467a-9f2e-501147ac80e1.jpg',
);