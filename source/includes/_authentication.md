## Authentication

### Affiliate authentication

> To retrieve the `access_token` use this code:

```http
POST /oauth HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Content-Type: application/json
Host: api_dev.ibercheck.net

{
  "grant_type": "client_credentials",
  "client_id": "YOUR AFFILIATE NAME",
  "client_secret": "YOUR AFFILIATE SECRET"
}
```

```shell
curl "https://api_dev.ibercheck.net/oauth" \
 -H "content-type: application/json" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -X POST \
 -d '{"grant_type": "client_credentials","client_id": "YOUR AFFILIATE NAME","client_secret": "YOUR AFFILIATE SECRET"}'
```

> Make sure to replace `YOUR AFFILIATE NAME` and `YOUR AFFILIATE SECRET` with your `affiliate name` and
 `affiliate secret` present in the welcome pack sent to you.

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

You authenticate to the Ibercheck API by exchanging your *Affiliate secret key* with an *OAuth2* `access_token`.
You can manage your *Affiliate secret key* from your account. Your *Affiliate secret key* carry many privileges,
so be sure to keep them secret!

All API requests must be made over HTTPS. Calls made over plain HTTP will fail. You must authenticate for all requests.

### User authentication

For to do operations related with an user (i.e. make a new report request, update profile) the affiliate must operate
on behalf the user.

The way of Ibercheck API allow to impersonate a given user is through an access_token present in the user resource when
the user is created or when is retrieved from the API.
