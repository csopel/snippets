const https = require('https');
const chatHost = process.env.chatHost;
const chatPath = process.env.chatPath;
const laceworkUrl = process.env.laceworkUrl;
const logoUrl = process.env.logoUrl;

const options = {
  hostname: chatHost,
  path: chatPath,
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  }
};

const post = (payload) => new Promise((resolve, reject) => {

  const req = https.request(options, res => {
    let buffer="";
    res.on('data', chunk => buffer += chunk);
    res.on('end', () => resolve());
  });
  req.on('error', e => reject(e.message));
  req.write(payload);
  req.end();

});

exports.handler = async (event, context) => new Promise( async (resolve, reject) => {
  const alert = event.detail;
  let sev = null;
  switch (parseInt(alert.SEVERITY,10)) {
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
  console.log(sev);
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
                      "topLabel": alert.EVENT_ID + " - " + alert.EVENT_CATEGORY,
                      "content": "" + sev + ": " + alert.EVENT_NAME,
                      "bottomLabel": alert.START_TIME
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
  );

  await post(data);

});
