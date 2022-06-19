import boto3
def main (event, context):
	s3 = boto3.resource('s3')
	 
	txt_data = b'This is the content of the file uploaded from python boto3 asdfasdf'

	object = s3.Object('<bucket_name>', 'file_name.txt')

	result = object.put(Body=txt_data)
	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "Subo un medical record"
	}

	return resp