# WebHooks

> To retrieve the `access_token` use this code:

```http
PATCH /affiliate/YOUR_AFFILIATE_NAME HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/json
Host: api_dev.ibercheck.net
Authorization: Bearer YOUR IBERCHECK ACCESS TOKEN

{
  "webhook_url": "URL TO YOUR ENDPOINT"
}
```

```shell
curl "https://api_dev.ibercheck.net/affiliate/YOUR_AFFILIATE_NAME" \
 -H "content-type: application/json" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer YOUR IBERCHECK ACCESS TOKEN" \
 -X PATCH \
 -d '{"webhook_url": "URL TO YOUR ENDPOINT"}'
```

> Make sure to replace `YOUR_AFFILIATE_NAME` and `YOUR IBERCHECK ACCESS TOKEN` with the values obtained after perform
> the Authentication.

```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "name": "YOUR_AFFILIATE_NAME",
  "template": "ibercheck",
  "sso_enabled": false,
  "capitalize_enabled": true,
  "enabled": true,
  "webhook_url": "URL TO YOUR ENDPOINT",
  "webhook_format": "api_v1"
  "_links": {
    "self": {
      "href": "https://api_dev.ibercheck.net/affiliate/YOUR_AFFILIATE_NAME"
    },
    "sale": {
      "href": "https://api_dev.ibercheck.net/sale"
    },
    "product": {
      "href": "https://api_dev.ibercheck.net/product"
    },
    "user": {
      "href": "https://api_dev.ibercheck.net/user"
    }
  }
}
```

```shell
'{
   "name": "YOUR_AFFILIATE_NAME",
   "template": "ibercheck",
   "sso_enabled": false,
   "capitalize_enabled": true,
   "enabled": true,
   "webhook_url": "URL TO YOUR ENDPOINT",
   "webhook_format": "api_v1"
   "_links": {
     "self": {
       "href": "https://api_dev.ibercheck.net/affiliate/YOUR_AFFILIATE_NAME"
     },
     "sale": {
       "href": "https://api_dev.ibercheck.net/sale"
     },
     "product": {
       "href": "https://api_dev.ibercheck.net/product"
     },
     "user": {
       "href": "https://api_dev.ibercheck.net/user"
     }
   }
 }'
```

For to keep your system side up to date this API allows you to subscribe to business events through WebHooks.

WebHooks are composed with the following properties.

* Header `X-Ibercheck-Event` contains the event name.
* Header `X-Ibercheck-Signature` contains the HMAC-256 hex digest of the body using the "affiliate secret" as key.
* Body contains the event payload. Usually match with any of the API GET responses.

The following is a list of events implemented (Signatures has been created with the key `s3cr3t`):

## Report request status changed event

```http
POST /path/to/your/endpoint HTTP/1.1
User-Agent: Ibercheck Webhook
Content-Type: application/json
Host: your.domain
X-Ibercheck-Event: report-request_status_changed
X-Ibercheck-Signature: a67bfec357d1429e7e0616bad8b5dd06b16165c1a9f268518dfbb401d3b508c3

{
  "_links": {
    "self": {
      "href": "https://api_dev.ibercheck.net/report-request/1"
    },
    "authorization ": {
      "href": "https://api_dev.ibercheck.net/report-request/1/authorize"
    },
    "authorization_document": {
      "href": "https://api_dev.ibercheck.net/report-request/1/authorize/document"
    }
  },
  "type": "autocheck",
  "purpose": "Autocheck API tutorial example",
  "status": "pending_authorization",
  "_embedded": {
    "person_consulting": {
      "_links": {
        "self": {
          "href": "https://api_dev.ibercheck.net/user/1"
        }
      },
      "id": "1",
      "name": "John",
      "surnames": "Doe"
    },
    "person_consulted": {
      "_links": {
        "self": {
          "href": "https://api_dev.ibercheck.net/user/1"
        }
      },
      "id": "1",
      "name": "John",
      "surnames": "Doe"
    }
  }
}
```

Name: `report-request_status_changed`

Description: This event is triggered when the `report-request` change his status.

Payload: Same content as the response of `/report-request/<id>`
