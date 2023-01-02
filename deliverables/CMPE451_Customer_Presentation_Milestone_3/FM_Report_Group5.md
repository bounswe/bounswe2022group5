
  

# CMPE 451 - Group 5 - Final Milestone Report

  

  

## Executive Summary
 

### Summary of The Project Status

#### Introduction
We are a group of 12 computer engineering students from Boğaziçi University who are taking the course “Project Development in Software Engineering” in the 2022 fall term. We have created a medical experience sharing platform for this course.

This is the final milestone of our project in this semester. It includes all progress so far and the deliverables.

#### Description
Our platform provides its users an environment to share their medical experiences with each other, being informed about medical topics and also gives them the opportunity to receive responses from verified doctors. Anyone can use Android and the web versions of our application without being charged.

Anyone can register to our platform. There are two types of registered users; doctors and members.  Every registered user has their own profile pages. While registered users can benefit from all the features of our application, guest users can use some of them.
There are three different parts that can be utilized in our application. First one is the Forum. In the forum, any registered user can share their medical experiences and get responses from other users including verified doctors. All users are able to view other discussion threads in the forum and make comments or upvote/downvote them. The second part is the Articles. Only doctors can publish an article in this part. All users can read an article on the platform and upvote/downvote it. The third part is the Chatbot. Register users are able to reach posts, articles and doctors related to the options they choose from the chatbot decision tree. Forum is the home page of our platform. The other parts can be reached through the buttons in the home page. 

After Milestone 2 we have decided to implement doctor profiles, better labeling system, better search system,category follow, annotation and semantic search features. Apart from this, we carefully analyzed the feedbacks and decided to make the necessary corrections and bugfixes. 
For Final Milestone, we have determined as a roadmap to satisfy the requirements we have defined as the basis and present them in a demo accompanied by a comprehensive scenario. 

The detailed explanation of all features implemented are on Final Release Notes.

The project is maintained by a REST API developed by our backend team and presented as a web application by our frontend team and as a mobile Android application by our mobile team.


### Status of The Deliverables



### Final Release Notes

Main functionalities of the application are given below:

