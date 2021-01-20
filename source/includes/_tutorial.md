# Tutorial
Reports are asynchronous transactions. This means it's necessary to register a request. After registering your
request you will be posted about the progress via WebHooks.

## Authentication

```http
POST /oauth HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/json
Host: api-dev.ibercheck.net

{
  "grant_type": "client_credentials",
  "client_id": "YOUR AFFILIATE NAME",
  "client_secret": "YOUR AFFILIATE SECRET"
}
```

```shell
curl "https://api-dev.ibercheck.net/oauth" \
 -H "content-type: application/json" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -X POST \
 -d '{"grant_type": "client_credentials","client_id": "YOUR AFFILIATE NAME","client_secret": "YOUR AFFILIATE SECRET"}'
```

> Make sure to replace `YOUR AFFILIATE NAME` and `YOUR AFFILIATE SECRET` with your `affiliate name` and
 `affiliate secret` present in the welcome pack sent to you.

Exchange your *Affiliate secret key* with an *OAuth2* `access_token`.

### Request

Attribute           | Description
-----------         | -----------
grant_type          | `OAuth2` grant type. Always `client_credentials`.
client_id           | Your `affiliate name`
client_secret       | Your `affiliate secret key`
scope               | *Optional* OAuth2 scopes by default `ROLE_AFFILIATE create:user read:email`

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "access_token":"YOUR IBERCHECK ACCESS TOKEN",
  "expires_in":3600,
  "token_type":"bearer",
  "scope":"ROLE_AFFILIATE create:user read:email"
}
```

```shell
'{
  "access_token":"YOUR IBERCHECK ACCESS TOKEN",
  "expires_in":3600,
  "token_type":"bearer",
  "scope":"ROLE_AFFILIATE create:user read:email"
}'
```

### Response

Attribute    | Description
-----------  | -----------
access_token | *OAuth2* `access_token`. This value must be present in every authenticated API call.
expires_in   | Number of milliseconds before the token become invalid.
token_type   | *OAuth2* `token type`. Always wil be `bearer`.
scope        | OAuth2 scopes granted by default `ROLE_AFFILIATE create:user read:email`. May differ from the scopes requested.

## Register a new user

```http
POST /user HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/json
Host: api-dev.ibercheck.net
Authorization: Bearer YOUR IBERCHECK ACCESS TOKEN

{
  "name": "John",
  "surnames": "Doe",
  "email": "john_doe@example.com",
  "mobile_phone": 666777888,
  "national_id": "12345678Z"
}
```

```shell
curl "https://api-dev.ibercheck.net/user" \
 -H "content-type: application/json" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer YOUR IBERCHECK ACCESS TOKEN" \
 -X POST \
 -d '{"name": "John","surnames": "Doe","email": "john_doe@example.com","mobile_phone": 666777888,"national_id": "12345678Z"}'
```

Almost everything created in the API is related with an user in some way. So this step guides you about how to register
a new user in the API.

### Request

Attribute     | Description
-----------   | -----------
name          | User first name.
surnames      | User last name, surnames or family name.
email         | User email address.
mobile_phone  | *Optional* User mobile phone (only spanish number)
national_id   | *Optional* User Spanish ID (NIF or NIE)

```http
HTTP/1.1 201 Created
Content-Type: application/vnd.ibercheck.v1+json

{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/user/1"
    },
    "sale": {
      "href": "https://api-dev.ibercheck.net/user/1/sale"
    }
  },
  "name": "John",
  "surnames": "Doe",
  "email": "john_doe@example.com",
  "mobile_phone": 666777888,
  "national_id": "12345678Z",
  "access_token": {
    "access_token": "USER ACCESS TOKEN"
  }
}
```

```shell
'{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/user/1"
    },
    "sale": {
      "href": "https://api-dev.ibercheck.net/user/1/sale"
    }
  },
  "name": "John",
  "surnames": "Doe",
  "email": "john_doe@example.com",
  "mobile_phone": 666777888,
  "national_id": "12345678Z",
  "access_token": {
    "access_token": "USER ACCESS TOKEN"
  }
}'
```

### Response

Attribute      | Description
-----------    | -----------
\_links.self   | Reference to the user created.
\_links.sales  | Link for create and read user sales.
name           | User first name.
surnames       | User last name, surnames or family name.
email          | User email address.
mobile_phone   | *Optional* User mobile phone (only spanish number)
national_id    | *Optional* User Spanish ID (NIF or NIE)
access_token   | *OAuth2* attributes for use the API on behalf the user.

## Register a new sale

> URI must be the same as the link named `Sales` (_links.sales) present in the user resource.

```http
POST /user/1/sale HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/json
Host: api-dev.ibercheck.net
Authorization: Bearer USER ACCESS TOKEN

