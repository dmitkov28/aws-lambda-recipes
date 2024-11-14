import json
import os
import boto3
from botocore.exceptions import ClientError
import random

sqs = boto3.client('sqs')

def lambda_handler(event, context):
    queue_url = os.environ.get("QUEUE_URL")
    
    if not queue_url:
        raise ValueError("QUEUE_URL environment variable is not set")
    
    try:

        response = sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=json.dumps({"random_number": random.randint(1,100)}),
            MessageAttributes={
                'MessageType': {
                    'DataType': 'String',
                    'StringValue': 'Example'
                }
            }
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'messageId': response['MessageId'],
                'message': 'Message sent successfully'
            })
        }
        
    except ClientError as e:
        print(f"Error sending message to SQS: {str(e)}")
        raise