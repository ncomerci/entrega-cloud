import boto3

def main (event, context):
 
	s3 = boto3.resource('s3')

	bucket = s3.Bucket('mhs-medical-records-itba-cp-g1') #TODO deshardcodear bucket name
	objects = []
	for object in bucket.objects.all():
		objects.append(object.key)

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": f"Medical records: {objects}"
	}

	return resp