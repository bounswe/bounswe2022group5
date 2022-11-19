from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from common.views import upload_to_s3

from backend.constants import UserType


PROFILE_PICTURE_FILE_NAME = "pp/{user_id}.jpg"

# Create your views here.
@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def upload_profile_picture(request):

    user = request.user
    if user.type != UserType.DOCTOR:
        return Response('Only doctors can upload a profile picture', status=403)

    file_name = PROFILE_PICTURE_FILE_NAME.format(str(user.id))
    
    img = request.data['img'].read()

    pp_url = upload_to_s3(img, file_name)

    user.profile_picture = pp_url
    user.save()

    return Response({'profile_picture_url': pp_url}, status=200)

# TODO: Add delete
