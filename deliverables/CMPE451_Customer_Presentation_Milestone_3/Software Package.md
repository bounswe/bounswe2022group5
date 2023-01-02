
# Deployment (Of back-end application)

Our back-end application is written using Django framework, with **some of the** REST conventions. This app is then Dockerized and can be ran on Linux-based, Windows, or MacOS systems seamlessly. 

This application is deployed on AWS as one EC2 instance, without using any auto-managed tools, except for S3 buckets for static content (post images, user images, etc.).

Application uses PostgreSQL database as RDBMS, and this database application is also not AWS-managed RDS. It's totally structured, deployed, and managed by our team; as another EC2 instance.

Application follows a **monorepo** structure where mobile, web, back-end code, static content, and deliverables are all contained within the same Git repository.

# Deployment (Of frontend application)

Our frontend application is written using React.js framework. This app is then Dockerized and can be ran on Linux-based, Windows, or MacOS systems seamlessly. 

This application is deployed on AWS as one EC2 instance, without using any auto-managed tools.


# Final Release

Latest released version can be found on [this link](https://github.com/bounswe/bounswe2022group5/releases/tag/customer-presentation-3) in an appropriate format.

# Building Steps (of Backend)

1. Make sure the server which is supposed to run the application is **up-to-date** in terms of software
    - apt-get update; apt-get install;
2. Make sure Docker is installed and enabled as a service
    - apt-get install docker; service docker start; usermod -a -G docker os_username; chkconfig docker on;
3. Clone the git repo to the server and proceed to the back-end folder
    - git clone https://github.com/bounswe/bounswe2022group5.git
    - cd bounswe2022group5/app/backend
4. Installing Docker is not enough. Make sure you have **docker-compose** as well
    - sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o docker-compose
    - sudo chmod +x docker-compose
5. Set the environment variables
    - export DATABASE_HOST=ec2-100-24-23-233.compute-1.amazonaws.com
    - export DATABASE_PW=<_SECRET_>
    - export AWS_ACCESS_KEY_ID=<_SECRET_>
    - export AWS_SECRET_ACCESS_KEY=<_SECRET_>
6. Go ahead and run the docker script
    - ./docker-compose up

# Building Steps (of Frontend)

1. Make sure the server which is supposed to run the application is **up-to-date** in terms of software
    - apt-get update; apt-get install;
2. Make sure Docker is installed and enabled as a service
    - apt-get install docker; service docker start; usermod -a -G docker os_username; chkconfig docker on;
3. Clone the git repo to the server and proceed to the back-end folder
    - git clone https://github.com/bounswe/bounswe2022group5.git
    - cd bounswe2022group5/app/frontend
4. Create a docker image of the application
    - sudo docker build -t frontend .
5. Run the docker container
    - sudo docker run -d -p 3000:3000 frontend

# Database-Related Information & Example Data
  
We use PostgreSQL as mentioned earlier, deployed on an EC2 instance, fully managed by us. 


<details>

<summary> List of all our tables </summary>

- annotation_imageannotation
- annotation_textannotation
- articles_article
- articles_article_labels
- articles_articleimages
- auth_group
- auth_group_permissions
- auth_permission
- authtoken_token
- backend_category
- backend_customadmin
- backend_customuser
- backend_customuser_user_permissions
- backend_doctor
- backend_label
- backend_member
- backend_memberinfo
- backend_report
- django_admin_log
- django_content_type
- django_migrations
- django_session
- forum_comment
- forum_commentimages
- forum_post
- forum_post_labels
- forum_postimages
- forum_report

</details>
  
However, the most important ones are, of course, **forum_post** and **articles_article**. These tables store the root information about all posts and articles.


<details>

<summary> Example content: forum_post </summary>

```javascript
{
    "id" : 237,
    "title" : "Leg pain",
    "body" : "I have leg pain. Help me. When I walk there is nothing but when I sit there is so much pain. HELPP\n",
    "date" : "2022-12-27T00:03:04.570Z",
    "upvote" : 5,
    "downvote" : 0,
    "author_id" : 105,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 1,
    "related_labels" : "{Analgesia,Causalgia,\"Chest Pain\",Metatarsalgia,\"Nociceptive Pain\",\"Pain Insensitivity, Congenital\",\"Pain, Postoperative\",\"Breakthrough Pain\",Mastodynia,\"Slit Ventricle Syndrome\",Earache,Glossalgia,\"Nervous System Diseases\",Perception,\"Pain Threshold\",Sensation,\"Phantom Limb\",\"Pain, Intractable\",\"Trigeminal Neuralgia\",\"Abdomen, Acute\",\"Temporomandibular Joint Dysfunction Syndrome\",\"Eye Pain\",\"Chronic Pain\",Colic,Analgesics,\"Acute Pain\",\"Angina Pectoris\",\"Neurologic Manifestations\",\"Low Back Pain\",\"Nervous System Physiological Phenomena\",Sciatica,\"Pelvic Pain\",\"Facial Pain\",\"Headache Disorders\",\"Abdominal Pain\",Arthralgia,\"Morton Neuroma\",\"Failed Back Surgery Syndrome\",\"Labor Pain\",\"Neuralgia, Postherpetic\",\"Pain, Procedural\",Myalgia,\"Pain, Referred\",\"Musculoskeletal Pain\",\"Signs and Symptoms\",\"Neck Pain\",\"Facial Neuralgia\",Neuralgia,Psychophysiology,\"Palliative Care\",\"Shoulder Pain\",Hyperalgesia,\"Visceral Pain\",Headache,Toothache,\"Pudendal Neuralgia\",\"Renal Colic\",\"Flank Pain\",\"Pelvic Girdle Pain\",\"Cancer Pain\",\"Piriformis Muscle Syndrome\",Dysmenorrhea,\"Back Pain\"}"
},
{
    "id" : 236,
    "title" : "Acnes started to appear on my face",
    "body" : "Hello. I am 27 years old and I never had problems with aches. For the last 2 weeks, I have been getting acnes on my face very frequently. They keep appearing even if i squeeze them. Any doctors that can help? Thanks:)",
    "date" : "2022-12-26T23:59:34.394Z",
    "upvote" : 3,
    "downvote" : 1,
    "author_id" : 104,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 9,
    "related_labels" : "{}"
},
{
    "id" : 241,
    "title" : "Nausea and vomiting recently",
    "body" : "I feel like half of the day I feel nausea. I vomit once or twice a day. It started 3 days ago. I can't take it anymore. Should I visit a doctor? Can someone help?",
    "date" : "2022-12-27T00:44:26.529Z",
    "upvote" : 3,
    "downvote" : 0,
    "author_id" : 103,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 14,
    "related_labels" : "{Antiemetics,Emetics,\"Signs and Symptoms\",\"Postoperative Nausea and Vomiting\",\"Signs and Symptoms, Digestive\",\"Morning Sickness\",Antiemetics,Emetics,\"Vomiting, Anticipatory\",\"Signs and Symptoms\",\"Postoperative Nausea and Vomiting\",\"Hyperemesis Gravidarum\",\"Signs and Symptoms, Digestive\",Hematemesis}"
},
{
    "id" : 273,
    "title" : "There is probably a flu epidemic in Istanbul",
    "body" : "<p>There are a lot of posts about flu related issues from people around Istanbul lately. Please, be cautious and wear your masks!<\/p>",
    "date" : "2023-01-02T14:55:05.661Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 124,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 37,
    "related_labels" : "{}"
},
{
    "id" : 247,
    "title" : "Should I use contact lenses?",
    "body" : "I am using eyeglasses more than 5 years. Although I sohmehow get used to it, I am having difficulties while using it nowadays. Especially in winter periods, using eyeglasses is a nighmare! I think recently using contact lenses but I am not sure how to start, I even do not have any knowledge about lenses. Are there anybody ever used contact lenses? What do you think about them?",
    "date" : "2022-12-27T04:00:59.872Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 114,
    "latitude" : 37.421998333333335,
    "longitude" : -122.084,
    "commented_by_doctor" : false,
    "category_id" : 30,
    "related_labels" : "{}"
},
{
    "id" : 254,
    "title" : "Tinnitus and Hearing Loss",
    "body" : "<p>During the last month, my ears suddenly start ringing and it lasts for about thirty seconds. I have this problem on average two or three times a day. I also think I have sensory loss. I don't have any cold, flu etc complaints. What could be the problem? I'm attaching the x-ray I took.<\/p>",
    "date" : "2022-12-27T09:55:04.852Z",
    "upvote" : 0,
    "downvote" : 1,
    "author_id" : 122,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 32,
    "related_labels" : "{\"Persons With Hearing Impairments\",\"Hearing Loss, Central\",\"Hearing Loss, Noise-Induced\",\"Hearing Disorders\",Deafness,\"Deaf-Blind Disorders\",\"Hearing Loss, Sensorineural\",\"Hearing Aids\",\"Sensation Disorders\",Lipreading,\"Hearing Loss, Sudden\",\"Hearing Loss, High-Frequency\",Presbycusis,\"Hearing Loss, Functional\",\"Hearing Loss, Conductive\",\"Ear Diseases\",\"Hearing Loss, Mixed Conductive-Sensorineural\",\"Hearing Loss, Unilateral\",\"Hearing Loss, Bilateral\",\"Usher Syndromes\"}"
},
{
    "id" : 251,
    "title" : "Flu Epidemic",
    "body" : "<p>I have observed that a lot of people have the flu. What are you thinking about this issue?<\/p>",
    "date" : "2022-12-27T09:01:47.382Z",
    "upvote" : 3,
    "downvote" : 0,
    "author_id" : 115,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 13,
    "related_labels" : "{}"
},
{
    "id" : 261,
    "title" : "Shortness of Breath",
    "body" : "<p>I have been experiencing shortness of breath and difficulty breathing. I feel like I can't get enough air, even when resting. I am experiencing tightness in my chest and a persistent cough. I am seeking medical attention for my respiratory problems.<\/p>",
    "date" : "2022-12-27T10:12:37.869Z",
    "upvote" : 1,
    "downvote" : 1,
    "author_id" : 123,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{Expectorants,\"Antitussive Agents\"}"
},
{
    "id" : 259,
    "title" : "Reminder for Flu Season",
    "body" : "<p>Flu: The flu, or influenza, is a viral infection that affects the respiratory system. Symptoms of the flu can include fever, cough, sore throat, body aches, and fatigue. It is important to see a healthcare professional if you are experiencing severe symptoms or if you are at high risk for complications from the flu, such as people with weakened immune systems or chronic health conditions. A healthcare professional can prescribe antiviral medication to help reduce the severity and duration of your illness.<\/p>",
    "date" : "2022-12-27T10:07:31.698Z",
    "upvote" : 3,
    "downvote" : 0,
    "author_id" : 124,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{\"Pain Insensitivity, Congenital\",Analgesics,Hyperalgesia,Analgesia,\"Angina, Stable\",\"Microvascular Angina\",\"Palliative Care\",Pain,Sensation,\"Angina, Unstable\",\"Angina Pectoris\",\"Neurologic Manifestations\"}"
},
{
    "id" : 187,
    "title" : "My foot is injured",
    "body" : "I was playing football and I injured my ankle. Is there anything serious?\n",
    "date" : "2022-12-09T13:33:37.886Z",
    "upvote" : 4,
    "downvote" : 0,
    "author_id" : 84,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 1,
    "related_labels" : "{}"
},
{
    "id" : 130,
    "title" : "Headache After Jetlag",
    "body" : "I have migrene. But it never had continued this long in my life. I have a severe headache since I had a 13 hour long flight last week. Since then, it never stopped. What should I do?",
    "date" : "2022-12-04T19:15:05.761Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : 37.4220936,
    "longitude" : -122.083922,
    "commented_by_doctor" : false,
    "category_id" : 1,
    "related_labels" : "{}"
},
{
    "id" : 114,
    "title" : "Headache for 10 days",
    "body" : "I have a headache. I did not stop since I had a 13 hours long flight 10 days ago. I always had migrene but this pain feels different and it has been so long. What should I do?",
    "date" : "2022-12-04T18:31:30.613Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : 37.4220936,
    "longitude" : -122.083922,
    "commented_by_doctor" : true,
    "category_id" : 2,
    "related_labels" : "{}"
},
{
    "id" : 242,
    "title" : "Sometimes I Can Feel My Heart Skip A Beat",
    "body" : "Ever since I learned about my friend having aortic disease, I can focus and feel like my heart is skipping a beat.",
    "date" : "2022-12-27T00:52:17.625Z",
    "upvote" : 4,
    "downvote" : 1,
    "author_id" : 102,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 3,
    "related_labels" : "{Endocardium,\"Ductus Arteriosus\",\"Cardiotonic Agents\",\"Pericardial Fluid\",Pericardium,Pericardiectomy,\"Papillary Muscles\",\"Heart Septum\",\"Cardiovascular System\",\"Tricuspid Valve\",Ballistocardiography,\"Ventricular Septum\",\"Radionuclide Ventriculography\",\"Arrhythmias, Cardiac\",\"Purkinje Fibers\",\"Truncus Arteriosus\",\"Blood Circulation\",\"Fetal Heart\",\"Heart Ventricles\",\"Ventricular Pressure\",\"Chordae Tendineae\",Electrocardiography,\"Bundle of His\",\"Myocytes, Cardiac\",\"Atrioventricular Node\",\"Anti-Arrhythmia Agents\",\"Heart Atria\",\"Pulmonary Valve\",\"Sinoatrial Node\",Myocardium,\"Atrial Function\",\"Atrial Septum\",\"Myoblasts, Cardiac\",\"Endocardial Cushions\",Angiocardiography,\"Heart Conduction System\",\"Aortic Valve\",\"Mitral Valve\",\"Foramen Ovale\",\"Heart Valves\",\"Atrial Appendage\"}"
},
{
    "id" : 248,
    "title" : "I Went Into Cardiac Arrest on the Tennis Court",
    "body" : "<p><span style=\"background-color: rgb(255, 255, 255); color: rgb(68, 68, 68);\">I was 45 years old and healthy. I'd never experienced any heart issues. There were no physical warning signs leading up to the&nbsp;cardiac arrest that almost took my life. Because both my uncle and cousin had these issues, their doctor did genetic testing and found that they shared a mutation in the FLNC gene that codes for a protein in heart muscle.&nbsp;Should I be worried about myself?<\/span><\/p>",
    "date" : "2022-12-27T06:29:28.870Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 92,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 3,
    "related_labels" : "{}"
},
{
    "id" : 252,
    "title" : "Seeking help for mysterious health issue",
    "body" : "Hi everyone,\n\nI'm hoping someone here might be able to help me out with a health problem that I've been experiencing for the past few months. I'm not sure what's causing it, and my doctor hasn't been able to give me a clear diagnosis.\n\nHere are the symptoms I've been experiencing:\n\nChronic fatigue\nMuscle and joint pain\nHeadaches\nDifficulty sleeping\nLow appetite\n\nI've had some blood work done and everything seems to be normal. My doctor has suggested it might be fibromyalgia, but I'm not convinced that's the cause.\n\nI'm really hoping someone here might have some ideas or experiences that could help me figure out what's going on. Any input or advice would be greatly appreciated.\n\nThanks!",
    "date" : "2022-12-27T09:48:57.388Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 62,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : true,
    "category_id" : 8,
    "related_labels" : "{\"Signs and Symptoms\",Asthenia,\"Alert Fatigue, Health Personnel\",\"Mental Fatigue\",\"Pathological Conditions, Signs and Symptoms\",\"Compassion Fatigue\",\"Overtraining Syndrome\",Analgesia,Sensation,Pain,\"Pain Insensitivity, Congenital\",Analgesics,\"Neurologic Manifestations\",\"Headache Disorders\",\"Slit Ventricle Syndrome\",\"Palliative Care\",Hyperalgesia}"
},
{
    "id" : 255,
    "title" : "Breath Issues",
    "body" : "<p>I've been observing problems with breathing lately. Are there people around you who have this problem?<\/p>",
    "date" : "2022-12-27T10:00:19.839Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 121,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 39,
    "related_labels" : "{Respiration,\"Respiratory System\",Pneumonectomy,\"Air Sacs\",\"Blood-Air Barrier\",\"Bronchodilator Agents\",\"Alveolar Epithelial Cells\",Bronchioles,Bronchography,\"Pulmonary Circulation\",Bronchoscopy,\"Pulmonary Alveoli\",Bronchi,\"Bronchoconstrictor Agents\"}"
},
{
    "id" : 266,
    "title" : "Feeling tired and weak",
    "body" : "<p>I have been experiencing a range of symptoms that have been affecting my daily life, and I am not sure what is causing them. I have been feeling tired and weak, and I have been having difficulty sleeping. I have also been experiencing stomach pain and changes in my appetite. My doctor has mentioned that these symptoms could be related to a problem with my internal medicine, but I am not sure what that means or how to address it. I am looking for guidance on how to manage these symptoms and improve my overall health.<\/p>",
    "date" : "2022-12-27T10:37:15.921Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 128,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 15,
    "related_labels" : "{}"
},
{
    "id" : 264,
    "title" : "Do I have Vertigo?",
    "body" : "I frequently feel dizziness lately especially when I am physically active and sometimes I have blurred vision at those times. I have to sit down and rest for a while to feel better. I made a reserch and found out that vertigo might cause these sypmtoms. Should I be worried? I can't see a doctor because I could not find any available appointment in the hospitals close to me.",
    "date" : "2022-12-27T10:23:18.553Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 108,
    "latitude" : 41.084785,
    "longitude" : 29.05094,
    "commented_by_doctor" : false,
    "category_id" : 25,
    "related_labels" : "{\"Benign Paroxysmal Positional Vertigo\",Dizziness,\"Signs and Symptoms\",\"Vestibular Diseases\",\"Labyrinth Diseases\",\"Vestibular Neuronitis\",\"Nervous System Diseases\",\"Neurologic Manifestations\",Vertigo}"
},
{
    "id" : 268,
    "title" : "I have a chest pain",
    "body" : "<p>I don't know what's going on with my chest. It's been hurting for days and I just can't shake this cough. It's so annoying! I've tried everything - cough syrup, warm liquids, even over-the-counter pain meds - but nothing seems to be working. I can't even sleep at night because of the pain. It's just so frustrating. I don't know what to do<\/p>",
    "date" : "2022-12-27T11:20:53.583Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 130,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 39,
    "related_labels" : "{}"
},
{
    "id" : 175,
    "title" : "Headache in the mornings",
    "body" : "<p>Hi, <\/p><p>Nowadays I feel very tired. Every morning I wake up with a strong headache from my temples to my ears. What can I do about it? Has anyone experienced something like this before? <\/p>",
    "date" : "2022-12-06T05:53:36.447Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 73,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : null,
    "related_labels" : "{}"
},
{
    "id" : 176,
    "title" : "Am I Poisoned?",
    "body" : "I have a severe stomachache and diarrhea for 3  days. Even though I took medicine it did not get better. I heated frozen meat and ate it 3 days ago. Is it about it?",
    "date" : "2022-12-06T08:07:13.973Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : 37.4219985,
    "longitude" : -122.0839999,
    "commented_by_doctor" : false,
    "category_id" : 1,
    "related_labels" : "{}"
},
{
    "id" : 159,
    "title" : "Hertache after covid",
    "body" : "I have a hearache for 10 days. I had covid before that. Is it normal?",
    "date" : "2022-12-05T19:56:59.512Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 1,
    "related_labels" : "{}"
},
{
    "id" : 182,
    "title" : "I can not sleep well!",
    "body" : "<p>Hi, I feel very exhausted and always feel that I need more sleep. Is there anyone has this issue?<\/p>",
    "date" : "2022-12-06T11:40:24.874Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 82,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 8,
    "related_labels" : "{}"
},
{
    "id" : 183,
    "title" : "My Child Has Covid",
    "body" : "My child has covid. He doesn't stop coughing. Especially during nights. We use the medicine the doctor gave but it seems to be not working. What else should I do ?",
    "date" : "2022-12-06T11:47:01.820Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : 37.4219985,
    "longitude" : -122.0839999,
    "commented_by_doctor" : false,
    "category_id" : 1,
    "related_labels" : "{}"
},
{
    "id" : 184,
    "title" : "Exam Anxiety",
    "body" : "Do you have any reccomendations to cope with exam anxiety? I even cannot sleep before the exam. And I feel like my heartbeat increases a lot during the exams. This also effects the result of the exam :(",
    "date" : "2022-12-06T11:50:04.056Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : null,
    "longitude" : null,
    "commented_by_doctor" : true,
    "category_id" : 1,
    "related_labels" : "{}"
},
{
    "id" : 185,
    "title" : "Tingle in Left Leg and Backache",
    "body" : "<p>Last day, I immediately started feeling a tingle in my left leg. It may be related to that: for two weeks, I had experienced a dull ache in my back, but three days ago, it started to become more severe. I am not sure, but I think I have a herniated disc. What do you think? Is there anybody who has experienced this kind of problem before?<\/p>",
    "date" : "2022-12-06T11:51:11.119Z",
    "upvote" : 0,
    "downvote" : 1,
    "author_id" : 62,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 31,
    "related_labels" : "{}"
},
{
    "id" : 249,
    "title" : "Don't Delay to Visit your Doctor",
    "body" : "<p>As I've seen with many of my patients, we delay doctor visits too long. Let's not do this. Early detection often enables diseases to be found early and prevents larger health problems. What do you think about this situation?<\/p>",
    "date" : "2022-12-27T07:16:04.290Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 115,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : null,
    "related_labels" : "{Diagnosis,\"Early Detection of Cancer\"}"
},
{
    "id" : 203,
    "title" : "terrible headache!",
    "body" : "I cannot recover. It has been 10 days. Should I be worried?",
    "date" : "2022-12-25T09:30:09.585Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 68,
    "latitude" : 41.084785,
    "longitude" : 29.05094,
    "commented_by_doctor" : false,
    "category_id" : 26,
    "related_labels" : null
},
{
    "id" : 250,
    "title" : "Health Issues In Winter ",
    "body" : "<p>Cold weather can make some health problems worse and even lead to serious complications, especially if you're 65 or older, or if you have a long-term health condition.",
    "date" : "2022-12-27T07:31:13.999Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 115,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 13,
    "related_labels" : "{\"Middle East Respiratory Syndrome Coronavirus\",Deltacoronavirus,\"Severe acute respiratory syndrome-related coronavirus\",Nidovirales,\"Infectious bronchitis virus\",\"Alphacoronavirus 1\",\"Coronavirus NL63, Human\",\"Porcine epidemic diarrhea virus\",\"Betacoronavirus 1\",\"Coronavirus 229E, Human\",Betacoronavirus,Gammacoronavirus,\"Coronavirus, Rat\",\"Murine hepatitis virus\",Coronaviridae,Alphacoronavirus,\"Coronavirus, Turkey\"}"
},
{
    "id" : 256,
    "title" : "Seeking help for shortness of breath",
    "body" : "I'm reaching out for help with a health issue I've been experiencing lately - shortness of breath. It comes on suddenly and can last for a few minutes to an hour. I'm a 32-year-old non-smoking female and generally consider myself to be in good health. My doctor did some basic tests, but everything came back normal. Has anyone else experienced something similar? If so, what did you do to manage it? I'm hoping to get some ideas or advice from others. Thank you!",
    "date" : "2022-12-27T10:01:56.212Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 114,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{}"
},
{
    "id" : 253,
    "title" : "Difficulty breathing while sleeping",
    "body" : "<p>Hello everyone, I have trouble breathing while sleeping and I wake up out of breath. I think I also have a snoring problem. Is there a treatment for this that I can do on my own at home?<\/p><p><br><\/p>",
    "date" : "2022-12-27T09:49:54.870Z",
    "upvote" : 0,
    "downvote" : 1,
    "author_id" : 122,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 32,
    "related_labels" : "{Sleepiness,\"Sleep Quality\",\"Sleep Deprivation\",\"Sleep, REM\",\"Psychosomatic Medicine\",\"Nervous System Physiological Phenomena\",Polysomnography,\"Sleep Wake Disorders\",\"Sleep Stages\",\"Sleep Latency\",\"Sleep, Slow-Wave\",\"Behavioral Sciences\",Psychophysiology,\"Sleep Hygiene\",Dreams,\"Psychological Phenomena\",Physiology,\"Musculoskeletal and Neural Physiological Phenomena\",\"Sleep Duration\"}"
},
{
    "id" : 257,
    "title" : "Ear Ringing and Throat Pain",
    "body" : "<p>I have been experiencing a lot of discomfort and pain in my ears, nose, and throat. My ears have been ringing constantly and feel congested, and I have had difficulty breathing through my nose. My throat is sore and scratchy, and I have had trouble swallowing. I have also had a lot of headaches and general discomfort. I am having trouble sleeping and functioning normally due to the severity of these issues. I am seeking medical attention for some ENT problems and hope to find relief soon. Is there any one to help me?<\/p>",
    "date" : "2022-12-27T10:04:50.686Z",
    "upvote" : 0,
    "downvote" : 1,
    "author_id" : 123,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 32,
    "related_labels" : "{\"Maxillary Sinus\",\"Olfactory Receptor Neurons\",\"Nasal Septum\",Turbinates,\"Nasal Bone\",\"Vomeronasal Organ\",\"Respiratory System\",\"Goblet Cells\",\"Sensory Receptor Cells\",\"Nasal Cavity\",Vomer,\"Nasal Septal Perforation\",\"Sphenoid Sinus\",\"Sense Organs\",\"Ethmoid Sinus\",\"Nasal Cartilages\",Rhinoplasty,\"Nasal Mucosa\",\"Paranasal Sinuses\",\"Frontal Sinus\",\"Olfactory Mucosa\"}"
},
{
    "id" : 267,
    "title" : "Influenza epidemic",
    "body" : "In my neighbourhood, there is an influenza epidemic and almost all my neighbours got influenza recently. I haven't got it yet but I am worried. My immune system is not working vey well and I am sure it will be severe if I get it. What should I do to protect myself?",
    "date" : "2022-12-27T10:46:41.890Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 108,
    "latitude" : 41.084785,
    "longitude" : 29.05094,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{}"
},
{
    "id" : 192,
    "title" : "Sun allergy",
    "body" : "My skin is very sensitive to the sun. It gets so painful eventhough I use sunscreen aspecially in thesummer. What should I do?",
    "date" : "2022-12-24T11:42:57.899Z",
    "upvote" : 2,
    "downvote" : 1,
    "author_id" : 68,
    "latitude" : 37.4219985,
    "longitude" : -122.0839999,
    "commented_by_doctor" : false,
    "category_id" : 9,
    "related_labels" : "{}"
},
{
    "id" : 204,
    "title" : "Voice change after covid",
    "body" : "My voice has changed after I got covid. Is it normal?",
    "date" : "2022-12-25T09:37:34.572Z",
    "upvote" : 3,
    "downvote" : 1,
    "author_id" : 68,
    "latitude" : 41.084785,
    "longitude" : 29.05094,
    "commented_by_doctor" : false,
    "category_id" : 33,
    "related_labels" : null
},
{
    "id" : 186,
    "title" : "Foot Injury",
    "body" : "<p>Hello, yesterday I was playing in a football match and I went for a tackle.<\/p><p>I thought my ankle was broken and went immediately to the hospital.<\/p><p>I got a CT scan of my ankle. Doctor said that there isn't any bone fracture and simply I had sprained my ankle.<\/p>",
    "date" : "2022-12-06T12:32:28.075Z",
    "upvote" : 3,
    "downvote" : 1,
    "author_id" : 82,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 31,
    "related_labels" : "{}"
},
{
    "id" : 258,
    "title" : "My cough did not recover after flu",
    "body" : "I had flu a mounth ago. The other symptoms had recovered in a week. But my cough did not. I still cough a lot and it is I guess dry cough. Should I be worried?",
    "date" : "2022-12-27T10:06:07.281Z",
    "upvote" : 0,
    "downvote" : 2,
    "author_id" : 68,
    "latitude" : 41.084785,
    "longitude" : 29.05094,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{Expectorants,\"Antitussive Agents\"}"
},
{
    "id" : 265,
    "title" : "About my weight!",
    "body" : "<p>I have been struggling with managing my metabolism and endocrine system. My weight has been fluctuating significantly, even though I have been trying to maintain a healthy diet and exercise routine. I have also been experiencing fatigue, irritability, and difficulty concentrating. My doctor has mentioned that I may have a hormonal imbalance or an underlying endocrine disorder, but I am not sure what to do about it. I am worried about the potential long-term effects on my health and quality of life, and I am seeking guidance on how to address these issues.<\/p>",
    "date" : "2022-12-27T10:26:07.990Z",
    "upvote" : 4,
    "downvote" : 0,
    "author_id" : 128,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : 12,
    "related_labels" : "{}"
},
{
    "id" : 269,
    "title" : "Sore throat",
    "body" : "<p>I have been drinking\/eating ice cubes for like 6 months now. There were no problems in the first place, but now it seems a bit problematic.<\/p>",
    "date" : "2022-12-31T10:51:08.748Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 98,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : false,
    "category_id" : null,
    "related_labels" : "{}"
},
{
    "id" : 262,
    "title" : "Chest Pain",
    "body" : "Chest pain can be caused by a variety of conditions, including muscle strain, heart attack, and pneumonia. If you are experiencing chest pain, it is important to seek medical attention immediately. The severity of your chest pain and other symptoms will help your healthcare professional determine the cause of your pain and the best course of treatment.",
    "date" : "2022-12-27T10:16:07.910Z",
    "upvote" : 1,
    "downvote" : 2,
    "author_id" : 126,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{\"Heart Atria\",\"Arrhythmias, Cardiac\",Myocardium,\"Radionuclide Ventriculography\",\"Cardiotonic Agents\",\"Mitral Valve\",\"Heart Septum\",\"Aortic Valve\",Angiocardiography,Electrocardiography,\"Atrial Septum\",Pericardiectomy,\"Chordae Tendineae\",\"Papillary Muscles\",\"Atrioventricular Node\",\"Blood Circulation\",\"Myocytes, Cardiac\",\"Ductus Arteriosus\",\"Bundle of His\",\"Heart Ventricles\",Ballistocardiography,\"Atrial Appendage\",\"Myoblasts, Cardiac\",\"Ventricular Septum\",\"Heart Conduction System\",\"Ventricular Pressure\",\"Pericardial Fluid\",\"Sinoatrial Node\",\"Heart Valves\",\"Truncus Arteriosus\",\"Anti-Arrhythmia Agents\",\"Tricuspid Valve\",\"Pulmonary Valve\",\"Fetal Heart\",\"Cardiovascular System\",Endocardium,\"Endocardial Cushions\",Pericardium,\"Atrial Function\",\"Foramen Ovale\",\"Purkinje Fibers\",Respiration,\"Respiratory System\",Pneumonectomy,\"Air Sacs\",\"Blood-Air Barrier\",\"Bronchodilator Agents\",\"Alveolar Epithelial Cells\",Bronchioles,Bronchography,\"Pulmonary Circulation\",Bronchoscopy,\"Pulmonary Alveoli\",Bronchi,\"Bronchoconstrictor Agents\"}"
},
{
    "id" : 263,
    "title" : "Flu with Chest Pain",
    "body" : "<p>I'm hoping to get some advice on a health issue I've been dealing with lately. I came down with the flu a few days ago, and since then I've been experiencing some chest pain. It's a sharp, stabbing sensation that comes and goes and is worse when I take a deep breath.<\/p>",
    "date" : "2022-12-27T10:18:34.878Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 121,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : false,
    "category_id" : 39,
    "related_labels" : "{}"
},
{
    "id" : 260,
    "title" : "Hearing loss",
    "body" : "<p>I have difficulty hearing people and following conversations. I often ask people to repeat themselves and turn up the volume on the TV or radio. I am seeking medical attention for my hearing loss.<\/p>",
    "date" : "2022-12-27T10:09:32.360Z",
    "upvote" : 3,
    "downvote" : 0,
    "author_id" : 123,
    "latitude" : 41.025531666666666,
    "longitude" : 29.013271666666668,
    "commented_by_doctor" : false,
    "category_id" : 30,
    "related_labels" : "{\"Persons With Hearing Impairments\",\"Hearing Loss, Central\",\"Hearing Loss, Noise-Induced\",\"Hearing Disorders\",Deafness,\"Deaf-Blind Disorders\",\"Hearing Loss, Sensorineural\",\"Hearing Aids\",\"Sensation Disorders\",Lipreading,\"Hearing Loss, Sudden\",\"Hearing Loss, High-Frequency\",Presbycusis,\"Hearing Loss, Functional\",\"Hearing Loss, Conductive\",\"Ear Diseases\",\"Hearing Loss, Mixed Conductive-Sensorineural\",\"Hearing Loss, Unilateral\",\"Hearing Loss, Bilateral\",\"Usher Syndromes\"}"
},
{
    "id" : 272,
    "title" : "Chest Pain While Coughing",
    "body" : "<p><span style=\"background-color: rgb(247, 253, 252);\">I don't know what's going on with my chest. It's been hurting for days and I just can't shake this cough. It's so annoying! I've tried everything - cough syrup, warm liquids, even over-the-counter pain meds - but nothing seems to be working. I can't even sleep at night because of the pain. It's just so frustrating. I don't know what to do<\/span><\/p>",
    "date" : "2023-01-02T14:17:39.701Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 131,
    "latitude" : 0.0,
    "longitude" : 0.0,
    "commented_by_doctor" : true,
    "category_id" : 39,
    "related_labels" : "{Expectorants,\"Antitussive Agents\",\"Angina Pectoris\",\"Angina, Stable\",Pain,\"Palliative Care\",Analgesia,Analgesics,\"Neurologic Manifestations\",\"Microvascular Angina\",Sensation,\"Angina, Unstable\",\"Pain Insensitivity, Congenital\",Hyperalgesia}"
}
```

</details>
  
<details>

<summary> Example content: articles_article </summary>

```javascript
{
    "id" : 42,
    "title" : "Child Healthcare and Issues",
    "body" : "<h3><strong>What Happens Right After Birth?<\/strong><\/h3><p>Your baby's&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/checkup-hospital.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">first exam<\/a>&nbsp;will either happen in the nursery or at your side. It includes:<\/p><ul><li>measuring weight, length, and head circumference<\/li><li>taking your baby's temperature<\/li><li>measuring your baby's breathing and heart rate<\/li><li>watching skin color and your newborn's activity<\/li><li>giving eye drops or ointment to prevent eye infections<\/li><li>giving a&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/vitamin-k-shot.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">vitamin K shot<\/a>&nbsp;to prevent the possibility of bleeding<\/li><\/ul><p>Your baby will get a first bath, and the umbilical cord stump will be cleaned. Most hospitals and birthing centers give information to&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/guide-parents.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">new parents<\/a>&nbsp;on&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/feednewborn.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">feeding<\/a>, bathing, and other important parts of newborn care.<\/p><h3><strong>What Happens When the Doctor Visits?<\/strong><\/h3><p>The hospital or birth center where you deliver will notify your child's doctor of the birth. A pediatrician or your baby's doctor will be standing by to take care of the baby if:<\/p><ul><li>you had any medical problems during pregnancy<\/li><li>your baby might have a medical problem<\/li><li>you have a&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/c-sections.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">C-section<\/a><\/li><\/ul><p>The doctor you chose for your newborn will examine your baby within 24 hours of birth. This is a good time to ask questions about your baby's care.<\/p><p>A sample of your baby's blood (usually done by pricking the baby's heel) will be&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/newborn-screening-tests.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">screened<\/a>&nbsp;for some diseases. It's important to diagnose these at birth so treatment can begin right away.<\/p><h3><strong>What Happens at the First Office Visit?<\/strong><\/h3><p>Your newborn will have an exam at the doctor's office within&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/checkup-2weeks.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">3 to 5 days<\/a>&nbsp;of birth. During the first office visit, your doctor will check your baby in a few ways. Your doctor will probably:<\/p><ul><li>measure weight, length, and head circumference<\/li><li>observe your newborn's&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/sensenewborn.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">vision, hearing<\/a>, and reflexes<\/li><li>do a complete physical exam<\/li><li>ask how you're doing with the new baby and how your baby is eating and sleeping<\/li><li>talk about what you can expect in the coming month<\/li><li>discuss your home environment and how it could affect your baby (for example,&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/secondhand-smoke.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">smoking<\/a>&nbsp;in the house can harm your baby's health in many ways)<\/li><\/ul><p>You also might talk about the results of the screening tests done right after birth, if they're ready. Jot down any instructions about special baby care, and bring up your questions or concerns. Keep a&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/medhist.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">medical record<\/a>&nbsp;for your baby that includes information about&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/childs-growth.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">growth<\/a>,&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/vaccine.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">immunizations<\/a>, medicines, and any problems or illnesses.<\/p><h3><strong>What About Vaccines?<\/strong><\/h3><p>A baby is born with some natural immunity against infectious diseases. That's because the mother's infection-preventing antibodies are passed through the umbilical cord. This immunity is temporary. But babies will develop their own immunity against many infectious diseases. For instance,&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/breast-bottle-feeding.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">breastfed<\/a>&nbsp;babies get antibodies and enzymes in breast milk that help protect them from some infections and even some allergic conditions.<\/p><p>Infants should get their first shot of the&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/hepb-vaccine.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">hepatitis B vaccine<\/a>&nbsp;in the hospital within 24 hours of birth. Some newborns need it even sooner (if their mother carries the hepatitis B virus in her blood) and others might need to wait a little longer (if they were&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/born-early.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">born early<\/a>&nbsp;and had a low birth weight). Babies will get more vaccines in the coming months based on a standard&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/immunization-chart.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">immunization schedule<\/a>.<\/p><h3><strong>When Should I Call the Doctor?<\/strong><\/h3><p>Call your doctor if you have concerns about your newborn. These problems can be common during this first month:<\/p><ul><li>One or both&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/tear-duct-obstruct-surgery.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">tear ducts<\/a>&nbsp;can get blocked and cause eye problems. Normally the ducts open on their own before too long, usually by the baby's first birthday. But sometimes they stay clogged, which can cause tearing and eye discharge. Call your doctor if you suspect an eye infection.<\/li><li><a href=\"https:\/\/kidshealth.org\/en\/parents\/fever.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">Fever<\/a>&nbsp;in a newborn (rectal temperature above 100.4°F or 38°C) should be reported to your doctor right away.<\/li><li>A runny nose can make it hard for a baby to breathe well, especially during feeding. You can help ease discomfort by using a rubber bulb aspirator to gently suction mucus from the nose. Call your doctor if you have concerns about your baby's breathing.<\/li><li>It's normal for newborns to have loose stools (poop) or to spit up after feedings. But very loose and watery stools and forceful vomiting could mean there is a problem. Call your doctor if your baby:<\/li><li class=\"ql-indent-1\">has&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/diarrhea.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">diarrhea<\/a><\/li><li class=\"ql-indent-1\">is&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/vomit.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">vomiting<\/a><\/li><li class=\"ql-indent-1\">has signs of&nbsp;<a href=\"https:\/\/kidshealth.org\/en\/parents\/dehydration.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">dehydration<\/a>, such as fewer wet diapers, a dry mouth, and being very sluggish or drowsy<\/li><\/ul><p><br><\/p>",
    "date" : "2022-12-27T06:32:18.997Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 115,
    "category_id" : null
},
{
    "id" : 31,
    "title" : "Pimples ",
    "body" : "You should not play with pimples.",
    "date" : "2022-12-06T11:53:01.908Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 79,
    "category_id" : 1
},
{
    "id" : 44,
    "title" : "AI in Medicine",
    "body" : "<p>Artificial intelligence in medicine is the use of machine learning models to search medical data and uncover insights to help improve health outcomes and patient experiences. Thanks to recent advances in computer science and informatics, artificial intelligence (AI) is quickly becoming an integral part of modern healthcare. AI algorithms and other applications powered by AI are being used to support medical professionals in clinical settings and in ongoing research.<\/p><p>Currently, the most common roles for AI in medical settings are clinical decision support and imaging analysis. Clinical decision support tools help providers make decisions about treatments, medications, mental health and other patient needs by providing them with quick access to information or research that's relevant to their patient. In medical imaging, AI tools are being used to analyze CT scans, x-rays, MRIs and other images for lesions or other findings that a human radiologist might miss.<\/p><p>The challenges that the COVID-19 pandemic created for many health systems also led many healthcare organizations around the world to start field-testing new AI-supported technologies, such as algorithms designed to help monitor patients and AI-powered tools to screen COVID-19 patients.<\/p><p>The research and results of these tests are still being gathered, and the overall standards for the use AI in medicine are still being defined. Yet opportunities for AI to benefit clinicians, researchers and the patients they serve are steadily increasing. At this point, there is little doubt that AI will become a core part of the digital health systems that shape and support modern medicine.<\/p>",
    "date" : "2022-12-27T07:20:02.968Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 115,
    "category_id" : null
},
{
    "id" : 46,
    "title" : "Eye Distance While Working in Computers",
    "body" : "If you spend a significant amount of time using computers or other electronic devices, it is important to ensure that your eye distance is properly adjusted to reduce strain on your eyes.\n\nTo do this, start by sitting in a comfortable position in front of your computer with your eyes looking straight ahead at the screen. Your screen should be positioned at a distance that allows you to read the text on it comfortably, without having to strain your eyes or lean forward.\n\nNext, adjust the height of your screen so that the top of the screen is level with your eyes or slightly below eye level. This will allow you to look straight ahead at the screen without having to tilt your head up or down, which can cause eye strain.\n\nIf you wear glasses or contact lenses, make sure that your prescription is up to date and that your glasses or contacts are properly adjusted. This will help to ensure that you have clear, comfortable vision while using the computer.\n\nIt is also important to take regular breaks from the computer to give your eyes a rest. Try the 20-20-20 rule: every 20 minutes, take a 20-second break and look at something 20 feet away. This can help to reduce eye strain and fatigue.\n\nIf you experience any symptoms of eye strain, such as blurred vision, dry eyes, or headaches, it is important to see an ophthalmologist to rule out any underlying problems and to get the appropriate treatment.",
    "date" : "2022-12-27T08:59:45.385Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 119,
    "category_id" : 30
},
{
    "id" : 50,
    "title" : "Hearing Loss",
    "body" : "<h2><strong>Signs of Hearing Loss<\/strong><\/h2><p>Some people have a hearing problem and don’t realize it. You should see your doctor if you:<\/p><ul><li>Have trouble hearing over the telephone<\/li><li>Find it hard to follow conversations when two or more people are talking<\/li><li>Often ask people to repeat what they are saying<\/li><li>Need to turn up the TV volume so loud that others complain<\/li><li>Have a problem hearing because of background noise<\/li><li>Think that others seem to mumble<\/li><li>Can’t understand when women and children speak to you<\/li><\/ul><h2><strong>Types of Hearing Loss<\/strong><\/h2><p>Hearing loss comes in many forms. It can range from a mild loss, in which a person misses certain high-pitched sounds, such as the voices of women and children, to a total loss of hearing.<\/p><p>There are two general categories of hearing loss:<\/p><ul><li><strong>Sensorineural hearing loss<\/strong>&nbsp;occurs when there is damage to the inner ear or the auditory nerve. This type of hearing loss is usually permanent.<\/li><li><strong>Conductive hearing loss<\/strong>&nbsp;occurs when sound waves cannot reach the inner ear. The cause may be earwax buildup, fluid, or a punctured eardrum. Medical treatment or surgery can usually restore conductive hearing loss.<\/li><\/ul><h3><strong>Sudden Hearing Loss<\/strong><\/h3><p>Sudden sensorineural hearing loss, or sudden deafness, is a rapid loss of hearing. It can happen to a person all at once or over a period of up to 3 days. It should be considered a medical emergency. If you or someone you know experiences sudden sensorineural hearing loss, visit a doctor immediately.<\/p><h3><strong>Age-Related Hearing Loss (Presbycusis)<\/strong><\/h3><p>Presbycusis, or age-related hearing loss, comes on gradually as a person gets older. It seems to run in families and may occur because of changes in the inner ear and auditory nerve. Presbycusis may make it hard for a person to tolerate loud sounds or to hear what others are saying.<\/p><p>Age-related hearing loss usually occurs in both ears, affecting them equally. The loss is gradual, so someone with presbycusis may not realize that he or she has lost some of his or her ability to hear.<\/p><h3><strong>Ringing in the Ears (Tinnitus)<\/strong><\/h3><p><a href=\"https:\/\/www.nidcd.nih.gov\/health\/tinnitus\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">Tinnitus<\/a>&nbsp;is also common in older people. It is typically described as ringing in the ears, but it also can sound like roaring, clicking, hissing, or buzzing. It can come and go. It might be heard in one or both ears, and it may be loud or soft. Tinnitus is sometimes the first sign of hearing loss in older adults. Tinnitus can accompany any type of hearing loss and can be a sign of other health problems, such as&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/high-blood-pressure\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">high blood pressure<\/a>, allergies, or as a side effect of&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/what-do-i-need-tell-doctor\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">medications.<\/a><img src=\"https:\/\/www.nia.nih.gov\/sites\/default\/files\/inline-images\/hearing-loss-older-adults-inline.jpg\" alt=\"Nurse giving older woman an ear exam\" height=\"320\" width=\"564\"><\/p><p>Tinnitus is a symptom, not a disease. Something as simple as a piece of earwax blocking the ear canal can cause tinnitus, but it can also be the result of a number of health conditions.<\/p><h2><strong>Causes of Hearing Loss<\/strong><\/h2><p><a href=\"https:\/\/www.nidcd.nih.gov\/health\/noise-induced-hearing-loss\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">Loud noise is one of the most common causes of hearing loss<\/a>. Noise from lawn mowers, snow blowers, or loud music can damage the inner ear, resulting in permanent hearing loss. Loud noise also contributes to tinnitus. You can prevent most noise-related hearing loss. Protect yourself by turning down the sound on your stereo, television, or headphones; moving away from loud noise; or using earplugs or other ear protection.<\/p><p>Earwax or fluid buildup can block sounds that are carried from the eardrum to the inner ear. If wax blockage is a problem,&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/doctor-patient-communication\/talking-with-your-doctor\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">talk with your doctor<\/a>. He or she may suggest mild treatments to soften earwax.<\/p><p>A punctured ear drum can also cause hearing loss. The eardrum can be damaged by infection, pressure, or putting objects in the ear, including cotton-tipped swabs. See your doctor if you have pain or fluid draining from the ear.<\/p><p>Health conditions common in older people, such as&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/diabetes-older-people\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">diabetes<\/a>&nbsp;or&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/high-blood-pressure\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">high blood pressure<\/a>, can contribute to hearing loss. Viruses and bacteria (including the ear infection otitis media), a&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/heart-health-and-aging\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">heart condition<\/a>,&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/stroke\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">stroke<\/a>, brain injury, or a tumor may also affect your hearing.<\/p><p>Hearing loss can also result from taking certain medications. “Ototoxic” medications damage the inner ear, sometimes permanently. Some ototoxic drugs include medicines used to treat serious infections,&nbsp;<a href=\"https:\/\/www.cancer.gov\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">cancer<\/a>, and&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/heart-health-and-aging#heart-disease\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">heart disease<\/a>. Some antibiotics are ototoxic. Even aspirin at some dosages can cause problems. Check with your doctor if you notice a problem while taking a medication.<\/p><p>Heredity can cause hearing loss, as well. But not all inherited forms of hearing loss take place at birth. Some forms can show up later in life. For example, in&nbsp;<a href=\"https:\/\/www.nidcd.nih.gov\/health\/otosclerosis\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">otosclerosis<\/a>, which is thought to be a hereditary disease, an abnormal growth of bone prevents structures within the ear from working properly.<\/p><h2><strong>Hearing Loss Can Make It Harder To Stay Connected<\/strong><\/h2><p>People with hearing loss may find it hard to have conversations with friends and family, which can lead to less interaction with people, social isolation, and higher rates of loneliness. Learn about&nbsp;<a href=\"https:\/\/www.nia.nih.gov\/health\/loneliness-and-social-isolation-tips-staying-connected\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">risk factors for social isolation and loneliness and ways to stay connected<\/a>&nbsp;as you age.<\/p><h2><strong>How to Cope with Hearing Loss<\/strong><\/h2><p>If you notice signs of hearing loss, talk to your doctor. If you have trouble hearing, you should:<\/p><ul><li>Let people know you have a hearing problem.<\/li><li>Ask people to face you and to speak more slowly and clearly. Also, ask them to speak louder without shouting.<\/li><li>Pay attention to what is being said and to facial expressions or gestures.<\/li><li>Let the person talking know if you do not understand what he or she said.<\/li><li>Ask the person speaking to reword a sentence and try again.<\/li><li>Find a good location to listen. Place yourself between the speaker and sources of noise and look for quieter places to talk.<\/li><\/ul><p>The most important thing you can do if you think you have a hearing problem is to seek professional advice. Your family doctor may be able to diagnose and treat your hearing problem. Or, your doctor may refer you to other experts, like an&nbsp;<a href=\"https:\/\/www.nidcd.nih.gov\/health\/who-can-i-turn-help-my-hearing-loss\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(63, 87, 166);\">otolaryngologist<\/a>&nbsp;(ear, nose, and throat doctor) or an audiologist (health professional who can identify and measure hearing loss).<\/p>",
    "date" : "2022-12-27T10:19:38.603Z",
    "upvote" : 3,
    "downvote" : 0,
    "author_id" : 129,
    "category_id" : null
},
{
    "id" : 39,
    "title" : "Colonoscopy completion and complication rates",
    "body" : "Background\nIn the United States, colonoscopy completion and complication rates are rarely reported outside academic institutions. Increased transparency of quality measures and outcomes is being driven by professional societies, government agencies, and private enterprise.\n\nObjective\nTo collect and report the completion and complication rates of colonoscopy in a community gastroenterology practice.\n\nDesign\nSingle-center study, prospective for completion, retrospective for complications.\n\nSetting\nCommunity gastroenterology group practice, conducted from August 2002 through December 2004.\n\nPatients\nA total of 12,407 consecutive patients referred for colonoscopy; mean age, 59.7 years; 5925 men.\n\nInterventions\nPolypectomy and cautery were completed as indicated.\n\nMain Outcome Measures\nCompletion of colonoscopy to cecum or ileocolonic anastomosis. Complications of hemorrhage and perforation.\n\nResults\nA colonoscopy was completed in 98.4% of patients. Polypectomy was accomplished in 5074 (40.9%). Polyps occurred more often in men (46.4% vs 35.8%, P < .001). Causes for failure included difficult anatomy (55.9%), inadequate preparation (20.8%), obstructing malignancy (8.6%), discomfort (8.1%), and severe inflammation (6.1%). Failure from difficult anatomy was more likely in women (1.19% vs 0.56%, P < .001). Hemorrhage requiring hospitalization occurred after 25 cases (0.20%). Twenty-three episodes of bleeding occurred after polypectomy (0.46%) and 2 after treatment of arteriovenous malformations. Two perforations occurred (0.016%). One patient developed a posterior circulation stroke. No deaths occurred.\n\nLimitations\nCompletion not independently verifiable. Complications were collected retrospectively.\n\nConclusions\nColonoscopy completion and complication rates in this community gastroenterology practice compared favorably with U.S. academic centers. Endoscopic quality in community practices can meet published outcomes.",
    "date" : "2022-12-27T00:59:41.207Z",
    "upvote" : 5,
    "downvote" : 1,
    "author_id" : 113,
    "category_id" : 14
},
{
    "id" : 27,
    "title" : "Research About HIV",
    "body" : "HIV testing among high-risk Iranian prisoners as increased from 2009 to 2017. Hovewer, HIV testing remains considerably ow, and half f the incrarcerated people with a history of HIV-related igh-risk behaviours had never tested for HIV inside prison. Evidence-based rograms re needed to optimize HIV testing inside nd outside prisons nd identify those at greater isk of HIV.",
    "date" : "2022-12-06T09:27:40.350Z",
    "upvote" : 1,
    "downvote" : 2,
    "author_id" : 74,
    "category_id" : 1
},
{
    "id" : 16,
    "title" : "Heart Diseases at Birth",
    "body" : "An article about heart diseases at birth",
    "date" : "2022-12-04T19:20:31.712Z",
    "upvote" : 1,
    "downvote" : 2,
    "author_id" : 66,
    "category_id" : 2
},
{
    "id" : 32,
    "title" : "Nut Allergy",
    "body" : "A research in the US shows that %80.6 of the high school students with nut allergies have relatives that have nut allergies. We can say that it is genetic.",
    "date" : "2022-12-06T11:55:29.904Z",
    "upvote" : 2,
    "downvote" : 0,
    "author_id" : 74,
    "category_id" : 1
},
{
    "id" : 34,
    "title" : "Ankle does not break too easily",
    "body" : "If you feel like your ankle is broken from an activity, if your ankle does not have a continuous pain for a couple days, most likely it will get better on its own.\n\nEven though this is the case, we still always recommend you to go to a doctor.",
    "date" : "2022-12-09T13:47:03.407Z",
    "upvote" : 3,
    "downvote" : 1,
    "author_id" : 79,
    "category_id" : 1
},
{
    "id" : 38,
    "title" : "The validity of a sore throat score in family practice",
    "body" : "OBJECTIVE: To validate a score based on clinical symptoms and signs for the identification of group A Streptococcus (GAS) infection in general practice patients with score throat. \n\nDESIGN: A single throat swab was used as the gold standard for diagnosing GAS infection. Clinical information was recorded by experienced family physicians on standardized encounter forms. Score criteria were identified by means of logistic regression modelling of data from patients enrolled in the first half of the study. The score was then validated among the remaining patients.\n\nSETTING: University-affiliated family medicine centre in Toronto.\n\nPATIENTS: A total of 521 patients aged 3 to 76 years presenting with a new upper respiratory tract infection from December 1995 to February 1997.\n\nOUTCOME MEASURES: Sensitivity, specificity and likelihood ratios for identification of GAS infection with the score approach compared with throat culture. Proportion of patients prescribed antibiotics, throat culture use, and sensitivity and specificity with usual physician care and with score-based recommendations were compared. \n\nRESULTS: A score was developed ranging in value from 0 to 4. The sensitivity of the score for identifying GAS infection was 83.1%, compared with 69.4% for usual physician care (p = 0.06); the specificity values of the 2 approaches were similar. Among patients aged 3 to 14 years, the sensitivity of the score approach was higher than that of usual physician care (96.9% v. 70.6%) (p < 0.05). The proportion of patients receiving initial antibiotic prescriptions would have been reduced 48% by following score-based recommendations compared with observed physician prescribing (p < 0.001), without any increase in throat culture use.\n\nCONCLUSIONS: An age-appropriate sore throat score identified GAS infection in children and adults with sore throat better than usual care by family physicians, with significant reductions in unnecessary prescribing of antibiotics. A randomized trial comparing the 2 approaches is recommended to determine the ability of the score approach to reduce unnecessary prescribing of antibiotics during routine clinical encounters.",
    "date" : "2022-12-26T22:42:56.011Z",
    "upvote" : 7,
    "downvote" : 0,
    "author_id" : 107,
    "category_id" : 13
},
{
    "id" : 43,
    "title" : "Importance of Vaccines",
    "body" : "<p><strong>1. Vaccines Have Saved Lives for Over 100 Years—But Serious Disease Is Still a Threat<\/strong><\/p><p><br><\/p><p>Vaccines have greatly reduced diseases that once routinely harmed or killed babies, children, and adults. People all over the world—including in the United States—still become seriously ill or even die from diseases that vaccines can help prevent. It is important that you stay up to date on&nbsp;<a href=\"https:\/\/www.cdc.gov\/vaccines\/adults\/rec-vac\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">recommended vaccines<\/a>.<\/p><p>The protection some vaccines provide can fade over time, and you might need additional vaccine doses (boosters) to maintain protection. For example, adults should receive a tetanus booster every 10 years to protect against infection from dirty wounds. Talk to your health care provider about vaccination to see whether you might have missed any vaccines or need a booster.<\/p><p><br><\/p><p><strong>2. Vaccines Are the Best Way to Protect Yourself and Your Loved Ones from Preventable Disease<\/strong><\/p><p><br><\/p><p>Did you know that vaccines are the best way to protect yourself from certain preventable diseases? Vaccines help your body create protective antibodies—proteins that help it fight off infections.<\/p><p>By getting vaccinated, you can protect yourself and also avoid spreading preventable diseases to other people in your community. Some people cannot get certain vaccines because they are too young or too old or they have a weakened immune system or other serious health condition. Those people are less likely to catch a preventable disease when you and others around them are vaccinated against it. Help protect yourself and the people you love by staying up to date on&nbsp;<a href=\"https:\/\/www.cdc.gov\/vaccines\/adults\/rec-vac\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">recommended vaccinations<\/a>.<\/p><p><br><\/p><p><strong>3. Vaccines Can Prevent Serious Illness<\/strong><\/p><p><br><\/p><p>Some vaccine-preventable diseases can have serious complications or even lead to later illnesses. For them, vaccination provides protection not only against the disease itself but also against the dangerous complications or consequences that it can bring. Some examples:<\/p><ul><li><a href=\"https:\/\/www.cdc.gov\/vaccines\/vpd\/flu\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">Seasonal influenza (flu)<\/a>&nbsp;is a respiratory virus that sickens tens of millions of people every year in the United States. The annual flu vaccine&nbsp;helps you avoid infection and reduces your chances of being hospitalized or dying if you do become infected. Flu vaccine also protects you from flu-related pneumonia and flu-related heart attacks or stroke—complications that can affect anyone but are especially dangerous for persons with diabetes or chronic heart or lung conditions.<\/li><li><a href=\"https:\/\/www.cdc.gov\/vaccines\/vpd\/hepb\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">Hepatitis B<\/a>&nbsp;is a serious, potentially deadly infection of the liver caused by the hepatitis B virus (HBV). There is no cure, but vaccination prevents HBV infection as well as the chronic liver damage and cancer that hepatitis B can cause.<\/li><li><a href=\"https:\/\/www.cdc.gov\/vaccines\/vpd\/hpv\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">Human papillomavirus (HPV)<\/a>&nbsp;is a leading cause of cervical cancer and can cause other cancers in both women and men. HPV vaccine keeps you from being infected with the virus or passing it to others, protecting you and them from the immediate effects of the virus as well as from the various cancers it can trigger.<\/li><\/ul><p><br><\/p><p><strong>4. The Vaccines You Receive Are Safe<\/strong><\/p><p><a href=\"https:\/\/www.cdc.gov\/vaccinesafety\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">Vaccine safety<\/a>&nbsp;is a high priority. CDC and other experts carefully review safety data before recommending any vaccine, then continually&nbsp;<a href=\"https:\/\/www.cdc.gov\/vaccinesafety\/ensuringsafety\/monitoring\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">monitor vaccine safety<\/a>&nbsp;after approval.<\/p><p>Vaccines can have side effects, but most people experience only mild side effects—if any—after vaccination. The most common side effects are fever, tiredness, body aches, or redness, swelling, and tenderness where the shot was given. Mild reactions usually go away on their own within a few days. Serious or long-lasting side effects are extremely rare, and vaccine safety is continually monitored.<\/p><p><br><\/p><p><strong>5. Vaccines May Be Required<\/strong><\/p><p>Certain vaccines are required for school, work, travel, and more. Students, military personnel, and residents of rehabilitation or care centers must be vaccinated against diseases that circulate in close quarters. Health care workers and others whose job puts them at risk of catching and spreading preventable diseases need to be vaccinated against them. And, of course, vaccination is required before travel to many places around the world. Because vaccination protects you and those around you, vaccines can be required for everyday activities as well as for extraordinary situations. It is important that you stay up to date on&nbsp;<a href=\"https:\/\/www.cdc.gov\/vaccines\/adults\/rec-vac\/index.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(7, 82, 144);\">recommended vaccinations<\/a>.<\/p>",
    "date" : "2022-12-27T06:38:19.029Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 115,
    "category_id" : null
},
{
    "id" : 45,
    "title" : "What is Glocom?",
    "body" : "<p>Glocom, also known as glaucoma, is a common eye condition that can lead to vision loss if left untreated. It occurs when there is an abnormal increase in the pressure inside the eye, called intraocular pressure. This pressure can damage the optic nerve, which is responsible for transmitting visual information from the eye to the brain.<\/p><p><br><\/p><p>There are two main types of glaucoma: open-angle glaucoma and angle-closure glaucoma. Open-angle glaucoma is the most common type and develops slowly over time, often without symptoms. Angle-closure glaucoma is less common, but it can cause sudden, severe eye pain and vision loss.<\/p><p><br><\/p><p>Risk factors for glaucoma include being over the age of 60, having a family history of glaucoma, being of African or Hispanic descent, and having high intraocular pressure or thin corneas.<\/p><p><br><\/p><p>To diagnose glaucoma, an ophthalmologist will perform a comprehensive eye exam, including measuring the intraocular pressure and evaluating the optic nerve and visual field. If glaucoma is detected, treatment may include medications or surgery to lower the intraocular pressure and protect the optic nerve.<\/p><p>It is important to have regular eye exams to detect glaucoma early, as early treatment can help prevent vision loss. If you are at high risk for glaucoma or have any symptoms, such as blurred vision or eye pain, it is important to see an ophthalmologist as soon as possible.<\/p>",
    "date" : "2022-12-27T08:49:29.877Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 119,
    "category_id" : null
},
{
    "id" : 47,
    "title" : "Benefits of Chai Tea",
    "body" : "<p><span style=\"background-color: rgb(252, 252, 252); color: rgba(39, 39, 39, 0.75);\">Not only does chai tea taste good, but it’s also really good for you! Chai is full of ingredients with beneficial properties, including <\/span><a href=\"https:\/\/artfultea.myshopify.com\/blogs\/wellness\/benefits-of-black-tea\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(252, 252, 252); color: rgba(var(--color-link),var(--alpha-link));\">black tea<\/a><span style=\"background-color: rgb(252, 252, 252); color: rgba(39, 39, 39, 0.75);\">, <\/span><a href=\"https:\/\/artfultea.myshopify.com\/blogs\/wellness\/ginger-tea-benefits\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(252, 252, 252); color: rgba(var(--color-link),var(--alpha-link));\">ginger<\/a><span style=\"background-color: rgb(252, 252, 252); color: rgba(39, 39, 39, 0.75);\">, <\/span><a href=\"https:\/\/artfultea.myshopify.com\/blogs\/wellness\/cinnamon-tea\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(252, 252, 252); color: rgba(var(--color-link),var(--alpha-link));\">cinnamon<\/a><span style=\"background-color: rgb(252, 252, 252); color: rgba(39, 39, 39, 0.75);\">, cloves, cardamom, and more. While the specific spices used in chai tea may vary, these ingredients are some common spices that are typically included in chai blends. <\/span><\/p><p><br><\/p><h2>Benefits of Chai Tea<\/h2><p>Chai tea has a variety of benefits, including improving digestion, reducing inflammation, boosting your immune system, and more.<\/p><h3>1. Rich in antioxidants<\/h3><p>Chai tea is a great source of antioxidants, which work to reduce free radicals in the body and promote cellular health, and can even help prevent degenerative diseases and certain forms of cancer. Like other types of tea made from the <a href=\"https:\/\/artfultea.myshopify.com\/blogs\/tea-wisdom\/camellia-sinensis\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\"><em>camellia sinensis <\/em>tea<em> <\/em>plant<\/a>, black tea is extremely <a href=\"https:\/\/www.ncbi.nlm.nih.gov\/pmc\/articles\/PMC5429329\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">high in antioxidants<\/a>. <a href=\"https:\/\/www.ncbi.nlm.nih.gov\/pmc\/articles\/PMC4003790\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">Cinnamon bark<\/a>, cardamom, and cloves are also high in antioxidants.<\/p><h3>2. Boosts heart health<\/h3><p>Ingredients in chai tea have been shown to help boost heart health. Black tea contains flavonoids, which are a special compound that holds the key to many of black tea’s important health benefits. Flavonoids can help prevent plaque buildup in the body’s arteries, which reduces stress on the heart. Cinnamon has also been shown to help to <a href=\"https:\/\/www.ncbi.nlm.nih.gov\/pmc\/articles\/PMC4003790\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">treat cardiovascular diseases<\/a> and reduce harmful cholesterol.<\/p><h3>3. Improves digestion<\/h3><p>Drinking chai tea can also help to <a href=\"https:\/\/artfultea.myshopify.com\/blogs\/wellness\/9-best-teas-for-digestion\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">improve digestion<\/a> and soothe stomach troubles. Studies show that consuming black tea can have a positive effect on digestion, and can help to prevent gastrointestinal troubles when they arise. Ginger is also a <a href=\"https:\/\/pubmed.ncbi.nlm.nih.gov\/18403946\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">powerful digestive aid<\/a>, and consuming ginger can help to improve gastrointestinal symptoms and help the digestive system to work properly. Cardamom has plenty of digestive benefits as well!<\/p><h3>4. Increases energy and alertness<\/h3><p>Whether you’re looking for a good cup of tea to get you going in the morning, or to give you a boost throughout the day, black tea is an <a href=\"https:\/\/artfultea.myshopify.com\/blogs\/wellness\/best-teas-for-energy\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">energizing tea<\/a> that can help to <a href=\"https:\/\/pubmed.ncbi.nlm.nih.gov\/21172396\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">increase alertness and focus<\/a>. Black teas like chai tea contain a moderate amount of caffeine to give you a welcome boost of energy when you’re feeling lethargic, without any of the jitters or other negative side effects that can come with excess caffeine intake. When combined with the <a href=\"https:\/\/artfultea.myshopify.com\/blogs\/wellness\/2019-7-19-a-calming-cup-tea-and-l-theanine\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgba(var(--color-link),var(--alpha-link));\">l-theanine<\/a> also present in tea, the caffeine in black tea helps to encourage focus and alertness.<\/p>",
    "date" : "2022-12-27T09:05:06.128Z",
    "upvote" : 0,
    "downvote" : 0,
    "author_id" : 115,
    "category_id" : null
},
{
    "id" : 48,
    "title" : "When to see a Psychiatrist",
    "body" : "<h2>Reasons to Consult With a Psychiatrist<\/h2><p>Determining when to see a psychiatrist will often require an honest self-assessment. While you shouldn’t try to self-diagnose any specific mental health conditions, you can certainly become aware of and pinpoint behaviors, emotions, and thought patterns that are unhealthy.&nbsp;<\/p><p>Even recurring, but temporary, episodes of anxiety, stress, depression, or mood swings might be an indication of a larger mental health condition that might warrant professional treatment. We all experience professional setbacks, failed relationships, financial worries, and personal loss at some point in life, but if it’s interfering with your ability to function daily, or it’s becoming an issue in your interpersonal relationships, there may be more going on.&nbsp;<\/p><p>It’s how you cope, how you react, and what you do to get through these life experiences that can define whether or not a psychiatric intervention is a good idea. If you’re trying to figure out when to see a psychiatrist, it can help to look for episodes of mental health symptoms that have:<\/p><ul><li>A sudden onset<\/li><li>A sharp rise in intensity<\/li><li>And\/or a short course<\/li><li>Long standing Anxiety<\/li><li>Pattern of interpersonal conflicts&nbsp;<\/li><li>Avoidance of responsibility<\/li><\/ul><p>Mental health episodes may happen sporadically, but if they’re negatively affecting your quality of life, that’s a clear sign you may be ready to seek help.&nbsp;<\/p><p>Examples of acute mental health conditions that are recurring can include:<\/p><ul><li>Extreme anger&nbsp;<\/li><li>Rage<\/li><li>Debilitating anxiety&nbsp;<\/li><li><a href=\"https:\/\/www.talkspace.com\/mental-health\/conditions\/depression\/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 88, 95);\">Depression<\/a><\/li><li>Eating or sleeping disorders&nbsp;<\/li><li>Periods of intense sadness<\/li><li>Thoughts of self-harm or suicide<\/li><\/ul><p><br><\/p>",
    "date" : "2022-12-27T09:10:23.021Z",
    "upvote" : 1,
    "downvote" : 0,
    "author_id" : 118,
    "category_id" : null
},
{
    "id" : 49,
    "title" : "Shortness of Breath",
    "body" : "If you are experiencing shortness of breath, it could be a sign of a variety of underlying health conditions. Some common causes of shortness of breath include asthma, chronic obstructive pulmonary disease (COPD), pneumonia, and hearth failure. It is important to see a healthcare professional if you are experiencing shortness of breath, as it can be a serious condition. They will be able to determine the cause of your symptoms and reccomend the appropriate treatment. ",
    "date" : "2022-12-27T10:14:58.922Z",
    "upvote" : 3,
    "downvote" : 0,
    "author_id" : 125,
    "category_id" : 39
}
```


</details>
  
  
