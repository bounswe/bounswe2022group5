import 'package:bounswe5_mobile/models/category.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/models/memberInfo.dart';
import 'package:bounswe5_mobile/models/post.dart';
import 'package:bounswe5_mobile/models/article.dart';
import 'package:bounswe5_mobile/models/comment.dart';
import 'package:flutter/gestures.dart';


// Categories:
Category allergy = Category(1,'Allergy and Immunology', '');
Category anesthesiology = Category(2,'Anesthesiology', '');
Category dermatology = Category(3,'Dermatology','');
Category radiology = Category(4,'Diagnostic Radiology', '');
Category emergency = Category(5,'Emergency Medicine', '');
Category family = Category(6,'Family Medicine', '');
Category internal = Category(7,'Internal Medicine', '');
Category genetics = Category(8,'Medical Genetics', '');
Category neurology = Category(9,'Neurology', '');
Category nuclear = Category(10,'Nuclear Medicine', '');

List<Category> categories = [
  allergy, anesthesiology, dermatology, radiology, emergency, family, internal,
  genetics, neurology, nuclear
];

PostAuthor pa = PostAuthor(1, "https://api.multiavatar.com/7.svg?apikey=BWcb3EHf8CruYh", '', false);
ArticleAuthor aa = ArticleAuthor(2, "Ali Veli", "https://api.multiavatar.com/7.svg?apikey=BWcb3EHf8CruYh");
// Members:
int ppUri = 1;
List<User> members = [
  User(1, '', 'canberk@gmail.com', 1, memberid: 1, username: 'canberk'),
  User(2, '', 'bengin@gmail.com', 1, memberid:2, username: 'bengin'),
  User(3, '', 'burak@gmail.com', 1, memberid:3, username: 'burak'),
  User(4, '', 'engin@gmail.com',1, memberid:4, username: 'engin'),
  User(5, '', 'halil@gmail.com',1, memberid: 5, username: 'halil'),
  User(6, '', 'irfan@gmail.com',1, memberid: 6, username: 'irfan'),
  User(7, '', 'kardelen@gmail.com',1, memberid: 7, username: 'kardelen'),
  User(8, '', 'emre@gmail.com',1, memberid: 8, username: 'emre'),
];

// Doctors:
List<User> doctors = [
  User(9, '', 'oguzhan@gmail.com', 2, doctorid: 1, fullName: 'Oguzhan Senol', specialization: categories[0], hospitalName: 'Sisli Etfal Hospital'),
  User(10, '', 'ozan@gmail.com',2, doctorid: 2, fullName: 'Ozan Kilic', specialization: categories[1], hospitalName:'Basaksehir Cam ve Sakura Hastanesi'),
  User(11, '', 'sinan@gmail.com',2, doctorid: 3, fullName: 'Sinan Kerem Gunduz', specialization: categories[2], hospitalName: 'Zeynep Kamil Hastanesi'),
  User(12, '', 'samet@gmail.com',2, doctorid: 4, fullName: 'Yavuz Samet Topcuoglu', specialization: categories[3], hospitalName: 'Baltalimani Hastanesi')
];

