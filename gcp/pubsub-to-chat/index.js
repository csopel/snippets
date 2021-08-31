/**
 * Google Cloud Function that sends alerts to
 * Google Chat.
 *
 * @param {object} message The Pub/Sub message.
 * @param {object} context The event metadata.
 */

 exports.laceworkAlert = (message, context) => {
  const fetch = require('node-fetch');
  const webhookUrl = process.env.webhookUrl;
  const laceworkUrl = process.env.laceworkUrl;
  const logoUrl = process.env.logoUrl;
  const alert = JSON.parse(Buffer.from(message.data, 'base64').toString())
  let sev = null;
  switch (alert.SEVERITY) {
    case 0:
      sev = "<b>Test Event</b>";
      break;
    case 5:
      sev = "<b>Info</b>";
      break;
    case 4:
      sev = "<b><font color=#0000ff>Low</b></font>";
      break;
    case 3:
      sev = "<b><font color=#ffff00>Medium</b></font>";
      break;
    case 2:
      sev = "<b><font color=#ffa500>HIGH</b></font>";
      break;
    case 1:
      sev = "<b><font color=#FF0000>CRITICAL</b></font>";
      break;
    default:
      sev = "Unknown Severity";
  }
  const data = JSON.stringify(
    {
      "cards": [
        {
          "header": {
            "title": "Lacework Agent",
            "subtitle": laceworkUrl,
            "imageUrl": logoUrl
          },
          "sections": [
            {
              "widgets": [
                {
                    "keyValue": {
                      "topLabel": alert.EVENT_ID,
                      "content": "" + sev + ": " + alert.EVENT_CATEGORY,
                      "bottomLabel": alert.START_TIME
                      }
                },
                {
                  "keyValue": {
                    "topLabel": "Event Name",
                    "content": alert.EVENT_NAME
                    }
                }
              ]
            },
            {
              "header": "Summary",
              "widgets": [
                {
                  "textParagraph": {
                    "text": alert.SUMMARY
                  }
                }
              ]
            },
            {
              "widgets": [
                {
                  "buttons": [
                    {
                      "textButton": {
                        "text": "View in Lacework",
                        "onClick": {
                          "openLink": {
                            "url": alert.LINK
                          }
                        }
                      }
                    }
                  ]
                }
              ]
            }
          ] //end of the sections
        } //end of the card
      ]
    }
  )

  fetch(webhookUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data,
  }).then((response) => {
    console.log(response);
  });
}
