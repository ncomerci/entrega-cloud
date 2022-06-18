import boto3

s3_client = boto3.client("s3")
S3_BUCKET = 'BUCKET_NAME'

def main(event, context):
    object_key = "radiografia-mano.jpg"  # replace object key
    file_content = s3_client.get_object(
        Bucket=S3_BUCKET, Key=object_key)["Body"].read()
    print(file_content)