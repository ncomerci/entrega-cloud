def main (event, context):

	resp = {
		"statusCode": 200,
		"headers": {
			"Access-Control-Allow-Origin": "*",
		},
		"body": "Esto debería traer los appointments"
	}

	return resp