def main (event, context):
	print ("In lambda handler")

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "Subo un medical record"
	}

	return resp