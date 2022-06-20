import boto3
def main (event, context):
	s3 = boto3.resource('s3')
	 
	txt_data = b'Este archivo lo subio una lambda al bucket loco! :D'

	object = s3.Object('mhs-medical-records-itba-cp-g1', 'file_name.txt') # TODO deshardcodear bucket name

	result = object.put(Body=txt_data)
	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "Subo un medical record"
	}

	return resp