import boto3

def main (event, context):
 
	s3 = boto3.resource('s3')

	bucket = s3.Bucket('testeuge-mhs-medical-records-itba-cp-g1')
	objects = []
	for object in bucket.objects.all():
		objects.append(object.key)

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "Esto deberia pegarle a S3 y agarrar todos los medical records"
	}

	return resp