# Pub/Sub to Chat

This example code takes a Pub/Sub message from Lacework and send it to a Google Chat webhook for notifications of Lacework events.  This requires you to set up an incoming webhook in the appropriate Chat Room for the bot to communicate through.

Manual steps to create:
1. Create a [Pub/Sub Alert Channel](https://support.lacework.com/hc/en-us/articles/360047496514-Google-Cloud-Pub-Sub) in Lacework
  * Ensure that the service account being used has the `Pub/Sub Publisher` role on the topic selected
2. Create an [Alert Rule](https://support.lacework.com/hc/en-us/articles/360042236733-Alert-Rules) to route the desired alerts to the Alert Channel from the previous step 
3. If necessary, create a Google Chat room in your Chat environment, or select an existing room for the notifications to be sent to 
4. Create an [incoming webhook](https://developers.google.com/chat/how-tos/webhooks) in the Google Chat room and copy the URL for use in a later step
5. Create a [Cloud Function](https://cloud.google.com/functions/docs/tutorials/pubsub) in Google Cloud that uses the topic from Step 1 as the trigger, using the index.js file from this repo
  * You'll need to create three environment variables in the Cloud Function:
    * `webhookUrl` is the URL for the Google Chat webhook from earlier in the steps
    * `laceworkUrl` is the URL of your Lacework instance - this is purely aesthetic
    * `logoUrl` is the URL of the logo you wish to have the bot display in the alerts
