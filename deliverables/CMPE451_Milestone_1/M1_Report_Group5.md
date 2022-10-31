#### Software Requirements Specification
[Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements)
#### Software Design (UML)
- [Use Case Diagram](https://github.com/bounswe/bounswe2022group5/wiki/Use-Case-Diagram)
- [Class Diagram](https://github.com/bounswe/bounswe2022group5/wiki/Class-Diagram)
- [Sequence Diagrams](https://github.com/bounswe/bounswe2022group5/wiki/Sequence-Diagrams)
#### Scenarios and Mockups
- [Scenario 1](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-1-for-Milestone-1)
- [Scenario 2](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-2-for-Milestone-1)
#### Project Plan
- [Project Plan](https://github.com/bounswe/bounswe2022group5/wiki/Project-Plan)
- [RAM](https://github.com/bounswe/bounswe2022group5/wiki/RAM)
#### Individual Contribution Reports

*Please keep **alphabetical** order.*
 
 <details><summary>Alper Canberk Balcı</summary>
	Will be filled. 
 </details>
 <details><summary>Burak Mert</summary>
	 

**Member:** Burak Mert, Group 5

**Responsibilities:** I am a member of frontend team for the project. Since I have some experience about frontend development, I was responsible for building initial structure of our frontend application. My main task was creating login and signup pages. To make these pages fully functional, I was also responsible for building API connection between backend. Dockerizing and deploying frontend project into an AWS instance were also my responsibilities.

**Main Contributions:** My first contribution was building initial structure of the application. During our first frontend meeting, I created a basic React application and create initial folders and files to decide on all tasks we need to finish in order to develop first version of the application. 

My main task was creating a login and signup page. I created two seperate pages with “/login” and “/signup” urls. For signup page, I created two different signup forms for members and doctors. For doctors, signup form has additional fields like document and branch of medicine. I implemented a flipping card to switch between two forms in the same page. I added several validations for form fields like password length and only-numeric password restrictions. I also created API connection between backend. I followed the API documentation on our wiki page, and used “axios” package to make requests. I also used “redux” to keep user information in application state. 

First versions of signup forms of frontend and mobile projects had different fields; therefore, I created an issue to align these fields for consistency.

After considerable amount of frontend tasks are completed, I created a Dockerfile inside the frontend proejct. I created an AWS instance and deployed our frontend project into the instance via Docker. After merging all frontend related branches into master branch, I deployed the master branch again.

&nbsp;&nbsp;&nbsp;&nbsp; **Code related significant issues:** 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Creating Login and Signup pages for Frontend #202](https://github.com/bounswe/bounswe2022group5/issues/202)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Management related significant issues:** 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Aligning signup form fields with Mobile Team #214](https://github.com/bounswe/bounswe2022group5/issues/214)


**Pull Requests: [Login and Signup Pages are implemented in Frontend #252](https://github.com/bounswe/bounswe2022group5/pull/252)**

</details>

 <details><summary>Engin Oğuzhan Şenol</summary>

### Member: 
[Engin Oğuzhan Şenol](https://github.com/bounswe/bounswe2022group5/wiki/Engin-Oğuzhan-Şenol)

### Responsibilities:
In order to develop the project, I have been in the many situations and tasks where I can put my effort on. Recently, most of the responsibilities that are assigned to me were relevant to mobile development. Since I have not done a mobile development prior to this project, I had to study Flutter and Dart to improve my skills for our application.

### Main Contributions:
For medical experience sharing platform, creating profile page of the mobile application was my most essential contribution. I was also the note taker of our development team. Also, I have been a part of Requirement Specification, and Creation of Scenarios and Mock ups.

#### Code related significant issues:
[(#207)](https://github.com/bounswe/bounswe2022group5/issues/207) I created a Profile Widget and placed it above the profile screen. Then, I created a widget named buildName for showing the information of the active member. Lastly, I created a class named ProfileListItem, and created buttons for activity histories for Likes, Comments, Posts. Lastly, I placed the AppBar. that we used for many mobile screens.

#### Management related significant issues:
[(#217)](https://github.com/bounswe/bounswe2022group5/issues/217) After [Meeting 16.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-16.1), we decided to revised the [project requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements), and changed them according to Discussion. I reviewed all of the requirements that are according to our last decisions. I deleted the unnecessary ones, changed the altered ones, and added new requirements if there are absent ones.
	
[(#268)](https://github.com/bounswe/bounswe2022group5/issues/217) After [Meeting 16.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-16.1), we decided to create two scenarios for CMPE451 Milestone 1. I was assigned for the [Scenario 2](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-2-for-Milestone-1). After creation of the first scenario, we created another character and created a different scenario for that character

### Pull Requests:
 - ([#228](https://github.com/bounswe/bounswe2022group5/pull/228)) As mentioned above, my mainly part was creating profile page for mobile application. 
 -  ([#273](https://github.com/bounswe/bounswe2022group5/pull/273)) To make the code look more organized, I separated files for profile widgets
 -  ([#276](https://github.com/bounswe/bounswe2022group5/pull/228)) After creation of the endpoints, I changed the mock data with the actual data.

### Additional Information
Here is my other important efforts before CMPE 451 Milestone 1.

|#|Task|
|---|---|
|1|Attended Meeting [13.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-13.1), [14.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-14.1), [15.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-15.1), [16.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-16.1)|
|2|Attended Mobile Meetings [1](https://github.com/bounswe/bounswe2022group5/wiki/Mobile-Meeting-1), [2](https://github.com/bounswe/bounswe2022group5/wiki/Mobile-Meeting-2), [3](https://github.com/bounswe/bounswe2022group5/wiki/Mobile-Meeting-3), [4](https://github.com/bounswe/bounswe2022group5/wiki/Mobile-Meeting-4). |
|3|Assigned issues [#173](https://github.com/bounswe/bounswe2022group5/issues/173), [#179](https://github.com/bounswe/bounswe2022group5/issues/179), [#207](https://github.com/bounswe/bounswe2022group5/issues/207), [#217](https://github.com/bounswe/bounswe2022group5/issues/217), [#240](https://github.com/bounswe/bounswe2022group5/issues/240), [#266](https://github.com/bounswe/bounswe2022group5/issues/266), [#275](https://github.com/bounswe/bounswe2022group5/issues/275).|
|4|Reviewed issues [#171](https://github.com/bounswe/bounswe2022group5/issues/171), [#180](https://github.com/bounswe/bounswe2022group5/issues/180), [#190](https://github.com/bounswe/bounswe2022group5/issues/190), [#209](https://github.com/bounswe/bounswe2022group5/issues/209), [#225](https://github.com/bounswe/bounswe2022group5/issues/225), [#229](https://github.com/bounswe/bounswe2022group5/issues/229), [#234](https://github.com/bounswe/bounswe2022group5/issues/234), [#245](https://github.com/bounswe/bounswe2022group5/issues/245), [#261](https://github.com/bounswe/bounswe2022group5/issues/261), [#264](https://github.com/bounswe/bounswe2022group5/issues/264), [#268](https://github.com/bounswe/bounswe2022group5/issues/268), [#277](https://github.com/bounswe/bounswe2022group5/issues/277).


</details>

  <details><summary>Halil Burak Pala</summary>


### Member: [Halil Burak Pala](https://github.com/bounswe/bounswe2022group5/wiki/Halil-Burak-Pala)

### Responsibilities:

- Attending the meetings.
- Updating our [wiki home page](https://github.com/bounswe/bounswe2022group5/wiki/).
- Revising and updating the [class diagram](https://github.com/bounswe/bounswe2022group5/wiki/Class-Diagram).
- Rearranging and preparing our repo for collobarative work among all teams.
- Building an initial structure (initial pages, models, theme of the app) for our mobile app.
- Creating and maintaining the home page of our mobile app.
- Creating the connections between mobile pages with my other teammates.
- Integrating the API services provided by our backend team into our mobile app, especially in the home page.

### Main Contributions:
I am a member of the mobile team in this project. In the beginning, I had no prior knowledge about the mobile development, so I spent a considerable time for learning and practicing Flutter after we decided to use this framework. 

Then, after discussing with my teammates about possible structures for our app, I created the initial structure for it. I added initial screens, initial models, some mock data to use while developing our app, and decided the main theme of the app. 

Then I created the home page of this app. Home page is where you can access main elements of the app, such as forum, articles, chatbot, profile page etc. After creating this screen, I connected it with other available pages.

Then I created API service routines to use in mobile pages with my teammates. Then connected my home page to the API created by our backend team. I helped my teammates when they need assistance also. 

* *Code related significant issues:*
	* Creating initial mobile app structure: [#190](https://github.com/bounswe/bounswe2022group5/issues/190)
	* Creating a mobile home screen: [#192](https://github.com/bounswe/bounswe2022group5/issues/192)
	* Connecting all mobile pages (This is implemented with the participation of all mobile team): [#229](https://github.com/bounswe/bounswe2022group5/issues/229) 
	* Using Personal Information and Logout API services in the home page: [#260](https://github.com/bounswe/bounswe2022group5/issues/260)
* *Management related significant issues:*
	* Revising the Class Diagram: [#181](https://github.com/bounswe/bounswe2022group5/issues/181)
	* Rearranging the Repo Structure and Branches For Collaborative Work: [#188](https://github.com/bounswe/bounswe2022group5/issues/188)
	

### Pull Requests:
* Initial directory structure for the app is created: [#189](https://github.com/bounswe/bounswe2022group5/pull/189)
* Initial mobile app structure was created : [#191](https://github.com/bounswe/bounswe2022group5/pull/191)
* Mobile Home Screen is Created: [#212](https://github.com/bounswe/bounswe2022group5/pull/244)
* Home page is updated to use API services: [#269](https://github.com/bounswe/bounswe2022group5/pull/269)


 </details>


 <details><summary>Irfan Bozkurt</summary>

### Member: [Irfan Bozkurt - Group 5](https://github.com/bounswe/bounswe2022group5/wiki/Irfan-Bozkurt)
### Responsibilities:
- Attending weekly general meetings and taking notes
- Revising and changing requirements
- Revising and proposing changes in class diagrams
- Deciding on development & deployment roadmap of Backend
- Attending weekly back-end meetings and deciding on strategies
- Deploying the database
- Creating the initial schema & initial tables in the database
- Writing unit tests on the initial model classes
- Dockerizing the back-end
- Deployment of 2 different versions of back-end

### Main Contributions:
Overall, my contributions mainly included architectural decisions; revision of requirements; database, docker, deployment-related tasks; and reviewing important back-end code.

#### Code related significant issues:
* [Choosing / Deploying a Database Service](https://github.com/bounswe/bounswe2022group5/issues/194)
* [Create Initial Tables in the Database](https://github.com/bounswe/bounswe2022group5/issues/199)
* [Unit tests for model classes](https://github.com/bounswe/bounswe2022group5/issues/199#issuecomment-1288161363)
* [Dockerization and Deployment of Backend](https://github.com/bounswe/bounswe2022group5/issues/220)
* [Fix the authentication_classes bug & deploy new version](https://github.com/bounswe/bounswe2022group5/issues/246)

#### Management related significant issues:
* On [this issue about requirements](https://github.com/bounswe/bounswe2022group5/issues/173), I have significant contribution as can be seen from the comments: [this](https://github.com/bounswe/bounswe2022group5/issues/173#issuecomment-1272586250), [this](https://github.com/bounswe/bounswe2022group5/issues/173#issuecomment-1272582240), [this](https://github.com/bounswe/bounswe2022group5/issues/173#issuecomment-1272582140)
* [Meeting notes](https://github.com/bounswe/bounswe2022group5/wiki/Backend-Meeting-1.2) is taken by me and was important to determine the initial development structure.

Pull Requests:
* [Backend/feature/initial tables](https://github.com/bounswe/bounswe2022group5/pull/203)
* [App dockerized and deployed](https://github.com/bounswe/bounswe2022group5/pull/231) 
* [Small bug fix ](https://github.com/bounswe/bounswe2022group5/pull/247) 


 </details>

<details><summary>Kardelen Demiral</summary>


### Member: [Kardelen Demiral](https://github.com/bounswe/bounswe2022group5/wiki/Kardelen-Demiral)

### Responsibilities:

- Attending the meetings.
- Updating the wiki sidebar as discussed in the [Meeting 13.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-13.1). Adding new sections for team meetings. 
- Making a research about technologies, tools and frameworks we can use while developing the mobile application to share my knowledge with my teammates and decide on the technology that will be used for mobile.
- As a member of the mobile team, contributing to the development of the mobile application and the main decisions about the development.
- Responsible for the development of the sign-up screen for mobile application together with the backend connection. 
- Responsible for reviewing the code written by other mobile developers.
- Editing the README file of the mobile application code to add a description and a guide about how to run the code.

### Main Contributions:
Since I was not very familiar with mobile development and I wanted to be a part of the mobile team, most of my time until the Milestone 1 was spent on learning. Firstly, I made a research about which language and tools that we could use and shared my knowledge with my teammates during our meetings. After deciding to use Flutter for mobile development, I practiced a lot to get familiar with. Then, my main responsibility was to create the sign-up screen and making its backend connection. I also helped other mobile team members when they had issues developing their own parts. 
* *Code related significant issues:*
	* Started to create a sign-up page for the mobile application: [#193](https://github.com/bounswe/bounswe2022group5/issues/193)
	* Added the user type selection to the sign-up screen as discussed in the [Meeting 16.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-16.1): [#216](https://github.com/bounswe/bounswe2022group5/issues/216)
	* Added an API service class to the mobile app: [#240](https://github.com/bounswe/bounswe2022group5/issues/240) 
	* Made the register API call for signup and connected our signup screen to the backend service: [#245](https://github.com/bounswe/bounswe2022group5/issues/245)
	* Fixed a bug about login pages being on top of each other after sign-up: [#277](https://github.com/bounswe/bounswe2022group5/issues/277)
* *Management related significant issues:*
	* Opened an issue to ask members for font suggestions: [#209](https://github.com/bounswe/bounswe2022group5/issues/209)
	* Edited the README file of the mobile application code to add a description and a guide about how to run the code: [#234](https://github.com/bounswe/bounswe2022group5/issues/234)

### Pull Requests:
* Initial implementation of the sign-up screen: [#215](https://github.com/bounswe/bounswe2022group5/pull/215)
* Branch field is added for doctor sign-up: [#222](https://github.com/bounswe/bounswe2022group5/pull/222)
* API service class is added: [#244](https://github.com/bounswe/bounswe2022group5/pull/244)
* Register API call for mobile is handled: [#255](https://github.com/bounswe/bounswe2022group5/pull/255)
* Login pages being on top of each other after sign-up is fixed: [#278](https://github.com/bounswe/bounswe2022group5/pull/278)

  </details>

<details><summary>Mehmet Emre Akbulut</summary>

### Member: [Mehmet Emre Akbulut - Group 5](https://github.com/bounswe/bounswe2022group5/wiki/Mehmet-Emre-Akbulut)
### Responsibilities:
- Enrolling in the meetings and taking notes during the meeting
- Revising Scenario&Mockups and making changes on requirements according this revision
- Deciding Roadmap of Backend Development
- Helping on deciding branch and PR conventions
- Documenting Tech Stack of project
- Creating initial base backend project with Django and Django REST
- Implementing Token Authentication on Backend
- Documenting APIs 
- Implementing Login, Signup, Logout and Personal Info endpoints
- Helping Mobile and Frontend Team to connect project to Backend
- Creating Scenario 1 with [Yavuz Samet Topçuğlu](https://github.com/bounswe/bounswe2022group5/wiki/Yavuz-Samet-Topcuoglu) and [Halil Burak Pala](https://github.com/bounswe/bounswe2022group5/wiki/Halil-Burak-Pala)
- Helping team to document deliverables for Milestone 1 

### Main Contributions: 
In the first weeks I helped revise and make some changes to requirements and scenario&mockups. I helped create branches and PR conventions for collobrative work. After splitting into teams, I created a roadmap for the Backend Team. After deciding on Django as a technology, I created the inital project. After that, I implemented the Authentication settings and documented and implemented the Login, Signup, Logout and Personal Info endpoints with the help of Token Authentication. I helped frontend and mobile connect to backend.
#### Code related significant issues:

* [Creating requirements.txt for backend development](https://github.com/bounswe/bounswe2022group5/issues/195)  after [Backend Meeting 1.1](https://github.com/bounswe/bounswe2022group5/wiki/Backend-Meeting-1.1)
* [Creating 'authentication' module inside the project](https://github.com/bounswe/bounswe2022group5/issues/204) after [Backend Meeting 1.1](https://github.com/bounswe/bounswe2022group5/wiki/Backend-Meeting-1.1)
* [Implementing Token Authentication with Django Rest Framework](https://github.com/bounswe/bounswe2022group5/issues/205) after [Backend Meeting 1.1](https://github.com/bounswe/bounswe2022group5/wiki/Backend-Meeting-1.1)
* [Creating the API documentation for Signup](https://github.com/bounswe/bounswe2022group5/issues/206) after [Backend Meeting 1.1](https://github.com/bounswe/bounswe2022group5/wiki/Backend-Meeting-1.1)
* [Implementing Login and Signup Endpoints](https://github.com/bounswe/bounswe2022group5/issues/218)  after [Meeting 16.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-16.1)
* Other non-significant issues available on [Issues Page](https://github.com/bounswe/bounswe2022group5/issues)

#### Management related significant issues:
* [Revising the Scenarios and Mockups, making adjustments needed.](https://github.com/bounswe/bounswe2022group5/issues/170)  after [Meeting 13.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-13.1)
* [Revising the Scenarios and Mockups, make adjustments needed according to the changes done in the Requirements.](https://github.com/bounswe/bounswe2022group5/issues/182) after [Meeting 14.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-14.1)
* [Deciding on Time and Platform for Backend Team First Meeting](https://github.com/bounswe/bounswe2022group5/issues/183)  
* [Preparing the Pull Request Template](https://github.com/bounswe/bounswe2022group5/issues/184) after [Meeting 15.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-15.1)  
* [Creating initial backend project on GitHub](https://github.com/bounswe/bounswe2022group5/issues/187) 
* [Opening a wiki page for the Tech Stack](https://github.com/bounswe/bounswe2022group5/issues/210)  after [Meeting 15.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-15.1)
* [Creating Scenario 1 for Milestone 1](https://github.com/bounswe/bounswe2022group5/issues/268)  after [Meeting 16.1](https://github.com/bounswe/bounswe2022group5/wiki/Meeting-16.1)
* Other non-significant issues available on [Issues Page](https://github.com/bounswe/bounswe2022group5/issues)

Pull Requests:
* [Requirements added to repo](https://github.com/bounswe/bounswe2022group5/pull/196)
* [Authentication Module Created](https://github.com/bounswe/bounswe2022group5/pull/208) 
* [token auth and initial authentication](https://github.com/bounswe/bounswe2022group5/pull/211) 
* [login and signup endpoints finished](https://github.com/bounswe/bounswe2022group5/pull/219)  
* [Cors headers added](https://github.com/bounswe/bounswe2022group5/pull/239)
* [Me endpoint added](https://github.com/bounswe/bounswe2022group5/pull/242)  


 </details>
 
 



 <details><summary>Yavuz Samet Topcuoglu</summary>

## **Member:** [Yavuz Samet Topcuoglu](https://github.com/bounswe/bounswe2022group5/wiki/Yavuz-Samet-Topcuoglu), Group 5.
###  **Responsibilities:** 
-  Implementing one of the components of the website, as well as other documentation responsibilities.

###  **Main contributions:** 
- Implemented [Article card layout](https://github.com/bounswe/bounswe2022group5/tree/master/app/frontend/src/layouts/Article) and Article cards.
- Created an [Issue Template](https://github.com/bounswe/bounswe2022group5/wiki/Issue-Template) to be consistent within group.
- Formed a [scenario](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-1-for-Milestone-1) to be presented on Milestone 1.

	* **Code related significant issues:** 
		* [Issue #241](https://github.com/bounswe/bounswe2022group5/issues/241): Implementation of the Article card component which is going to be visible on the Homepage of the website.
		
	* **Management related significant issues:** 
		* [Issue #178](https://github.com/bounswe/bounswe2022group5/issues/241): Revising the [Use Case Diagram](https://github.com/bounswe/bounswe2022group5/wiki/Use-Case-Diagram), and made changes on it according to the changes done in [Requirements](https://github.com/bounswe/bounswe2022group5/wiki/Requirements) after the Customer Meeting.
		* [Issue #185](https://github.com/bounswe/bounswe2022group5/issues/185): Gathering suggestions for the name and logo of our project.
		* [Issue #268](https://github.com/bounswe/bounswe2022group5/issues/185): Forming a [scenario](https://github.com/bounswe/bounswe2022group5/wiki/Scenario-1-for-Milestone-1) where a doctor signs up and logs in to the website.
### **Pull requests:** 
-  [Pull Request #243](https://github.com/bounswe/bounswe2022group5/pull/243): Article cards are available to be displayed on the homepage.


 </details>
