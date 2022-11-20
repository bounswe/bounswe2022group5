import boto3
import os
import io


AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')
AWS_STORAGE_BUCKET_NAME = 'group5static'

AWS_BASE_BUCKET_URL = 'https://{bucketName}.s3.amazonaws.com/'.format(
    bucketName = AWS_STORAGE_BUCKET_NAME
)


def upload_to_s3(obj, file_name):

    s3 = boto3.client('s3',
        aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY
    )

    s3.upload_fileobj(
        io.BytesIO(obj), 
        AWS_STORAGE_BUCKET_NAME, 
        file_name
    )

    return AWS_BASE_BUCKET_URL + file_name


def delete_from_s3(file_name):

    boto3.client('s3',
        aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY
    ).delete_object(Bucket=AWS_STORAGE_BUCKET_NAME, Key=file_name)

    return True