{
  "orderNumber": "ABCD1234",
  "product": "autocheck",
  "hash": "ABCDEFGHIJKLMNOPQRSTUWXYZ1234567890"
}
```

```shell
curl "https://api-dev.ibercheck.net/user/1/sale" \
 -H "content-type: application/json" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer USER ACCESS TOKEN" \
 -X POST \
 -d '{"orderNumber": "ABCD1234","product": "autocheck","hash": "ABCDEFGHIJKLMNOPQRSTUWXYZ1234567890"}'
```

For to register a new sale we need first a [registered user](#register-a-new-user).

### Request

Attribute     | Description
-----------   | -----------
orderNumber   | Custom unique identification number.
product       | Product mnemonic.
hash          | Security function for sign the transaction.

```http
HTTP/1.1 201 Created
Content-Type: application/vnd.ibercheck.v1+json

{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/sale/1"
    },
    "report-request": {
      "href": "https://api-dev.ibercheck.net/sale/1/report-request"
    }
  },
  "orderNumber": "ABCD1234",
  "_embedded": {
    "buyer": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/user/1"
        },
        "sale": {
          "href": "https://api-dev.ibercheck.net/user/1/sale"
        }
      },
      "name": "John",
      "surnames": "Doe",
      "email": "john_doe@example.com",
      "mobile_phone": 666777888,
      "national_id": "12345678Z",
      "access_token": {
        "access_token": "string"
      }
    },
    "product": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/product/1"
        },
      },
      "mnemonic": "autocheck"
    }
  }
}
```

```shell
'{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/sale/1"
    },
    "report-request": {
      "href": "https://api-dev.ibercheck.net/sale/1/report-request"
    }
  },
  "orderNumber": "ABCD1234",
  "_embedded": {
    "buyer": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/user/1"
        },
        "sale": {
          "href": "https://api-dev.ibercheck.net/user/1/sale"
        }
      },
      "name": "John",
      "surnames": "Doe",
      "email": "john_doe@example.com",
      "mobile_phone": 666777888,
      "national_id": "12345678Z",
      "access_token": {
        "access_token": "string"
      }
    },
    "product": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/product/1"
        },
      },
      "mnemonic": "autocheck"
    }
  }
}'
```

### Response

Attribute              | Description
-----------            | -----------
\_links.self           | Reference to the sale created.
\_links.report-request | Link for create a new report request.
orderNumber            | Custom order number used when the sale was created.
\_embedded.buyer       | embedded user resource proprietary of the sale.
\_embedded.product     | embedded product resource.

## Register a new report request

> URI must be the same as the link named `report-request` (_links.report-request) present in the sale resource.

```http
POST /sale/1/report-request HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/json
Host: api-dev.ibercheck.net
Authorization: Bearer USER ACCESS TOKEN

{
  "type": "autocheck",
  "purpose": "Autocheck API tutorial example"
}
```

```shell
curl "https://api-dev.ibercheck.net/sale/1/report-request" \
 -H "content-type: application/json" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer USER ACCESS TOKEN" \
 -X POST \
 -d '{"type": "autocheck","purpose": "Autocheck API tutorial example"}'
```

For to register a new report request we need first a [sale](#register-a-new-sale).

### Request

Attribute    | Description
-----------  | -----------
type         | Report type. Can be `autocheck` or `check_a_tercero`.
purpose      | Purpose of the report.
pcd_name     | *Optional* Person consulted name. Only when report type is `check_a_tercero`.
pcd_surnames | *Optional* Person consulted surnames. Only when report type is `check_a_tercero`.
pcd_email    | *Optional* Person consulted email address. Only when report type is `check_a_tercero`.

```http
HTTP/1.1 201 Created
Content-Type: application/vnd.ibercheck.v1+json

