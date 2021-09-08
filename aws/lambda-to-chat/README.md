# Lambda to Chat

This example code takes a Webhook from Lacework and send it to a Google Chat webhook for notifications of Lacework events.  This requires you to set up an incoming webhook in the appropriate Chat Room for the bot to communicate through, as well as an API Gateway to receive the Lacework Webhook and send it to Lambda.

Data flow is Lacework -> API Gateway -> Lambda -> Google Chat

In the future, this repository will also include a version to take a [CloudWatch event](https://support.lacework.com/hc/en-us/articles/360005840174-AWS-CloudWatch) and send it to Google Chat

Manual steps to create:
1. Create an [API Gateway to proxy for Lambda](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html) similar to the demo steps on AWS website
2. Create a [Webhook Alert Channel](https://support.lacework.com/hc/en-us/articles/360034367393-Webhook) and point it to the API Gateway Stage endpoing
3. Create an [Alert Rule](https://support.lacework.com/hc/en-us/articles/360042236733-Alert-Rules) to route the desired alerts to the Alert Channel from the previous step 
4. If necessary, create a Google Chat room in your Chat environment, or select an existing room for the notifications to be sent to 
5. Create an [incoming webhook](https://developers.google.com/chat/how-tos/webhooks) in the Google Chat room and copy the URL for use in a later step
6. Update the Lambda in AWS from Step 1, using the index.js file from this repo 
  * You'll need to create three environment variables in the Lambda:
    * `chatHost` is the hostname for the Google Chat webhook from earlier in the steps (usually `chat.google.com`)
    * `chatPath` is the remaining path (including the leading `/`) from the Google Chat webhook, including the `key` and `token` attributes
    * `laceworkUrl` is the URL of your Lacework instance - this is purely aesthetic
    * `logoUrl` is the URL of the logo you wish to have the bot display in the alerts
