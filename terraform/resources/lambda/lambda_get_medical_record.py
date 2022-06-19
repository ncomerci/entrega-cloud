import boto3

def main(event, context):
    s3 = boto3.resource('s3')

    my_bucket = s3.Bucket('testeuge-mhs-medical-records-itba-cp-g1')

    for my_bucket_object in my_bucket.objects.all():
        print(my_bucket_object.key)

    return {
        'statusCode': 200,
        'headers': { 
            'Access-Control-Allow-Origin': "*", 
        }
    }