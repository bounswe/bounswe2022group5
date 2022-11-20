from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from common.views import upload_to_s3, delete_from_s3

from backend.constants import UserType

from backend.models import Doctor

PROFILE_PICTURE_FILE_NAME = "pp/{user_id}.jpg"

# Create your views here.
@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def upload_profile_picture(request):

    user = request.user
    if int(user.type) != UserType.DOCTOR.value:
        return Response('Only doctors can upload a profile picture', status=403)

    file_name = PROFILE_PICTURE_FILE_NAME.format(user_id=str(user.id))
    
    img = request.data['img'].read()

    pp_url = upload_to_s3(img, file_name)

    doctor_obj = Doctor.objects.get(user=user)
    doctor_obj.profile_picture = file_name

    doctor_obj.save()

    return Response({'profile_picture_url': pp_url}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def delete_profile_picture(request):
    
    user = request.user
    if int(user.type) != UserType.DOCTOR.value:
        return Response('Only doctors can upload / delete profile pictures', status=403)
    
    doctor_obj = Doctor.objects.get(user=user)
    file_name = doctor_obj.profile_picture

    delete_from_s3(file_name=file_name)

    doctor_obj.profile_picture=None
    doctor_obj.save()

    return Response('Profile picture successfully deleted.', status=200)

