# Pub/Sub to GCS

This example code takes a Pub/Sub message and sends it to GCS for long-term storage of Lacework events.  The terraform scripts provided will automate these steps for you, but will require a service account credential file in JSON format that the integration should use.  Creation of this account/credential could/should be automated in a future update

Manual steps to create:
1. Create a [Pub/Sub Alert Channel](https://support.lacework.com/hc/en-us/articles/360047496514-Google-Cloud-Pub-Sub) in Lacework
  * Ensure that the service account being used has both the `Pub/Sub Publisher` and `Pub/Sub Subscriber` roles on the topic created
2. If necessary, create a Google Cloud Storage bucket that will be the used to store the event logs; otherwise, get the name of an existing bucket to use
  * Grant the service account being used for the integration `Storage Object Creator` privileges on the bucket
3. Create a [Cloud Function] (https://cloud.google.com/functions/docs/tutorials/pubsub) in Google Cloud that uses the topic from Step 1 as the trigger, using the python code and requirements.txt from this repo
  * You'll need to create two environment variables in the Cloud Function
    * `lw_instance` is the name of your Lacework instance, and will be used as the prefix of the file names
    * `bucket_name` is the name of the bucket (without `gs://`) that the log files should be written to (from Step 2)
