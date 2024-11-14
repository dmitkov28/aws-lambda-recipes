import json
from typing import Dict, Any

def process_message(message: Dict[str, Any]) -> None:
    """
    Process a single SQS message. Implement your business logic here.
    """
    if 'body' in message:
        try:
            body = json.loads(message['body'])
            print(f"Processing message: {body}")
            
        except json.JSONDecodeError:
            print(f"Message body is not JSON: {message['body']}")
            
    message_attributes = message.get('messageAttributes', {})
    if message_attributes:
        print(f"Message attributes: {message_attributes}")

def lambda_handler(event, context):
    """
    Lambda handler for processing SQS messages.
    The event will contain a list of records (messages) from SQS.
    """
    failed_messages = []
    
    for record in event['Records']:
        try:
            process_message(record)
        except Exception as e:
            print(f"Error processing message: {str(e)}")
            failed_messages.append({
                'messageId': record['messageId'],
                'error': str(e)
            })
            continue
    
    if failed_messages:
        print(f"Failed to process {len(failed_messages)} messages: {failed_messages}")
        
    return {
        'statusCode': 200,
        'body': json.dumps({
            'messagesProcessed': len(event['Records']),
            'messagesFailed': len(failed_messages)
        })
    }