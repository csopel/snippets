# Lambda to Chat

This example code takes a CloudWatch Alert Channel from Lacework and sends it to a Google Chat webhook for notifications of Lacework events via a Lambda.  This requires you to set up an incoming webhook in the appropriate Chat Room for the bot to communicate through.

Data flow is Lacework -> CloudWatch -> Lambda -> Google Chat

Manual steps to create:
1. Create an [incoming webhook](https://developers.google.com/chat/how-tos/webhooks) in the Google Chat room and copy the URL for use in a later step
2. Create a Lambda using the index.js file in this repository
  * You'll need to create four environment variables in the Lambda:
    * `chatHost` is the hostname for the Google Chat webhook from earlier in the steps (usually `chat.googleapis.com`)
    * `chatPath` is the remaining path (including the leading `/`) from the Google Chat webhook, including the `key` and `token` attributes
    * `laceworkUrl` is the URL of your Lacework instance - this is purely aesthetic
    * `logoUrl` is the URL of the logo you wish to have the bot display in the alerts
3. Create an [EventBridge Event Bus](https://support.lacework.com/hc/en-us/articles/360034367393-Webhook) (f.k.a. CloudWatch Events) following the steps in the instructions to create the cross-account permissions necessary to send the alerts; **HOWEVER** use the Lambda from Step 2 as the target as opposed to a SQS Queue
4. Create an [Alert Rule](https://support.lacework.com/hc/en-us/articles/360042236733-Alert-Rules) to route the desired alerts to the Alert Channel from the previous step 
5. Test the integration to ensure that alerts are coming through as expected
