import boto3

def main(event, context):
    

    return {
        'statusCode': 200,
        'headers': { 
            'Access-Control-Allow-Origin': "*", 
        }
    }