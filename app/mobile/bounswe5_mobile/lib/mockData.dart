import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/doctor.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';
import 'package:bounswe5_mobile/models/member.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/models/comment.dart';


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
  Member(1,'','canberk@gmail.com',1, 1,'canberk',ppUri),
  Member(2, '', 'bengin@gmail.com',1, 2,'bengin', ppUri),
  Member(3, '', 'burak@gmail.com',1, 3,'burak', ppUri),
  Member(4, '', 'engin@gmail.com',1, 4,'engin', ppUri),
  Member(5, '', 'halil@gmail.com',1, 5,'halil', ppUri),
  Member(6, '', 'irfan@gmail.com',1, 6,'irfan', ppUri),
  Member(7, '', 'kardelen@gmail.com',1, 7,'kardelen', ppUri),
  Member(8, '', 'emre@gmail.com',1, 8,'emre', ppUri),
];

// Doctors:
List<Doctor> doctors = [
  Doctor(9, '', 'oguzhan@gmail.com',2,1,'Oguzhan Senol', categories[0],'Sisli Etfal Hospital'),
  Doctor(10, '', 'ozan@gmail.com',2,2, 'Ozan Kilic', categories[1], 'Basaksehir Cam ve Sakura Hastanesi'),
  Doctor(11, '', 'sinan@gmail.com',2,3, 'Sinan Kerem Gunduz', categories[2], 'Zeynep Kamil Hastanesi'),
  Doctor(12, '', 'samet@gmail.com',2,4, 'Yavuz Samet Topcuoglu', categories[3], 'Baltalimani Hastanesi')
];

// Articles:
List<Article> articles = [
  Article(
    1,
    doctors[0],
    DateTime.utc(2022, 03, 7),
    'Alcaline Diet',
    '''The alkaline diet is also known as the acid-alkaline diet or alkaline ash diet.

    Its premise is that your diet can alter the pH value — the measurement of acidity or alkalinity — of your body.

  Your metabolism — the conversion of food into energy — is sometimes compared to fire. Both involve a chemical reaction that breaks down a solid mass.

    However, the chemical reactions in your body happen in a slow and controlled manner.

    ''',
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    2,
    doctors[1],
    DateTime.utc(2022, 03, 7),
    'How to Give Up Smoking?',
    '''For most people who use tobacco, tobacco cravings or smoking urges can be strong. But you can stand up against these cravings.

When you feel an urge to use tobacco, keep in mind that even though the urge may be strong, it will likely pass within 5 to 10 minutes whether or not you smoke a cigarette or take a dip of chewing tobacco. Each time you resist a tobacco craving, you're one step closer to stopping tobacco use for good.

Here are 10 ways to help you resist the urge to smoke or use tobacco when a craving strikes.''',
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    3,
    doctors[2],
    DateTime.utc(2022, 03, 7),
    'What is PDW Test?',
    '''Your blood carries a wealth of information. 
    That’s why certain blood tests can detect conditions of concern before symptoms appear. 
    For example, tumor markers in your blood can help doctors figure out which treatment might work best for your cancer, indicate your prognosis or reveal whether your cancer has returned or gone into remission.''',
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    4,
    doctors[3],
    DateTime.utc(2022, 03, 7),
    'What is Agoraphobia?',
    '''Agoraphobia is a fear of being in situations where escape might be difficult or that help wouldn't be available if things go wrong.

Many people assume agoraphobia is simply a fear of open spaces, but it's actually a more complex condition.

Someone with agoraphobia may be scared of:

travelling on public transport
visiting a shopping centre
leaving home''',
    upvotes : 13,
    downvotes : 7,
  ),
];


// Mock Post Data:
List<Post> posts = [
  Post(
    1,
    members[0],
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
    isDoctorReplied : true,
  ),
  Post(
    2,
    members[1],
    DateTime.utc(2022, 2, 11),
    'Lotion For Hair Eczema',
    'I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do? away? Please help',
    upvotes : 6,
    downvotes : 2,
    isDoctorReplied : false,
  ),
  Post(
    3,
    members[2],
    DateTime.utc(2022, 3, 17),
    'Face Numbing and Blurred Vision',
    'I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is .....',
    upvotes : 16,
    downvotes : 1,
    isDoctorReplied : false,
  ),
  Post(
    4,
    members[3],
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
    members[1],
    DateTime.utc(2022, 3, 22),
    'Comment1'
  ),
  Comment(
    2,
    posts[0],
    members[2],
    DateTime.utc(2022, 3, 23),
    'Comment2'
  ),
  Comment(
    3,
    posts[0],
    members[3],
    DateTime.utc(2022, 3, 25),
    'Comment3'
  ),
];