{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/report-request/1"
    },
    "authorization ": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize"
    },
    "authorization_document": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize/document"
    }
  },
  "type": "autocheck",
  "purpose": "Autocheck API tutorial example",
  "status": "pending_authorization",
  "_embedded": {
    "person_consulting": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/user/1"
        }
      },
      "id": "1",
      "name": "John",
      "surnames": "Doe"
    },
    "person_consulted": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/user/1"
        }
      },
      "id": "1",
      "name": "John",
      "surnames": "Doe"
    }
  }
}
```

```shell
'{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/report-request/1"
    },
    "authorization ": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize"
    },
    "authorization_document": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize/document"
    }
  },
  "type": "autocheck",
  "purpose": "Autocheck API tutorial example",
  "status": "pending_authorization",
  "_embedded": {
    "person_consulting": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/user/1"
        }
      },
      "id": "1",
      "name": "John",
      "surnames": "Doe"
    },
    "person_consulted": {
      "_links": {
        "self": {
          "href": "https://api-dev.ibercheck.net/user/1"
        }
      },
      "id": "1",
      "name": "John",
      "surnames": "Doe"
    }
  }
}'
```

### Response

Attribute                      | Description
-----------                    | -----------
\_links.self                   | Reference to the sale created.
\_links.authorization          | Finish authentication process.
\_links.authorization_document | Upload person consulted authentication document files.
type                           | Report type. Can be `autocheck` or `check_a_tercero`.
purpose                        | Purpose of the report.
\_embedded.person_consulting   | embedded user resource for the user requesting the report.
\_embedded.person_consulted    | embedded user resource for the person consulted.

## Upload a document to the report request

> URI must be the same as the link named `authorization_document` (_links.authorization_document) present in the
 report request resource.

```
POST /report-request/1/authorize/document HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: multipart/form-data
Host: api-dev.ibercheck.net
Authorization: Bearer USER ACCESS TOKEN

<file upload>
```

For to upload a document we need first a [report request](#register-a-new-report-request).

### Request

Attribute    | Description
-----------  | -----------
file         | File to upload.

```http
HTTP/1.1 201 Created
Content-Type: application/vnd.ibercheck.v1+json

{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/report-request/1"
    },
    "authorization ": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize"
    },
    "authorization_document": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize/document"
    }
  },
  "type": "autocheck",
  "purpose": "Autocheck API tutorial example",
  "status": "pending_authorization",
  "_embedded": {
    "person_consulting": {
    },
    "person_consulted": {
    }
  }
}
```

### Response

Attribute                      | Description
-----------                    | -----------
\_links.self                   | Reference to the sale created.
\_links.authorization          | Finish authentication process.
\_links.authorization_document | Upload person consulted authentication document files.
type                           | Report type. Can be `autocheck` or `check_a_tercero`.
purpose                        | Purpose of the report.
\_embedded.person_consulting   | embedded user resource for the user requesting the report.
\_embedded.person_consulted    | embedded user resource for the person consulted.

## Complete report request authentication

> URI must be the same as the link named `authorization` (_links.authorization) present in the
 report request resource.

```http
POST /report-request/1/authorize HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/vnd.ibercheck.v1+json
Host: api-dev.ibercheck.net
Authorization: Bearer USER ACCESS TOKEN

<body is empty>
```

For mark a report request as authenticated we need first upload [user documents](#upload-a-document-to-the-report-request).

### Request

* Request body is empty

```http
HTTP/1.1 201 Created
Content-Type: application/vnd.ibercheck.v1+json

{
  "_links": {
    "self": {
      "href": "https://api-dev.ibercheck.net/report-request/1"
    },
    "authorization ": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize"
    },
    "authorization_document": {
      "href": "https://api-dev.ibercheck.net/report-request/1/authorize/document"
    }
  },
  "type": "autocheck",
  "purpose": "Autocheck API tutorial example",
  "status": "pending_authorization",
  "_embedded": {
    "person_consulting": {
    },
    "person_consulted": {
    }
  }
}
```

### Response

Attribute                      | Description
-----------                    | -----------
\_links.self                   | Reference to the sale created.
\_links.authorization          | Finish authentication process.
\_links.authorization_document | Upload person consulted authentication document files.
type                           | Report type. Can be `autocheck` or `check_a_tercero`.
purpose                        | Purpose of the report.
\_embedded.person_consulting   | embedded user resource for the user requesting the report.
\_embedded.person_consulted    | embedded user resource for the person consulted.
