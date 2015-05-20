## Making Requests

``` http
GET /users HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Authorization: Bearer YOUR IBERCHECK ACCESS TOKEN
Host: api_dev.ibercheck.net
```

```shell
curl "https://api_dev.ibercheck.net/users" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer YOUR IBERCHECK ACCESS TOKEN"
```

> Make sure to replace `YOUR IBERCHECK ACCESS TOKEN` with the `access_token` obtained in [Authentication](#authentication).

<aside class="warning">
  If you do not set the **Accept** header, you might retrieve old API formats.
</aside>

When you write your own Travis CI client, please keep the following in mind:

* Always set the **User-Agent** header. This header is not required right now, but will be in the near future.
  Assuming your client is called "My Client", and it's current version is 1.0.0, a good value would be `MyClient/1.0.0`.
* Always set the **Accept** header to `application/vnd.ibercheck.v1+json`.
* You must replace `YOUR IBERCHECK ACCESS TOKEN` with the `access_token` obtained in [Authentication](#authentication). 

Any existing client library should take care of these for you.
