def main (event, context):
	print ("In lambda handler")

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "Esto deberia pegarle a S3 y agarrar todos los medical records"
	}

	return resp