- Signup / Login / Logout
- Post create, read, update, delete, upvote, downvote operations in the _Forum_ section
- Comment create, read, delete, upvote, downvote operations in the _Forum_ section
- Article create, read, delete, upvote, downvote operations in the _Articles_ section
- Adding images and location info to posts, comments, articles
- Showing upvoted articles, posts, comments of a user
- Editing user profile (profile image, medical history, personal info)
- Following categories
- Search bar have been optimized with category follow, user search and search by geolocation.
- Doctor Profile with posts, articles of them. Other profile features enabled here.
- Text Annotation
- Image Annotation
- Tag(Label) Suggestion with Semantic Search using [National Library of Medicine Ontology](https://www.nlm.nih.gov/)
- Chatbot Support
- Account Delete

All users can read posts or comment on Forum, articles on Articles page, however only registered users can create, edit and delete them.

Images and locations can be added to posts, comments and articles. Also text can be written in html format with hyperlinks, bold font, different size etc.

Registered Users can also upvote or downvote post, articles and comments.

Registered Users have profiles and doctor profiles are visible for every user. Profile picture, personal info and medical history is the core part of user profile. Also posts, comments of user and upovoted posts and articles are available in profile page. Accounts can be edited or deleted.

There are also tags and a category can be added to discussion threads and articles. In the posts, our system can suggest some related tags to users and redirects them to wiki page of the tag. This is done via semantic search using ontology of [National Library of Medicine](https://www.nlm.nih.gov/). All the tags related that post are visible in the post page.

Users search the posts with gelocation, tags, category, title, body and user of the post. Search is very optimized and works very well. Also category follow is implemented and following categories are used in the algorithm of Forum Page.

Text Annotation and Image Annotation is available with create, edit and delete feature. Users see all annotation of a post. Standard and schema is explained in Annotation Section of the Report.

Chatbot was implemented in order to support users that don't have any idea about web site and categories. It can help users to find related posts about their disease and problems. It works as a decision tree with respect to input from user.

  

### Changes and Improvements Since Milestone 2

For Milestone 2, we could not finish the Annotations although we plan to finish.

One of the reasons for this was that Front, Mobile and Backend had problems with synchronization. This was very important, especially as we needed to work together to determine annotation schema and understand the W3 Data Model. After Milestone 2, we determined the topics that we need to align and put them in a higher priority order.

Prioritizing actions in this way allowed us to see the process more clearly and enabled us to develop many features for the final milestone, along with the annotation feature.

Apart from that, every member of the team tried to do their best for the final milestone and we found an increase in responsibility awareness.
  

### Reflections

We knew that Final Milestone, unlike other Milestones, is a point where we would present the final and main version of our project and explain all the features using potential scenarios over a product we can call MVP. 

In this direction, we focused our work on combining the separate parts and finishing the product we promised. So, we realized how helpful the documentation, notes and other wiki items throughout the term were. 

We were able to successfully plan Final Milestone because we knew what we were doing and how quickly we were working backwards. The existence of such an experience, especially in order for the teams to align, is very beneficial for the developing a product that can be described as a final. 

Another lesson we learned is how important feedback from previous milestones and presentations is. In particular, we tried to apply what we learned from these notes we took during the presentation in the last demos. Preparing a comprehensive scenario, not boring the audience and making an effective introduction form the basis of our methods for the last milestone.

### What Could Be Done Differently

Since we developed our final product to meet the requirements we set at the beginning, we see the project development process since start of term as a successful process. This is because of things we talked about above. But as with any project development process, we recognize that there are things to do better or different. 

At the beginning of the term, we formed the teams with an equal number of members. However, adding more people to the frontend team, which requires a lot of effort, and especially the mobile development team where new technologies are learned, could speed up the work. In this direction, we could have given more importance to UI and visuality. 

We could have started using Postman at the beginning of the year. We are currently using all APIs and documentation via Postman and are quite satisfied.


## Progress Based on Teamwork

  

*  ### A Summary of work performed by each team member

  

  

#### Mehmet Emre Akbulut

  

|Issue Title|Link|
|-----|:--------:|
|Revising Scenarios and Mockup|[#170](https://github.com/bounswe/bounswe2022group5/issues/170)|
|Making adjustments on Scenarios and Mockup w.r.t requirements|[#182](https://github.com/bounswe/bounswe2022group5/issues/182)|
|Backend Team Meeting Time and Platform Decision|[#183](https://github.com/bounswe/bounswe2022group5/issues/183)|
|Creating a Pull Request Template|[#184](https://github.com/bounswe/bounswe2022group5/issues/184)|
|Creating Backend Initial Project|[#187](https://github.com/bounswe/bounswe2022group5/issues/187)|
|Rearranging Repo Structure|[#188](https://github.com/bounswe/bounswe2022group5/issues/188)|
|Creating requirements.txt for backend development|[#195](https://github.com/bounswe/bounswe2022group5/issues/195)|
|Creating 'authentication' module inside the project|[#204](https://github.com/bounswe/bounswe2022group5/issues/204)|
|Implementing Token Authentication with Django Rest Framework|[#205](https://github.com/bounswe/bounswe2022group5/issues/205)|
|Creating the API documentation for Signup|[#206](https://github.com/bounswe/bounswe2022group5/issues/206)|
|Opening a wiki page for the Tech Stack|[#210](https://github.com/bounswe/bounswe2022group5/issues/210)|
|Implementing Login and Signup Endpoints|[#218](https://github.com/bounswe/bounswe2022group5/issues/218)|
|Implementing and Documenting 'me' API|[#236](https://github.com/bounswe/bounswe2022group5/issues/236)|
|Enabling CORS headers|[#238](https://github.com/bounswe/bounswe2022group5/issues/238)|
|Creating Scenario 1 for Milestone 1|[#268](https://github.com/bounswe/bounswe2022group5/issues/268)|
|Milestone 1 Evaluation of Status of Deliverables|[#285](https://github.com/bounswe/bounswe2022group5/issues/285)|
|Implementing Create, Update, Read and Delete operations related with Post.|[Issue #290](https://github.com/bounswe/bounswe2022group5/issues/290)|
|Implementing Create, Update, Read and Delete operations related with Articles.|[Issue #303](https://github.com/bounswe/bounswe2022group5/issues/303)|
|Search about what is the best practice of Documentation. Created Postman Doc.|[Issue #305](https://github.com/bounswe/bounswe2022group5/issues/305)|
|Revising Auth APIs for guest users.|[Issue #309](https://github.com/bounswe/bounswe2022group5/issues/309)|
|Extending upvote-downvote system for comments.|[Issue #324](https://github.com/bounswe/bounswe2022group5/issues/324)|
|Fixing bugs and communication problems with app (mainly related to Posts and Articles).|[Issue #338](https://github.com/bounswe/bounswe2022group5/issues/338)|
|Response formatting for Profile, Posts and Articles.|[Issue #366](https://github.com/bounswe/bounswe2022group5/issues/366)|
|Implementing Catalogs and Labels.|[Issue #383](https://github.com/bounswe/bounswe2022group5/issues/383)|
|Creating scenarios with team members and preparing for demos.|[Issue #401](https://github.com/bounswe/bounswe2022group5/issues/401)|
|Refactoring after Milestone 2|[Issue #434](https://github.com/bounswe/bounswe2022group5/issues/434)|
|Creating Initial Annotation Endpoints and util functions|[Issue #436](https://github.com/bounswe/bounswe2022group5/issues/436)|
|Implementing Annotation Data Model, CRUD operations|[Issue #453](https://github.com/bounswe/bounswe2022group5/issues/453)|
|Implementing feature that enables fetching upvoted posts and articles by user id|[Issue #467](https://github.com/bounswe/bounswe2022group5/issues/467)|
|Annotation Schema Bugfix|[Issue #469](https://github.com/bounswe/bounswe2022group5/issues/469)|
|Adding user search to Search|[Issue #475](https://github.com/bounswe/bounswe2022group5/issues/475)|
|Implementing Semantic Search with labeling system and [National Library of Medicine Ontology](https://www.nlm.nih.gov/)|[Issue #484](https://github.com/bounswe/bounswe2022group5/issues/484)|
|Documenting Standard and Annotations for Final Milestone|[Issue #544](https://github.com/bounswe/bounswe2022group5/issues/544)|
|Documenting API Documentation and Collection for Final Milestone|[Issue #545](https://github.com/bounswe/bounswe2022group5/issues/545)|
|Documenting Executive Summary for Final Milestone|[Issue #546](https://github.com/bounswe/bounswe2022group5/issues/546)|
 
|Pull Request Title|Link|
|-----|:--------:|
|Requirements added to repo|[#196](https://github.com/bounswe/bounswe2022group5/pull/196)|
|Authentication Module Created|[#208](https://github.com/bounswe/bounswe2022group5/pull/208)|
|token auth and initial authentication|[#211](https://github.com/bounswe/bounswe2022group5/pull/211)|
|login and signup endpoints finished|[#219](https://github.com/bounswe/bounswe2022group5/pull/219)|
|Cors headers added|[#239](https://github.com/bounswe/bounswe2022group5/pull/239)|
|Me endpoint added|[#242](https://github.com/bounswe/bounswe2022group5/pull/242)|
|Implementing Create, Update, Read and Delete operations related with Post.|[#291](https://github.com/bounswe/bounswe2022group5/pull/291)|
|Implementing Create, Update, Read and Delete operations related with Articles.|[#304](https://github.com/bounswe/bounswe2022group5/pull/304)|
|Revising Auth APIs for guest users.|[#311](https://github.com/bounswe/bounswe2022group5/pull/311)|
|Extending upvote-downvote system for comments.|[#328](https://github.com/bounswe/bounswe2022group5/pull/328)|
|Fixing bugs and communication problems with app (mainly related to Posts and Articles).|[#344](https://github.com/bounswe/bounswe2022group5/pull/344)|
|Adding voting info to post and comments.|[#348](https://github.com/bounswe/bounswe2022group5/pull/348)|
|Response formatting for Profile, Posts and Articles.|[#378](https://github.com/bounswe/bounswe2022group5/pull/378)|
|Fixing responses and implementing Search.|[#381](https://github.com/bounswe/bounswe2022group5/pull/381)|
|Implementing Catalogs and Labels.|[#403](https://github.com/bounswe/bounswe2022group5/pull/403)|
|Refactoring and Bug Fixes|[#435](https://github.com/bounswe/bounswe2022group5/pull/435)|
|Annotation Data Model and Endpoints|[#454](https://github.com/bounswe/bounswe2022group5/pull/454)|
|Fetching Upvoted Articles and Post by User Id|[#468](https://github.com/bounswe/bounswe2022group5/pull/468)|
|Annotation Bugfix|[#470](https://github.com/bounswe/bounswe2022group5/pull/470)|
|User search added to Search|[#476](https://github.com/bounswe/bounswe2022group5/pull/476)|
|User search added to Search|[#477](https://github.com/bounswe/bounswe2022group5/pull/477)|
|Semantic Search Labels and Other Search Features|[#485](https://github.com/bounswe/bounswe2022group5/pull/485)|
|Urgent Bugfix about Annotation API|[#537](https://github.com/bounswe/bounswe2022group5/pull/537)|

  

  

#### Alper Canberk Balcı

  

|Issue Title|Link|
|-----|:--------:|
| | |

  

  

|Pull Request Title|Link|
|-----|:--------:|
| | |

  

  

#### Baver Bengin Beştaş

  

|Issue Title|Link|
|-----|:--------:|
| | |

  

  

|Pull Request Title|Link|
|-----|:--------:|
| | |

  

  

#### İrfan Bozkurt

This section only includes my work for the last milestone. In addition, not all my efforts have a corresponding issue or PR. Sometimes I needed to do something quick, or, the nature of the issue wasn't suitable to be planned or tracked.

To see all my work please visit [my personal efforts wiki page](https://github.com/bounswe/bounswe2022group5/wiki/Irfan-Bozkurt)

|Issue Title|Link|
|-----|:--------:|
|Registration Bugfix | [#443](https://github.com/bounswe/bounswe2022group5/issues/443) |
|Geospatial search - Research | [#440](https://github.com/bounswe/bounswe2022group5/issues/440) |
|Refactor search code | [#445](https://github.com/bounswe/bounswe2022group5/issues/445) |
|Geospatial search implementation | [#447](https://github.com/bounswe/bounswe2022group5/issues/447)
|Get All Posts Bug | [#495](https://github.com/bounswe/bounswe2022group5/issues/495)
|Software Package for Backend | [#543](https://github.com/bounswe/bounswe2022group5/issues/543)

|Pull Request Title|Link|
|-----|:--------:|
|Registration Bugfix | [#444](https://github.com/bounswe/bounswe2022group5/pull/444)
|Search query simplified | [#446](https://github.com/bounswe/bounswe2022group5/pull/446)
|Post search based on distance | [#450](https://github.com/bounswe/bounswe2022group5/pull/450/files)
|Get All Posts Bug | [#498](https://github.com/bounswe/bounswe2022group5/pull/498)

  

  

#### Kardelen Demiral

  

  

|Issue Title|Link|
|-----|:--------:|
|Updating Wiki Sidebar|[#172](https://github.com/bounswe/bounswe2022group5/issues/172)|
|Adding new tabs to the sidebar for Backend, Frontend and Mobile Team Meetings|[#176](https://github.com/bounswe/bounswe2022group5/issues/176)|
|Creating a Sign-up Screen - Mobile|[#193](https://github.com/bounswe/bounswe2022group5/issues/193)|
|Font Suggestions|[#209](https://github.com/bounswe/bounswe2022group5/issues/209)|
|Adding user type selection for Signup - Mobile|[#216](https://github.com/bounswe/bounswe2022group5/issues/216)|
|Adding Branch Field to Sign-up From for Doctors - Mobile|[#221](https://github.com/bounswe/bounswe2022group5/issues/221)|
|Editing the README file for mobile development|[#234](https://github.com/bounswe/bounswe2022group5/issues/234)|
|Adding an API service class to the mobile app|[#240](https://github.com/bounswe/bounswe2022group5/issues/240)|
|Handling the register API call for mobile|[#245](https://github.com/bounswe/bounswe2022group5/issues/245)|
|[Mobile] Login pages being on top of each other after sign-up needs to be fixed|[#277](https://github.com/bounswe/bounswe2022group5/issues/277)|
|[Mobile] Finalizing the Sign-up Page|[#293](https://github.com/bounswe/bounswe2022group5/issues/293)|
|[Mobile] Implementing mobile Post and Article Creation Pages|[#294](https://github.com/bounswe/bounswe2022group5/issues/294)|
|[Mobile] API Connection of Create Article and Create Post pages|[#330](https://github.com/bounswe/bounswe2022group5/issues/330)|
|[Mobile] Finalizing Signup API calls|[#352](https://github.com/bounswe/bounswe2022group5/issues/352)|
|[Mobile] Comment create page should be created|[#358](https://github.com/bounswe/bounswe2022group5/issues/358)|
|[Mobile] Upvote/Downvote functionalities should be implemented|[#359](https://github.com/bounswe/bounswe2022group5/issues/359)|
|[Mobile] Post/Comment/Article deletion functionalities should be implemented|[#360](https://github.com/bounswe/bounswe2022group5/issues/360)|
|[Mobile] Article/Post adding categories and labels|[#393](https://github.com/bounswe/bounswe2022group5/issues/393)|
|Milestone 2 Presentation Notes|[#428](https://github.com/bounswe/bounswe2022group5/issues/428)|
|[Mobile] Comment deletion functionality|[#456](https://github.com/bounswe/bounswe2022group5/issues/456)|
|[Mobile] Search Functionality Implementation|[#458](https://github.com/bounswe/bounswe2022group5/issues/458)|
|[Mobile] Category label will be added under post body|[#473](https://github.com/bounswe/bounswe2022group5/issues/473)|
|[Mobile] Category name overflow bugfix|[#515](https://github.com/bounswe/bounswe2022group5/issues/515)|

  

  

|Pull Request Title|Link|
|-----|:--------:|
|Mobile/feature/sign up screen #193|[#215](https://github.com/bounswe/bounswe2022group5/pull/215)|
|Branch field is added for doctor sign-up|[#222](https://github.com/bounswe/bounswe2022group5/pull/222)|
|API service class is added to the mobile app|[#244](https://github.com/bounswe/bounswe2022group5/pull/244)|
|Register API call for mobile is handled|[#255](https://github.com/bounswe/bounswe2022group5/pull/255)|
|Login pages being on top of each other after sign-up is fixed|[#278](https://github.com/bounswe/bounswe2022group5/pull/278)|
|[Mobile] Initial implementations of "create post" and "create article" pages #294|[#296](https://github.com/bounswe/bounswe2022group5/pull/296)|
|Mobile/feature/create post article api calls#330|[#350](https://github.com/bounswe/bounswe2022group5/pull/350)|
|[Mobile] KVKK and Document Upload for Signup added|[#351](https://github.com/bounswe/bounswe2022group5/pull/351)|
|[Mobile] Singup is finalized|[#354](https://github.com/bounswe/bounswe2022group5/pull/354)|
|[Mobile] Comment Create Functionality Added|[#368](https://github.com/bounswe/bounswe2022group5/pull/368)|
|[Mobile] Create post and create article are revised|[#395](https://github.com/bounswe/bounswe2022group5/pull/395)|
|[Mobile] Upvote/Downvote Implemented|[#415](https://github.com/bounswe/bounswe2022group5/pull/415)|
|[Mobile] Post/Article Delete Implemented|[#419](https://github.com/bounswe/bounswe2022group5/pull/419)|
|[Mobile] Category label's for post and article|[#474](https://github.com/bounswe/bounswe2022group5/pull/474)|
|[Mobile] Search functionality implemented|[#487](https://github.com/bounswe/bounswe2022group5/pull/487)|
|[Mobile] Category name overflow is fixed #515|[#516](https://github.com/bounswe/bounswe2022group5/pull/516)|
|[Mobile] Comment deletion functionality implemented #456|[#519](https://github.com/bounswe/bounswe2022group5/pull/519)|

  

  

#### Oğuzhan Demirel

  

  

|Issue Title|Link|
|-----|:--------:|
  |Analyzing the Backend code conventions page and giving some feedbacks about the document|[#262](https://github.com/bounswe/bounswe2022group5/issues/262)|
  |Making changes on [Pull Request Template](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-2-for-Milestone-1), and clarify some topics|[#184](https://github.com/bounswe/bounswe2022group5/issues/184)|
  |Reviewing the [Login](https://github.com/bounswe/bounswe2022group5/wiki/Login-API-Documentation) and [Signup](https://github.com/bounswe/bounswe2022group5/wiki/Signup-API-Documentation) Documentation and giving some suggestions about error cases.|[#218](https://github.com/bounswe/bounswe2022group5/issues/218)|
  |Reviewing the [Scenario 2](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-2-for-Milestone-1), and giving some suggestions about that.|[#266](https://github.com/bounswe/bounswe2022group5/issues/266)|
  |Analyze the [Use Case Diagram](https://github.com/bounswe/bounswe2022group5/wiki/Use-Case-Diagram).|[#178](https://github.com/bounswe/bounswe2022group5/issues/178)|
  | [Backend] Upvote and Downvote enpoints for Posts|[#313](https://github.com/bounswe/bounswe2022group5/issues/313)|
  |[Backend] Implemented voting system for Articles.|[#312](https://github.com/bounswe/bounswe2022group5/issues/312)|
  |[Backend] Improvements on voting system. Extra functionalities added on voting system. Some fields added on User, DB schema changed.|[#329](https://github.com/bounswe/bounswe2022group5/issues/329)|
  |[Backend] Implemented an endpoint for get a doctor's all articles. It is used for doctor's profile page.|[#355](https://github.com/bounswe/bounswe2022group5/pull/355)|
|[Backend] Category Follow Implementation|[#431](https://github.com/bounswe/bounswe2022group5/issues/431)|
|[Backend] Followed Categories Endpoint|[#441](https://github.com/bounswe/bounswe2022group5/issues/441)|
|[Backend] Bookmark a Post implementation|[#462](https://github.com/bounswe/bounswe2022group5/issues/462)|
|[Backend] Bookmark an Article|[#471](https://github.com/bounswe/bounswe2022group5/issues/471)|
|[Backend] Delete account function|[#492](https://github.com/bounswe/bounswe2022group5/issues/492)|

  

  

|Pull Request Title|Link|
|-----|:--------:|
|[Backend] Category Follow Implementation|[#437](https://github.com/bounswe/bounswe2022group5/pull/437)|
|[Backend] Followed Categories Endpoint|[#442](https://github.com/bounswe/bounswe2022group5/pull/442)|
|[Backend] Bookmark a Post implementation|[#463](https://github.com/bounswe/bounswe2022group5/pull/463)|
|[Backend] Bookmark an Article|[#472](https://github.com/bounswe/bounswe2022group5/pull/472)|
|[Backend] Delete account function|[#494](https://github.com/bounswe/bounswe2022group5/pull/494)|
  |[Backend] Vote endpoints for Posts|[#321](https://github.com/bounswe/bounswe2022group5/pull/321)|
  | [Backend] Vote endpoints for Article|[#314](https://github.com/bounswe/bounswe2022group5/pull/314)|
  | [Backend] Voting feature improvements|[#331](https://github.com/bounswe/bounswe2022group5/pull/331)|
  | [Backend] Get a doctor's all articles|[#355](https://github.com/bounswe/bounswe2022group5/pull/355)|

  

  

#### Sinan Kerem Gündüz

  

  

|Issue Title|Link|
|-----|:--------:|
| | |

  

  

|Pull Request Title|Link|
|-----|:--------:|
| | |

  

  

#### Ozan Kılıç

  

  

|Issue Title|Link|
|-----|:--------:|
| | |

  

  

|Pull Request Title|Link|
|-----|:--------:|
| | |

  

  

#### Burak Mert

  

  

|Issue Title|Link|
|-----|:--------:|
| Creating Login and Signup pages for Frontend|[#202](https://github.com/bounswe/bounswe2022group5/issues/202)|
| Aligning signup form fields with Mobile Team|[#214](https://github.com/bounswe/bounswe2022group5/issues/214)|
| [Frontend] Finalizing Login and Signup Page|[#289](https://github.com/bounswe/bounswe2022group5/issues/289)|
| [Frontend] Implementing Discussion Thread Page|[#323](https://github.com/bounswe/bounswe2022group5/issues/323)|
| [Frontend] Adding Geolocation Feature for Discussion Thread Page|[#364](https://github.com/bounswe/bounswe2022group5/issues/364)|
| [Frontend] Implementing Article Display Page|[#374](https://github.com/bounswe/bounswe2022group5/issues/374)|
| [Frontend] Initialization of Annotation Creation|[#455](https://github.com/bounswe/bounswe2022group5/issues/455)|
| [Frontend] Implementing Backend API Connection for Annotation Functionality|[#457](https://github.com/bounswe/bounswe2022group5/issues/457)|

  
  

|Pull Request Title|Link|
|-----|:--------:|
| Login and Signup Pages are implemented in Frontend|[#252](https://github.com/bounswe/bounswe2022group5/pull/252)|
| [Frontend] Discussion Thread Page is Implemented|[#349](https://github.com/bounswe/bounswe2022group5/pull/349)|
| [Frontend] Adding Geolocation Functionality for Discussion Thread Page|[#375](https://github.com/bounswe/bounswe2022group5/pull/375)|
| [Frontend] Implementing Article Display Page|[#392](https://github.com/bounswe/bounswe2022group5/pull/392)|
| [Frontend] Initialization of Annotation Creation|[#480](https://github.com/bounswe/bounswe2022group5/pull/480)|
| Implementing Backend Connections for Annotation Functionalities|[#481](https://github.com/bounswe/bounswe2022group5/pull/481)|

  


  

  


  

#### Halil Burak Pala

  

  

|Issue Title|Link|
|-----|--------|
|Updating Wiki Home Page |[#171](https://github.com/bounswe/bounswe2022group5/issues/171)|
|Revising the Class Diagram |[#181](https://github.com/bounswe/bounswe2022group5/issues/181)|
|Rearranging the Repo Structure and Branches For Collaborative Work |[#188](https://github.com/bounswe/bounswe2022group5/issues/188)|
|Creating initial mobile app structure |[#190](https://github.com/bounswe/bounswe2022group5/issues/190)|
|Creating a mobile home screen |[#192](https://github.com/bounswe/bounswe2022group5/issues/192)|
|Connecting all mobile pages |[#229](https://github.com/bounswe/bounswe2022group5/issues/229) |
|Using Personal Information and Logout API services in the home page |[#260](https://github.com/bounswe/bounswe2022group5/issues/260)|
|Creating Scenario 1 for Milestone 1 |[#268](https://github.com/bounswe/bounswe2022group5/issues/268)|
|Displaying user email in the home page's drawer head|[#279](https://github.com/bounswe/bounswe2022group5/issues/279)|
|Updating models and creating new ones |[#295](https://github.com/bounswe/bounswe2022group5/issues/295)|
|Creating articles home page |[#322](https://github.com/bounswe/bounswe2022group5/issues/322)|
|Updating the app theme |[#327](https://github.com/bounswe/bounswe2022group5/issues/327)|
|Changing model structure to have a single User class|[#340](https://github.com/bounswe/bounswe2022group5/issues/340)|
|Adding article creation floating button|[#341](https://github.com/bounswe/bounswe2022group5/issues/341)|
|Connecting post and article reading/creation pages to the home page|[#342](https://github.com/bounswe/bounswe2022group5/issues/342)|
|Implementing Home Page API connections|[#343](https://github.com/bounswe/bounswe2022group5/issues/343)|
|Updating the drawer |[#382](https://github.com/bounswe/bounswe2022group5/issues/382)|
|Getting posts and articles from backend|[#391](https://github.com/bounswe/bounswe2022group5/issues/391)|
|Getting a specific post and article from backend and displaying them|[#402](https://github.com/bounswe/bounswe2022group5/issues/402)|
|Fixing bugs in the comment dropdown menu|[#409](https://github.com/bounswe/bounswe2022group5/issues/409)|
|Updating pages after comment/article/post creations|[#411](https://github.com/bounswe/bounswe2022group5/issues/411)|
|Showing HTML body of a post/article|[#412](https://github.com/bounswe/bounswe2022group5/issues/412)|
|Showing images of Post/Article/Comment|[#421](https://github.com/bounswe/bounswe2022group5/issues/421)|
|Implementing text annotations|[#459](https://github.com/bounswe/bounswe2022group5/issues/459)|
|Embedding App Logo and Textual Logo in the App|[#504](https://github.com/bounswe/bounswe2022group5/issues/504)|
|Category following functionality|[#509](https://github.com/bounswe/bounswe2022group5/issues/509)|
|Text Annotation Deletion|[#520](https://github.com/bounswe/bounswe2022group5/issues/520)|
|Article text annotations page redirection bug|[#521](https://github.com/bounswe/bounswe2022group5/issues/521)|
|Showing labels in a post|[#522](https://github.com/bounswe/bounswe2022group5/issues/522)|
|Fixing Post/Article Overview Screen Bugs|[#531](https://github.com/bounswe/bounswe2022group5/issues/531)|

  

  

|Pull Request Title|Link|
|-----|--------|
|Initial directory structure for the app is created|[#189](https://github.com/bounswe/bounswe2022group5/pull/189)|
|Initial mobile app structure was created|[#191](https://github.com/bounswe/bounswe2022group5/pull/191)|
|Mobile Home Screen is Created|[#212](https://github.com/bounswe/bounswe2022group5/pull/244)|
|Home page is updated to use API services|[#269](https://github.com/bounswe/bounswe2022group5/pull/269)|
|Drawer head in the Home page is updated|[#280](https://github.com/bounswe/bounswe2022group5/issues/280)|
|Minor bug-fixes in the login page and AndroidManifest.xml|[#282](https://github.com/bounswe/bounswe2022group5/issues/282)|
|Model updates and mock data creation has been done|[#317](https://github.com/bounswe/bounswe2022group5/pull/317)|
|Articles home page has been created|[#325](https://github.com/bounswe/bounswe2022group5/pull/325)|
|App theme has been updated|[#339](https://github.com/bounswe/bounswe2022group5/pull/339)|
|Change in model structure to have a single User class has been done|[#345](https://github.com/bounswe/bounswe2022group5/pull/345)|
|Floating action button for post/article creation has been implemented|[#347](https://github.com/bounswe/bounswe2022group5/pull/347)|
|Necessary page connections in the home page have been implemented|[#380](https://github.com/bounswe/bounswe2022group5/pull/380)|
|Drawer has been updated. getUserInfo API function has been redesigned|[#389](https://github.com/bounswe/bounswe2022group5/pull/389)|
|Getting posts and articles from the backend in the home page has been implemented|[#400](https://github.com/bounswe/bounswe2022group5/pull/400)|
|Showing a single post/article by fetching them from backend has been done|[#408](https://github.com/bounswe/bounswe2022group5/pull/408)|
|Necessary fixes in the comment dropdown have been implemented|[#410](https://github.com/bounswe/bounswe2022group5/pull/410)|
|Showing HTML has been implemented|[#418](https://github.com/bounswe/bounswe2022group5/pull/418)|
|Updating post page after new comment has been done|[#420](https://github.com/bounswe/bounswe2022group5/pull/420)|
|Images has been made reachable in post/comment/article pages|[#425](https://github.com/bounswe/bounswe2022group5/pull/425)|
|Text annotation implementation has been completed|[#502](https://github.com/bounswe/bounswe2022group5/pull/502)|
|App Logos have been embedded in the app|[#507](https://github.com/bounswe/bounswe2022group5/pull/507)|
|Category follow functionality has been implemented|[#517](https://github.com/bounswe/bounswe2022group5/pull/517)|
|Text annotation deletion has been implemented|[#525](https://github.com/bounswe/bounswe2022group5/pull/525)|
|Article page redirection bug has been fixed|[#527](https://github.com/bounswe/bounswe2022group5/pull/527)|
|Labels shown in the post/article viewing page|[#530](https://github.com/bounswe/bounswe2022group5/pull/530)|
|Overview screen bugs have been solved|[#534](https://github.com/bounswe/bounswe2022group5/pull/534)|

  

  

#### Engin Oğuzhan Şenol

  

  

|Issue Title|Link|
|-----|:--------:|
|Listing questions and clarifications to refine the Requirements|[#173](https://github.com/bounswe/bounswe2022group5/issues/173)|
|Uploading Customer Meeting 5 Notes|[#179](https://github.com/bounswe/bounswe2022group5/issues/179)|
|[Mobile] Creating Profile Page|[#207](https://github.com/bounswe/bounswe2022group5/issues/207)|
|Changing Requirements w.r.t Meeting 16.1 Discussion|[#217](https://github.com/bounswe/bounswe2022group5/issues/217)|
|Adding an API service class to the mobile app|[#240](https://github.com/bounswe/bounswe2022group5/issues/240)|
|Creating Scenario 2 for Milestone 1|[#266](https://github.com/bounswe/bounswe2022group5/issues/266)|
|[Mobile] Editing Profile Page|[#275](https://github.com/bounswe/bounswe2022group5/issues/275)|
|Milestone 1 Executive Summary|[#284](https://github.com/bounswe/bounswe2022group5/issues/284)|
|[Mobile] Updating Profile Page|[#318](https://github.com/bounswe/bounswe2022group5/issues/318)|
|[Mobile] Activity History Pages|[#399](https://github.com/bounswe/bounswe2022group5/issues/399)|
|[Mobile] Implementing Comments Activity History|[#426](https://github.com/bounswe/bounswe2022group5/issues/426)|
|[Mobile] Chatbot Implementation|[#465](https://github.com/bounswe/bounswe2022group5/issues/465)|
|[Frontend][Mobile] Implementing the tree Q/A configurations of the ChatBot.|[#489](https://github.com/bounswe/bounswe2022group5/issues/489)|
|[Mobile] Updating Medical History|[#490](https://github.com/bounswe/bounswe2022group5/issues/490)|
|[Mobile] Redirecting to Doctor's Profile Page|[#491](https://github.com/bounswe/bounswe2022group5/issues/491)|
|[Mobile] Bug Fix in Post Creation|[#524](https://github.com/bounswe/bounswe2022group5/issues/524)|
|[Mobile] Bug Fix in Chatbot|[#529](https://github.com/bounswe/bounswe2022group5/issues/529)|
|[Mobile] Changing Profile Picture/Avatar|[#533](https://github.com/bounswe/bounswe2022group5/issues/533)|
|[Final Milestone] Status of the requirements|[#541](https://github.com/bounswe/bounswe2022group5/issues/541)|

  

  

|Pull Request Title|Link|
|-----|:--------:|
|Mobile/feature/profile #207|[#228](https://github.com/bounswe/bounswe2022group5/issues/228)|
|Mobile screens are connected|[#230](https://github.com/bounswe/bounswe2022group5/issues/230)|
|API service class is added to the mobile app|[#244](https://github.com/bounswe/bounswe2022group5/issues/244)|
|[Mobile] Separating Profile Widgets|[#273](https://github.com/bounswe/bounswe2022group5/issues/273)|
|[Mobile] Editing Profile Page|[#276](https://github.com/bounswe/bounswe2022group5/issues/276)|
|[Mobile] Creating initial pages of activity history and edit profile|[#346](https://github.com/bounswe/bounswe2022group5/issues/346)|
|[Mobile] Edit Profile Page|[#398](https://github.com/bounswe/bounswe2022group5/issues/398)|
|[Mobile] Activity history is added|[#422](https://github.com/bounswe/bounswe2022group5/issues/422)|
|[Mobile] Comments Activity History|[#427](https://github.com/bounswe/bounswe2022group5/issues/427)|
|[Mobile] Redirecting to Doctor's Profile Page|[#496](https://github.com/bounswe/bounswe2022group5/issues/496)|
|[Mobile] Chatbot Implementation|[#510](https://github.com/bounswe/bounswe2022group5/issues/510)|
|[Mobile] Bug fixed in home screen.|[#526](https://github.com/bounswe/bounswe2022group5/issues/526)|
|[Mobile] Bug Fix in Chatbot|[#532](https://github.com/bounswe/bounswe2022group5/issues/532)|

  

  

#### Yavuz Samet Topçuoğlu

  

  
  

|Issue Title|Link|
|-----|:--------:|
|Implementation of the Article card component which is going to be visible on the Homepage of the website.|[#241](https://github.com/bounswe/bounswe2022group5/issues/241)|
|Revising the [Use Case Diagram](https://github.com/bounswe/bounswe2022group5/wiki/Use-Case-Diagram), and made changes on it according to the changes done in [Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements) after the Customer Meeting.|[#178](https://github.com/bounswe/bounswe2022group5/issues/178)|
|Gathering suggestions for the name and logo of our project.|[#185](https://github.com/bounswe/bounswe2022group5/issues/185)|
|Forming a [scenario](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-1-for-Milestone-1) where a doctor signs up and logs in to the website.|[#268](https://github.com/bounswe/bounswe2022group5/issues/268)|
|Initialization of the profile page for registered users.|[#288](https://github.com/bounswe/bounswe2022group5/issues/288)|
|Implementing functionalities to the profile page, such as editing buttons for both members and doctors.|[#370](https://github.com/bounswe/bounswe2022group5/issues/370)|
|Navigation handling of some buttons in the navbar and homepage.|[#404](https://github.com/bounswe/bounswe2022group5/issues/404)|
|Adding category addition section to the post creation page.|[#406](https://github.com/bounswe/bounswe2022group5/issues/406)|
|Bug Fix: Disabling voting mechanism for guest users.|[#413](https://github.com/bounswe/bounswe2022group5/issues/413)|
|Adding label functionality to the post creation page.|[#416](https://github.com/bounswe/bounswe2022group5/issues/416)|
|Informing other team members with logo and text photo usage in frontend.|[#401](https://github.com/bounswe/bounswe2022group5/issues/401)|
|Improvements on the profile page, medical history display.| [#423](https://github.com/bounswe/bounswe2022group5/issues/423)|
|Medical history editing feature.| [#438](https://github.com/bounswe/bounswe2022group5/issues/438)|
|Following and unfollowing categories.| [Issue #448](https://github.com/bounswe/bounswe2022group5/issues/448)|
|Visualizing added labels.| [ #451](https://github.com/bounswe/bounswe2022group5/issues/451)|
|Creating doctor profiles.| [ #464](https://github.com/bounswe/bounswe2022group5/issues/464)|
|Using Ontology suggested labels to the post pages.| [ #483](https://github.com/bounswe/bounswe2022group5/issues/483)|
|Account deletion feature.| [ #499](https://github.com/bounswe/bounswe2022group5/issues/499)|
|Article deletion feature.| [ #501](https://github.com/bounswe/bounswe2022group5/issues/501)|
|Testing for Popup component.| [ #512](https://github.com/bounswe/bounswe2022group5/issues/512)|
|Fix on doctor profiles redirection.| [ #536](https://github.com/bounswe/bounswe2022group5/issues/536)|
|Creating initial structure of all deliverables.| [ #538](https://github.com/bounswe/bounswe2022group5/issues/538)|
|Creating customer presentation notes page.|[ #542](https://github.com/bounswe/bounswe2022group5/issues/542)|

  

  
  

|Pull Request Title|Link|
|-----|:--------:|
|Article cards are available to be displayed on the homepage.|[#243](https://github.com/bounswe/bounswe2022group5/pull/243)|
|Profile page creation.|[#356](https://github.com/bounswe/bounswe2022group5/pull/356)|
|Implementing functionalities to the profile page.|[#384](https://github.com/bounswe/bounswe2022group5/pull/384)|
|Bug Fix: Notification messages, API calls are fixed.|[#405](https://github.com/bounswe/bounswe2022group5/pull/405)|
|Category functionality added to the post creation page and Post and Article Card navigation handled.|[#407](https://github.com/bounswe/bounswe2022group5/pull/407)|
|Bug Fix: Voting mechanism for guest users is disabled.|[#414](https://github.com/bounswe/bounswe2022group5/pull/414)|
|Implementing label functionality to the post creation page.|[#417](https://github.com/bounswe/bounswe2022group5/pull/417)|
|Enhancements on the profile page, medical history for members are added.|[#424](https://github.com/bounswe/bounswe2022group5/pull/424)|
|Medical history editing feature added.|[ #439](https://github.com/bounswe/bounswe2022group5/pull/439)|
|Following and unfollowing categories implemented.| [#449](https://github.com/bounswe/bounswe2022group5/pull/449)|
|Labels are visualized.| [#452](https://github.com/bounswe/bounswe2022group5/pull/452)|
| Doctor profile pages are created.| [#482](https://github.com/bounswe/bounswe2022group5/pull/482)|
| Ontology suggested labels are attached to the posts.| [#486](https://github.com/bounswe/bounswe2022group5/pull/486)|
| Account deletion feature implemented.| [#500](https://github.com/bounswe/bounswe2022group5/pull/500)|
| Article deletion feature implemented.| [#505](https://github.com/bounswe/bounswe2022group5/pull/505)|
| Popup component tested.| [#514](https://github.com/bounswe/bounswe2022group5/pull/514)|
| Doctor profile redirection fix.| [#535](https://github.com/bounswe/bounswe2022group5/pull/535)|

  

  

*  ### Status of the requirements

  

  

Before starting the last milestone, we met again as a team and discussed the [Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements) we had previously determined. After this talk, we determined which features of our application, which we have been working on for two semesters, could be implemented until the final milestone, which were prioritized, or which could be completed until the final version of the application. Upon the final decisions, our team member Canberk made the necessary changes in the requirements and documented the changes that made in [the created wiki page](https://github.com/bounswe/bounswe2022group5/wiki/Changes-in-Requirements).

  

  

Since it was our final milestone, we can look at all the [Functional Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1-functional-requirements) that we have created and arranged, and to what extent we have completed them.

  

In the [User Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#11-user-requirements), we can firstly look to the [User Profile](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#111-user-profile) section. For this section, our first subcategory is the [Sign-up](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1111-sign-up), the part about where people register so they can post on our app. For this requirements, since we had not implemented the e-mail authentication for our application, the only requirement missing is:

  

-  **1.1.1.1.8** Guest users shall confirm their e-mail addresses via e-mail authentication while registering.

  

  

The other subcategory in this section is the [Sign-in & Sign-out](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1112-sign-in--sign-out). Since members cannot sign-in with their username while entering to our application, our first requirements for this subsection has not completed. Also, we had not implemented the forgot password mechanism for all users:

  

-  **1.1.1.2.1** Members shall be able to sign-in to the system using their username or e-mail and their password.

  

-  **1.1.1.2.3** Registered users shall be able to sign-in if they forgot their password with _forgot password_ mechanism

  

  

The third subcategory in this section is the [Profile Pages](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1113-profile-pages). Since we had not implemented showing the verification of a doctor feature for mobile, we are not able to see the icon in doctor's profile page:

  

-  **1.1.1.3.6** Doctors shall have icons in their profiles showing that their accounts are verified.

  

  

The last subcategory in this section is the [Settings](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1114-settings). Even editing the profile page is completed with all the features for Frontend, it is not finished for our mobile application. These features are:

  

-  **1.1.1.4.2** Doctors shall be able to add/delete/change profile pictures.

  

-  **1.1.1.4.3** Members shall be able to add/delete/change avatars.

  

-  **1.1.1.4.5** Registered users shall be able to delete their accounts.

  

  

The other section, [Platforms](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#112-platforms), is about the posts and articles shared in our home pages. Users can share their thoughts, problems, anything related to our application's content in these platforms. Also a user can use the chatbot, and follow the tags/categories that they are interested in. Our first subcategory for this section is the [Forum](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1121-forum). For these requirements, we had decided not giving the authorization for a doctor to add/remove any tag for another user's post since it can lead to improper use. Also, a user cannot edit a post or comment that they shared in our mobile application. Last for this subsection, we had not implemented the report mechanism for both Frontend and Mobile but the endpoint is implemented and merged:

  

-  **1.1.2.1.10** Doctors shall be able to add or remove tags from an existing post.

  

-  **1.1.2.1.14** Registered users shall be able to report a post or comment to an admin if they think that it contains inappropriate or misleading content.

  

-  **1.1.2.1.15** Registered users should be able to edit their posts.

  

-  **1.1.2.1.17** Registered users should be able to edit their comments.

  

  

The other subsection for Platforms requirements is [Chatbot](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1122-chatbot). We had successfully implemented Chatbot to our application. Yet, redirecting to the relative posts about a category could not be implemented to the mobile due to HTML restrictions:

  

-  **1.1.2.2.1** Users shall be able to reach posts related to the options they choose from chatbot decision tree.

  

  

The third subcategory for this section is [Articles](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1123-articles). Since editing is not completed only in the mobile application, the only missing requirement is for mobile:

  

-  **1.1.2.3.3** Article-owners shall be able to edit articles they created.

  

  

The last subcategory for this is [Following Tags/Categories](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1124-following-tagscategories), which is completed with all its requirements for all of our teams.

  

  

Our other section [Search & Sort Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#113-search--sort-requirements), only includes the [Searching](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1131-searching) subcategory. For this subcategory, we had completed all of the requirements except the ones:

  

-  **1.1.3.1.4** Users shall be able to search posts, articles and user profiles by the names of the doctors that contributed to them (We can search posts and articles of a doctor via using a doctor's name in the search bar. But search mechanism is not used for profile search. A user must click on the doctor's name after finding the doctor's content: One can see here: **1.1.3.1.6** Users shall be able to search among posts in the Forum with the titles, body, authors of the posts.)

  

-  **1.1.3.1.5** Users shall be able to search posts, articles and user profiles by the usernames.

  

  

The last section for Functional Requirements is [Admin](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#114-admin-requirements), which is completed with all of its features. Admins can use their panels to apply all of these requirements mentioned in this section.

  

  

In the [System Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#12-system-requirements), there are two subcategories which are [Forum](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1211-forum), and [Chatbot](https://github.com/bounswe/bounswe2022group5/wiki/Requirements#1212-chatbot). Since we had completed all the necessary requirements for this, we do not to specify any requirement.

  

  

*  ### API endpoints

We have migrated the Documentation to a Postman Doc Page.
Also you can fork the collection via link below.

##### [Postman Documentation](https://documenter.getpostman.com/view/14834467/2s8YswSXdA)

To use API fork the Postman collection. Application and Annotation API is in the same **Collection**.
- For Application API use host: ec2-3-87-119-148.compute-1.amazonaws.com:8000/
- For Annotation API use host: ec2-18-209-24-202.compute-1.amazonaws.com:8000/

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/14834467-bea9ded4-7ac4-4a3d-899c-7c1a74174864?action=collection%2Ffork&collection-url=entityId%3D14834467-bea9ded4-7ac4-4a3d-899c-7c1a74174864%26entityType%3Dcollection%26workspaceId%3D046b467d-a616-49f1-8160-7043503e5889)

*  ### User Interface / User Experience

  

#### Mobile Application:

  

***Login Page***:

  

- Code: [Login](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/login.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175791-7d842e63-5db6-4538-82d6-9c43b3c264cc.png"  alt="drawing"  width="270"/>

  

***Signup Page***:

  

- Code: [Signup](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/signup.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175806-9f3d9f31-0926-450b-a7ff-ca87c7c46106.png"  alt="drawing"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175807-fac67cae-5334-433c-ba12-3e24c84ea5b1.png"  alt="drawing"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175808-d9e66264-a191-4aae-960c-628249336ef0.png"  alt="drawing"  width="270"/>

  

  

***Home Page***:

  

- Code: [Home](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/home.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175789-adf724c0-1e5d-44de-af8b-b725701f3e1f.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175787-378a4b9d-e981-4e92-a02a-fad3ab8f61ff.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175788-92fdaf68-2ef1-4e66-b1cd-db6677e8ea14.png"  width="270"/>

  

  

***Drawer***:

  

- Code: [Drawer](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/widgets/MyDrawer.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175782-f7c5c86a-426c-4214-bce0-dda2e7c10b75.png"  width="270"/>

  

  

***Profile Page***:

  

- Code: [Profile](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/profile.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175794-abe10369-5297-4096-b792-2efd81497e0e.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175793-f2bd03c3-4252-4759-b642-70dd0dc3b450.png"  width="270"/>

  

  

***"Posts of a User" Page***:

  

- Code: [Posts of a User](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/userPostOverviewScreen.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175792-33c43d3e-622c-448c-a59c-317ced5724ab.png"  width="270"/>

  

  

***"Articles of a Doctor" Page***:

  

- Code: [Articles of a User](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/userArticleOverviewScreen.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175770-c0aa126b-ba06-48bb-bfbf-68fd568d758d.png"  width="270"/>

  

  

***"Comments of a User" Page***:

  

- Code: [Comments of a User](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/userCommentsOverviewScreen.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175776-2e582063-0c9b-449d-8b28-c07680c372a1.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175775-4f0bf29b-5e56-4625-ab37-f017d94dacbe.png"  width="270"/>

  

***"Upvoted Posts of a User" Page***:

  

- Code: [Upvoted Posts of a User](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/upvotedPostsOverviewScreen.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175811-944b391f-0097-4655-ac96-ca1b12e1f3c0.png"  width="270"/>

  

***"Upvoted Articles of a User" Page***:

  

- Code: [Upvoted Articles of a User](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/upvotedArticlesOverviewScreen.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175810-b57a168b-c6c7-4dc1-bbdd-31736c35829b.png"  width="270"/>

  

***Edit Profile Page***:

  

- Code: [Edit Profile](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/editprofile.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175784-73c8a829-5fe4-4650-af53-060a35847cb3.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175783-6de05740-1c67-45a0-b682-67e2e8c75339.png"  width="270"/>

  

***View Post Page***:

  

- Code: [View Post](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/viewPost.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175818-05ca67fb-7792-4f5a-86f9-bc5a370ab7e5.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175816-3c4b71ba-3271-4791-ab3a-95111faa2eeb.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175821-801e3aa8-883d-4426-91c8-c062f6fd9037.png"  width="270"/>

  

***Images Page***:

  

- Code: [Images](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/imagesGrid.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175790-07b74cc2-b2b0-4729-a57f-208d716de480.png"  width="270"/>

  

***View Article Page***:

  

- Code: [View Article](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/viewArticle.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175815-9dfcf6ac-deed-4384-95e4-92446ea37177.png"  width="270"/>

  

***Create Post Page***:

  

- Code: [Create Post](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/createPost.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175779-6e962e83-e25d-44e1-bbcd-392d932bf6f6.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175781-ab3c2da8-241f-4354-b707-ab8176df5f4a.png"  width="270"/>

  

***Create Article Page***:

  

- Code: [Create Article](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/createArticle.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210180833-80d94dd7-6890-4443-8e83-41990637ebf3.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210180832-031c49b5-77fe-4b21-b67f-4fabc36b138d.png"  width="270"/>

  

***Create Comment Page***:

  

- Code: [Create Comment](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/createComment.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175778-f84ba74a-ec75-4150-906f-1a8e4ce4eb5b.png"  width="270"/>

  

  

***Category Following Page***:

  

- Code: [Categories](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/categories.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175771-196379bf-d936-4fff-891e-be91528a7a50.png"  width="270"/>

  

  

***Search Pages***:

  

- Code: [Starting Search](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/searchPage.dart)

  

- Code: [Search Article](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/searchArticle.dart)

  

- Code: [Search Post](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/searchPost.dart)

  

- Code: [Search Article by Category](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/articleSearchByCategory.dart)

  

- Code: [Search Article by Keyword](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/articleSearchByKeyword.dart)

  

- Code: [Search Article Results](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/articleSearchResults.dart)

  

- Code: [Search Post by Category](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/postSearchByCategory.dart)

  

- Code: [Search Post by Geolocation](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/postSearchByGeolocation.dart)

  

- Code: [Search Post by Keyword](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/postSearchByKeyword.dart)

  

- Code: [Search Post Results](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/postSearchResults.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175804-ca43d361-205a-438a-a826-679b613552d8.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175801-44aa10ae-a20e-4446-babf-6b96db00bafa.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175795-a6de4275-a151-44d5-a070-846ec177e787.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175796-43b9061b-d993-4600-af03-dd312299081c.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175798-30603996-c89e-4b65-a0d6-58df066caac0.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175800-d560c920-992a-4b07-bb19-efd19946154d.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175803-a0b5b583-5b14-4931-9f71-3ca740e9196d.png"  width="270"/>

  

  

***Text Annotation Creation Page***:

  

- Code: [Selection Controls](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/CustomSelectionControls.dart)

  

- Code: [Create Comment](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/createTextAnnotation.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175768-548130af-994e-4dff-9398-514f6da182ed.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175766-1d063ed8-2f89-49cb-b9b1-8d272ec79812.png"  width="270"/>

  

  

***Reading Text Annotations Page***:

  

- Code: [View Text Annotations](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/viewTextAnnotations.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175805-e68a0269-f6e4-4ef9-aeaa-149b3da08b59.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175814-6b06ada4-f9aa-4272-a288-792ee25abbda.png"  width="270"/>

  

  

***Chatbot***:

  

- Code: [Chatbot Page](https://github.com/bounswe/bounswe2022group5/blob/master/app/mobile/bounswe5_mobile/lib/screens/chatbotScreen.dart)

  

- UI:

  

-  <img  src="https://user-images.githubusercontent.com/61624884/210175772-33752ac7-4192-45af-b1c3-3a8d34c8b847.png"  width="270"/>  <img  src="https://user-images.githubusercontent.com/61624884/210175773-76a487a5-49d4-4aad-812c-a40ad45f2248.png"  width="270"/>

  

#### Web Application:

  

***Login Page***:

  

- Code: [Login](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Login/Login.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 04 04"  src="https://user-images.githubusercontent.com/73655554/206015759-74c0336e-c0ca-4097-b235-a8f8a8538073.png">

  

  

***Signup Page***:

  

- Code: [Signup](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/SignUp/SignUp.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 04 23"  src="https://user-images.githubusercontent.com/73655554/206015814-d6987cd3-039a-4166-83ab-9c469ec75ffa.png">

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 04 30"  src="https://user-images.githubusercontent.com/73655554/206015821-b843ae7a-8aec-4995-b981-6fd23a4d2d08.png">

  

  

***Home Page***:

  

- Code: [Home](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/layouts/HomePage/HomePage.js)

  

and [Navigation Bar](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/layouts/NavBar/NavBar.js)

  

with [Post cards](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/layouts/Forum/Forum.js) and [Article cards](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/layouts/Article/Article.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 05 27"  src="https://user-images.githubusercontent.com/73655554/206016335-d06de689-2a7e-4ed8-a500-30d44f79bd6f.png">

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 05 49"  src="https://user-images.githubusercontent.com/73655554/206016352-a02b0396-3b04-44d1-af60-39b36335f9d7.png">

  

  

***Profile Page***:

  

- Code: [Profile](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Profile/Profile.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 06 35"  src="https://user-images.githubusercontent.com/73655554/206017089-49e04492-fe17-4729-8f02-51dd6a75acef.png">

  

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 17 14"  src="https://user-images.githubusercontent.com/73655554/206017152-dc7a6a1c-f39e-443d-957e-b02d6c077397.png">

  

  

***Activity History Section***:

  

- Code: [Activity History](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Profile/Profile.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 07 26"  src="https://user-images.githubusercontent.com/73655554/206017514-245b9e1d-3de4-4aa6-a58a-f7c1581bfab9.png">

  

  

***Edit Profile Info Page***:

  

- Code: [Edit Info](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Profile/Profile.js)

  

with [Popup](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/components/Popup/Popup.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 07 52"  src="https://user-images.githubusercontent.com/73655554/206017653-87038999-4bbd-4083-9cd1-d3abd92d0529.png">

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 18 01"  src="https://user-images.githubusercontent.com/73655554/206017681-769f35a6-5c2b-411c-b873-efc4c10e5931.png">

  

***Edit Profile Picture or Avatar Page***:

  

- Code: [Edit Profile Picture](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Profile/Profile.js)

  

with [Popup](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/components/Popup/Popup.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 12 53"  src="https://user-images.githubusercontent.com/73655554/206018541-9a54e448-3ffd-42e4-8e14-ad7d887cb1f5.png">

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 17 45"  src="https://user-images.githubusercontent.com/73655554/206018558-d5befd69-098e-4a74-85ab-eb22d6ff8bad.png">

  

  

***View Post Page***:

  

- Code: [View Post](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Post/Post.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 14 04"  src="https://user-images.githubusercontent.com/73655554/206017792-989b10f6-d2f4-44c3-acae-9ca3fd6c0a44.png">

  

  

***View Article Page***:

  

- Code: [View Article](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Article/Article.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 14 40"  src="https://user-images.githubusercontent.com/73655554/206017915-08a5c733-e387-432c-953d-7151b6402400.png">

  

  

***Create Post Page***:

  

- Code: [Create Post](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/CreatePost/CreatePost.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 15 53"  src="https://user-images.githubusercontent.com/73655554/206017999-f109332f-e997-4d0e-8d22-8672215b2874.png">

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 16 14"  src="https://user-images.githubusercontent.com/73655554/206018110-d66a2405-0c8d-4ca3-9fb1-2feed4aa1cda.png">

  

  

***Create Article Page***:

  

- Code: [Create Article](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/CreateArticle/CreateArticle.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-06 at 23 16 45"  src="https://user-images.githubusercontent.com/73655554/206018238-9c33366f-25d2-484a-b889-edee63e347c6.png">

  

  

***Image Annotation***:

  

- Code: [Image Annotation](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Post/Post.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-31 at 13 48 55"  src="https://user-images.githubusercontent.com/73655554/210134284-0acc7b18-bff1-4738-b1de-bd67d6645400.png">

  

***Text Annotation***:

  

- Code: [Text Annotation](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Post/Post.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-31 at 13 49 37"  src="https://user-images.githubusercontent.com/73655554/210134292-4b97ab97-53c2-4856-92ff-6663ec2f7f15.png">

  

***Delete Post***:

  

- Code: [Delete Post or Article](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/components/Delete/Delete.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-31 at 13 51 15"  src="https://user-images.githubusercontent.com/73655554/210134356-9ee737b0-5b25-4572-af3d-ac53e792d99e.png">

  

***Delete Account***:

  

- Code: [Delete Account](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Profile/Profile.js)

  

- UI:

  

![Screenshot 2022-12-31 at 13 46 25](https://user-images.githubusercontent.com/73655554/210134392-6bbd97c6-73fd-4632-94de-0082d2157e3a.png)

  

***Chatbot***:

  

- Code: [Chatbot](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/App.js)

  

- UI:

  

![Screenshot 2022-12-31 at 13 46 08](https://user-images.githubusercontent.com/73655554/210134435-41216cb1-1acb-4fff-b5b3-75b46b2d0da1.png)

  

***Doctor Profiles***:

  

- Code: [Doctor Profile](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/pages/Profile/Profile.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-31 at 13 47 29"  src="https://user-images.githubusercontent.com/73655554/210134461-f14c0e03-f9b8-4960-be3a-c029e36b3d76.png">

  

***Category Follow-Unfollow***:

  

- Code: [Follow-Unfollow](https://github.com/bounswe/bounswe2022group5/blob/master/app/frontend/src/layouts/HomePage/HomePage.js)

  

- UI:

  

<img  width="1800"  alt="Screenshot 2022-12-31 at 13 47 51"  src="https://user-images.githubusercontent.com/73655554/210134478-1122c4c0-0dfb-41bc-8af8-cac0a0baa319.png">

  

  

*  ### Annotations

In Milestone 2 and Customer Demo we have explained how we will implement Annotations with [the Annotation Mockup](https://github.com/bounswe/bounswe2022group5/wiki/Annotation-Mockup).

For Final Milestone and Customer Presentation we have implemented the text and image annotation by following [W3 Annotation Data Model](https://www.w3.org/TR/annotation-model/).

We have researched the data model and created wiki page with results of this research. See [Wiki Page](https://github.com/bounswe/bounswe2022group5/wiki/Research-Items-for-Project#w3c-web-annotation-data-model)

As they mentioned on documentation, the primary aim of the Web Annotation Data Model is to provide a standard description model and format to enable annotations to be shared between systems. This interoperability may be either for sharing with others, or the migration of private annotations between devices or platforms. The shared annotations must be able to be integrated into existing collections and reused without loss of significant information. The model should cover as many annotation use cases as possible, while keeping the simple annotations easy and expanding from that baseline to make complex uses possible.

There are two schemes we have defined for annotations. Below is the schema we use for Text Annotation and Image Annotation, respectively:

##### Text Annotation Schema

```
{
    "@context": "http://www.w3.org/ns/anno.jsonld",
    "body": [
        {
            "created": "2022-12-17T21:01:59.693Z",
            "creator": {
                "id": "http://3.91.54.225:3000/profile/61",
                "name": "Mehmet Emre Akbulut"
            },
            "modified": "2022-12-17T21:01:59.693Z",
            "purpose": "commenting",
            "type": "TextualBody",
            "value": "Content of The Annotation"
        }
    ],
    "id": "#id",
    "target": {
        "selector": [
            {
                "exact": "Exact String Selected",
                "type": "TextQuoteSelector"
            },
            {
                "start": 222,
                "end": 234,
                "type": "TextPositionSelector"
            }
        ]
    },
    "type": "Annotation"
}
```

##### Image Annotation Schema:

```
{
    "@context": "http://www.w3.org/ns/anno.jsonld",
    "body": [
        {
            "created": "2022-12-17T21:01:59.693Z",
            "creator": {
                "id": "http://3.91.54.225:3000/profile/61",
                "name": "Mehmet Emre Akbulut"
            },
            "modified": "2022-12-17T21:01:59.693Z",
            "purpose": "commenting",
            "type": "TextualBody",
            "value": "Content of The Annotation"
        }
    ],
    "id": "#b3343k4klRANDOM3434fdfd",
    "target": {
        "selector": {
            "conformsTo": "http://www.w3.org/TR/media-frags/",
            "type": "FragmentSelector",
            "value": "xywh=pixel:491.23232,323.23232,436.8787, 123.4343"
        },
        "source": "URL OF PHOTO"
    },
    "type": "Annotation"
}
```
#### Annotation Status:

##### Backend:
This schemas are created on the Annotation Server. Link is 'ec2-18-209-24-202.compute-1.amazonaws.com:8000/'. They are stored in db and served to Frontend and Mobile when requested.

##### Frontend:
The annotation tool is available on the website and all Registered Users can annotate posts and see the annotations.
For Text Annotation, a Registered User can select any text in post and annotate it. Also editing and deleting annotation is possible.
For Image Annotation, a Registered User can select any text in post and annotate it. Also editing and deleting annotation is possible.
Also Registered Users can view all text and image annotations.

##### Mobile:
The annotation tool is available on the mobile app and all Registered Users can annotate posts and see the annotations.
For Text Annotation, a Registered User can select any text in post and annotate it. 
Also Registered Users can view all text annotations.

*  ### Standards

In Software Engineering, standards help make systems interoperable. Standards are important in effective communication between disparate systems. Standards also make it easier to track and monitor transactions, metrics and more. Systems that are developed to standards also make them more credible.

As we mentioned in Annotation Section, we have followed [W3 Annotation Data Model](https://www.w3.org/TR/annotation-model/).

The Web Annotation Data Model specification describes a structured model and format to enable annotations to be shared and reused across different hardware and software platforms. 

We have used [Natinonal Library of Medicine Ontology](https://www.nlm.nih.gov/?_gl=1*139qbsh*_ga*MTU1MDQ0MzM5MS4xNjcwMTcxODEy*_ga_P1FPTH9PL4*MTY3MjY3MTcwNC45LjEuMTY3MjY3MTgwMy4wLjAuMA..) with [Medical Subject Headings](https://meshb.nlm.nih.gov/) for semantic search.

The Medical Subject Headings (MeSH) thesaurus is a controlled and hierarchically-organized vocabulary produced by the National Library of Medicine. It is used for indexing, cataloging, and searching of biomedical and health-related information.


*  ### Scenarios
