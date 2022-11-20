import 'dart:html';

import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/doctor.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';
import 'package:bounswe5_mobile/models/member.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/models/comment.dart';


// Users:
User canberk = User(1, '', 'canberk@gmail.com', 1);
User bengin = User(2, '', 'bengin@gmail.com', 1);
User burak = User(3, '', 'burak@gmail.com', 1);
User engin = User(4, '', 'engin@gmail.com', 1);
User halil = User(5, '', 'halil@gmail.com', 1);
User irfan = User(6, '', 'irfan@gmail.com', 1);
User kardelen = User(7, '', 'kardelen@gmail.com', 1);
User emre = User(8, '', 'emre@gmail.com', 1);
User oguzhan = User(9, '', 'oguzhan@gmail.com', 2);
User ozan = User(10, '', 'ozan@gmail.com', 2);
User sinan = User(11, '', 'sinan@gmail.com', 2);
User samet = User(12, '', 'samet@gmail.com', 2);

List<User> users = [
  canberk, bengin, burak, engin, halil, irfan, kardelen, emre, oguzhan,
  ozan, sinan, samet
];

// Categories:
Category allergy = Category(1, 'Allergy and Immunology', '');
Category anesthesiology = Category(2, 'Anesthesiology', '');
Category dermatology = Category(3,'Dermatology','');
Category radiology = Category(4, 'Diagnostic Radiology', '');
Category emergency = Category(5, 'Emergency Medicine', '');
Category family = Category(6, 'Family Medicine', '');
Category internal = Category(7, 'Internal Medicine', '');
Category genetics = Category(8, 'Medical Genetics', '');
Category neurology = Category(9, 'Neurology', '');
Category nuclear = Category(10, 'Nuclear Medicine', '');
Category gynecology = Category(11, 'Obstetrics and Gynecology', '');
Category ophthalmology = Category(12, 'Ophthalmology', '');
Category pathology = Category(13, 'Pathology', '');
Category pediatrics = Category(14, 'Pediatrics', '');
Category pmr = Category(15, 'Physical medicine and Rehabilitation', '');
Category preventive = Category(16, 'Preventive medicine', '');
Category psychiatry = Category(17, 'Psychiatry', '');
Category oncology = Category(18, 'Oncology', '');
Category surgery = Category(19, 'Surgery', '');
Category urology = Category(20, 'Urology', '');
Category cardiology = Category(21, 'Cardiology', '');

List<Category> categories = [
  allergy, anesthesiology, dermatology, radiology, emergency, family, internal,
  genetics, neurology, nuclear, gynecology, ophthalmology, pathology, pediatrics,
  pmr, preventive, psychiatry, oncology, surgery, urology, cardiology
];

// Members:
String ppUri = 'lib/assets/images/generic_user.jpg';
List<Member> members = [
  Member(1,1,'canberk', ppUri),
  Member(2,2,'bengin', ppUri),
  Member(3,3,'burak', ppUri),
  Member(4,4,'engin', ppUri),
  Member(5,5,'halil', ppUri),
  Member(6,6,'irfan', ppUri),
  Member(7,7,'kardelen', ppUri),
  Member(8,8,'emre', ppUri),
];

// Doctors:
List<Doctor> doctors = [
  Doctor(1, 9,'Oguzhan Senol', categories[0],'Sisli Etfal Hospital'),
  Doctor(2, 10, 'Ozan Kilic', categories[1], 'Basaksehir Cam ve Sakura Hastanesi'),
  Doctor(3, 11, 'Sinan Kerem Gunduz', categories[2], 'Zeynep Kamil Hastanesi'),
  Doctor(4, 12, 'Yavuz Samet Topcuoglu', categories[3], 'Baltalimani Hastanesi')
];

// Articles:
List<Article> articles = [
  Article(
    1,
    engin,
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    2,
    ozan,
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    3,
    sinan,
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    4,
    samet,
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
  ),
];


// Mock Post Data:
List<Post> posts = [
  Post(
    1,
    kardelen,
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
    isDoctorReplied : true,
  ),
  Post(
    2,
    burak,
    DateTime.utc(2022, 2, 11),
    'Lotion For Hair Eczema',
    'I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do? away? Please help',
    upvotes : 6,
    downvotes : 2,
    isDoctorReplied : false,
  ),
  Post(
    3,
    canberk,
    DateTime.utc(2022, 3, 17),
    'Face Numbing and Blurred Vision',
    'I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is .....',
    upvotes : 16,
    downvotes : 1,
    isDoctorReplied : false,
  ),
  Post(
    4,
    emre,
    DateTime.utc(2022, 3, 21),
    'Iron Level in my Blood Test',
    'As a result of the blood test I had, iron was found to be 211.117. Ferritin 53.99. My doctor said it was not anemia. Is it normal for iron to be this high? What do you suggest?',
    upvotes : 7,
    downvotes : 2,
    isDoctorReplied : true,
  ),
];

// Comments:
List<Comment> comments = [
  Comment(
    1,
    posts[0],
    users[0],
    DateTime.utc(2022, 3, 22),
    'Comment1'
  ),
  Comment(
    2,
    posts[0],
    users[1],
    DateTime.utc(2022, 3, 23),
    'Comment2'
  ),
  Comment(
    3,
    posts[0],
    users[2],
    DateTime.utc(2022, 3, 25),
    'Comment3'
  ),
];