// Articles:
List<Article> articles = [
  Article(
    1,
    DateTime.utc(2022, 03, 7),
    'Alcaline Diet',
    '''The alkaline diet is also known as the acid-alkaline diet or alkaline ash diet.

    Its premise is that your diet can alter the pH value — the measurement of acidity or alkalinity — of your body.

  Your metabolism — the conversion of food into energy — is sometimes compared to fire. Both involve a chemical reaction that breaks down a solid mass.

    However, the chemical reactions in your body happen in a slow and controlled manner.

    ''',
    aa,
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    2,
    DateTime.utc(2022, 03, 7),
    'How to Give Up Smoking?',
    '''For most people who use tobacco, tobacco cravings or smoking urges can be strong. But you can stand up against these cravings.

When you feel an urge to use tobacco, keep in mind that even though the urge may be strong, it will likely pass within 5 to 10 minutes whether or not you smoke a cigarette or take a dip of chewing tobacco. Each time you resist a tobacco craving, you're one step closer to stopping tobacco use for good.

Here are 10 ways to help you resist the urge to smoke or use tobacco when a craving strikes.''',
    aa,
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    3,
    DateTime.utc(2022, 03, 7),
    'What is PDW Test?',
    '''Your blood carries a wealth of information. 
    That’s why certain blood tests can detect conditions of concern before symptoms appear. 
    For example, tumor markers in your blood can help doctors figure out which treatment might work best for your cancer, indicate your prognosis or reveal whether your cancer has returned or gone into remission.''',
    aa,
    upvotes : 13,
    downvotes : 7,
  ),
  Article(
    4,
    DateTime.utc(2022, 03, 7),
    'What is Agoraphobia? very very very very very very very long title',
    '''Agoraphobia is a fear of being in situations where escape might be difficult or that help wouldn't be available if things go wrong.

Many people assume agoraphobia is simply a fear of open spaces, but it's actually a more complex condition.

Someone with agoraphobia may be scared of:

travelling on public transport
visiting a shopping centre
leaving home
If someone with agoraphobia finds themselves in a stressful situation, they'll usually experience the symptoms of a panic attack, such as:

rapid heartbeat
rapid breathing (hyperventilating)
feeling hot and sweaty
feeling sick
They'll avoid situations that cause anxiety and may only leave the house with a friend or partner. They'll order groceries online rather than going to the supermarket. This change in behaviour is known as avoidance.

Read more about the symptoms of agoraphobia.

What causes agoraphobia?
Agoraphobia can develop as a complication of panic disorder, an anxiety disorder involving panic attacks and moments of intense fear. It can arise by associating panic attacks with the places or situations where they occurred and then avoiding them.

Not all people with agoraphobia have a history of panic attacks. In these cases, their fear may be related to issues like a fear of crime, terrorism, illness or being in an accident.

Read more about the possible causes of agoraphobia.

Diagnosing agoraphobia
Speak to your GP if you think you may be affected by agoraphobia. It should be possible to arrange a telephone consultation if you don't feel ready to visit your GP in person.

Your GP will ask you to describe your symptoms, how often they occur, and in what situations. It's very important you tell them how you've been feeling and how your symptoms are affecting you.

Your GP may ask you the following questions:

Do you find leaving the house stressful?
Are there certain places or situations you have to avoid?
Do you have any avoidance strategies to help you cope with your symptoms, such as relying on others to shop for you?
It can sometimes be difficult to talk about your feelings, emotions, and personal life, but try not to feel anxious or embarrassed. Your GP needs to know as much as possible about your symptoms to make the correct diagnosis and recommend the most appropriate treatment.

Read more about diagnosing agoraphobia.

Treating agoraphobia
Lifestyle changes may help, including taking regular exercise, eating more healthily, and avoiding alcohol, drugs and drinks that contain caffeine, such as tea, coffee and cola.

Self-help techniques that can help during a panic attack include staying where you are, focusing on something that's non-threatening and visible, and slow, deep breathing.

If your agoraphobia fails to respond to these treatment methods, see your GP.

You can also refer yourself directly for psychological therapies, including cognitive behavioural therapy (CBT), without seeing your GP.

Read more about psychological therapies on the NHS

Medication may be recommended if self-help techniques and lifestyle changes aren't effective in controlling your symptoms. You'll usually be prescribed a course of selective serotonin reuptake inhibitors (SSRIs), which are also used to treat anxiety and depression.

In severe cases of agoraphobia, medication can be used in combination with other types of treatment, such as CBT and relaxation therapy.

Read more about treating agoraphobia.''',
    aa,
    upvotes : 13,
    downvotes : 7,
  ),
];


// Mock Post Data:
List<Post> posts = [
  Post(
    1,
    pa,
    DateTime.utc(2022, 03, 7),
    'Acnelyste Burns Occurred',
    'I have been using ACNELYSTE for about 2 months, my cheeks were burning while I was using it, but there was no redness. I applied more than a pea pod and I got a rash on my cheek. Will this redness go away? Please help',
    upvotes : 13,
    downvotes : 7,
    isDoctorReplied : true,
  ),
  Post(
    2,
    pa,
    DateTime.utc(2022, 2, 11),
    'Lotion For Hair Eczema',
    'I have eczema in my hair for years, I have used lotions such as conazole, but it did not work much, what should I do? away? Please help',
    upvotes : 6,
    downvotes : 2,
    isDoctorReplied : false,
  ),
  Post(
    3,
    pa,
    DateTime.utc(2022, 3, 17),
    'Face Numbing and Blurred Vision',
    'I had corona a year and a half ago, then my eyes deteriorated, one side always sees blurry, on that side there is a cramp-like pain that never goes away on the side where the upper jaw bone joins, sometimes there is .....',
    upvotes : 16,
    downvotes : 1,
    isDoctorReplied : false,
  ),
  Post(
    4,
    pa,
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