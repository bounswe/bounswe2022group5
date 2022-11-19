from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from common.views import upload_to_s3


PROFILE_PICTURE_KEY_PREFIX = "pp_"


# Create your views here.
@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def upload_profile_picture(request):

    img = request.data['img'].read()

    user = request.user
    file_name = PROFILE_PICTURE_KEY_PREFIX + str(user.id) + ".jpg"

    pp_url = upload_to_s3(img, file_name)

    user.profile_picture = pp_url
    user.save()

    return Response({'profile_picture_url': pp_url}, status=200)
