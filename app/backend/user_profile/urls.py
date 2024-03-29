from user_profile import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path

urlpatterns = [
    path('upload_profile_picture', views.upload_profile_picture, name='upload_profile_picture'),
    path('set_avatar', views.set_avatar, name='set avatar'),
    path('delete_profile_picture', views.delete_profile_picture, name='delete_profile_picture'),
    path('upvoted_articles', views.get_upvoted_articles, name='get_upvoted_articles'),
    path('upvoted_posts', views.get_upvoted_posts, name='get_upvoted_posts'),
    path('get_personal_info', views.get_personal_info, name='get_personal_info'),
    path('update_personal_info', views.update_personal_info, name='update_personal_info'),
    path('get_doctor_profile/<int:id>', views.get_doctor_profile, name='get_doctor_profile'),
    path('follow_category/<int:id>', views.follow_category, name='follow_category'),
    path('followed_categories', views.get_followed_categories, name='get_followed_categories'),
    path('bookmarked_posts', views.get_bookmarked_posts, name='get_bookmarked_posts'),
    path('bookmarked_articles', views.get_bookmarked_articles, name='get_bookmarked_articles'),
    path('delete_account', views.delete_account, name='delete_account'),
]
