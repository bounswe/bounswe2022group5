from django.test import TestCase, Client
from rest_framework.authtoken.models import Token
from forum import models
from .models import *
from backend import models as backendModels
from tests.constants import *
from datetime import datetime

class Annotation(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def createTestAnnotation(self):
        schema =  {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "body": [
            {
                "created" : "2022-12-17T21:01:59.693Z",
                "creator" : {
                    "id" : "http://3.91.54.225:3000/profile/61",
                    "displayName": "Mehmet Emre Akbulut"
                },
                "modified" : "2022-12-17T21:01:59.693Z",
                "purpose": "commenting",
                "type" : "TextualBody",
                "value" : "Content of The Annotation"
            }
        ],
        "id" : "#id",
        "target" : {
            "selector": [
                {
                    "exact" : "Exact String Selected",
                    "type" : "TextQuoteSelector"

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
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response = client.post(f'/annotation/text/{post.id}?type=POST', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"}, data=schema)
        self.assertEqual(response.status_code, 200)

    def createImageAnnotation(self):
        schema =   {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "body": [
            {
                "created" : "2022-12-17T21:01:59.693Z",
                "creator" : {
                    "id" : "http://3.91.54.225:3000/profile/61",
                    "displayName": "Mehmet Emre Akbulut"
                },
                "modified" : "2022-12-17T21:01:59.693Z",
                "purpose": "commenting",
                "type" : "TextualBody",
                "value" : "Content of The Annotation"
            }
        ],
        "id" : "#b3343k4klRANDOM3434fdfd",
        "target" : {
            "selector": {
                    "conformsTo": "http://www.w3.org/TR/media-frags/",
                    "type": "FragmentSelector",
                    "value" : "xywh=pixel:491.23232,323.23232,436.8787, 123.4343"
                },
            "source" : "URL OF PHOTO"
        },
        "type": "Annotation"
    }
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response = client.post(f'/annotation/image/{post.id}?type=POST', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"}, data=schema)
        self.assertEqual(response.status_code, 200)

    def getAnnotations(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        annotation = TextAnnotation(id="34343", source_id=post.id, source_type = 'POST', author = user )
        response = client.post(f'/annotation/{post.id}?type=POST', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)

    def updateTestAnnotation(self):
        schema =  {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "body": [
            {
                "created" : "2022-12-17T21:01:59.693Z",
                "creator" : {
                    "id" : "http://3.91.54.225:3000/profile/61",
                    "displayName": "Mehmet Emre Akbulut"
                },
                "modified" : "2022-12-17T21:01:59.693Z",
                "purpose": "commenting",
                "type" : "TextualBody",
                "value" : "Content of The Annotation"
            }
        ],
        "id" : "#id",
        "target" : {
            "selector": [
                {
                    "exact" : "Exact String Selected",
                    "type" : "TextQuoteSelector"

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
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response = client.post(f'/annotation/text/{post.id}?type=POST', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"}, data=schema)
        self.assertEqual(response.status_code, 200)

    def updateImageAnnotation(self):
        schema =   {
        "@context" : "http://www.w3.org/ns/anno.jsonld",
        "body": [
            {
                "created" : "2022-12-17T21:01:59.693Z",
                "creator" : {
                    "id" : "http://3.91.54.225:3000/profile/61",
                    "displayName": "Mehmet Emre Akbulut"
                },
                "modified" : "2022-12-17T21:01:59.693Z",
                "purpose": "commenting",
                "type" : "TextualBody",
                "value" : "Content of The Annotation"
            }
        ],
        "id" : "#b3343k4klRANDOM3434fdfd",
        "target" : {
            "selector": {
                    "conformsTo": "http://www.w3.org/TR/media-frags/",
                    "type": "FragmentSelector",
                    "value" : "xywh=pixel:491.23232,323.23232,436.8787, 123.4343"
                },
            "source" : "URL OF PHOTO"
        },
        "type": "Annotation"
    }
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response = client.post(f'/annotation/image/{post.id}?type=POST', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"}, data=schema)
        self.assertEqual(response.status_code, 200)

    def deleteAnnotations(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        annotation = TextAnnotation(id="34343", source_id=post.id, source_type = 'POST', author = user )
        response = client.post(f'/annotation/delete/{post.id}?type=POST', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)

