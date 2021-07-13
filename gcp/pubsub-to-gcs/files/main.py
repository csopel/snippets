import base64
import os
import json
from google.cloud import storage

def main(event, context):
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(os.environ.get('bucket_name'))
    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    pubsub_json = json.loads(pubsub_message)
    blob = bucket.blob(os.environ.get('lw_instance') + '-' + pubsub_json['EVENT_ID'] + '.json')    
    blob.upload_from_string(pubsub_message)
    