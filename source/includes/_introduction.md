# Introduction

``` http
GET /users HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Authorization: Bearer YOUR IBERCHECK ACCESS TOKEN
Host: api.ibercheck.com
```

```shell
curl "https://api.ibercheck.com/users" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer YOUR IBERCHECK ACCESS TOKEN"
```

``` http
GET /users HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Authorization: Bearer YOUR IBERCHECK ACCESS TOKEN
Host: api-dev.ibercheck.net
```

```shell
curl "https://api-dev.ibercheck.net/users" \
 -H "accept: application/vnd.ibercheck.v1+json" \
 -H "authorization: Bearer YOUR IBERCHECK ACCESS TOKEN"
```

Welcome to the Ibercheck API documentation. The Ibercheck API is organized around
[REST](http://en.wikipedia.org/wiki/Representational_State_Transfer) and
[Hypermedia](#hypermedia).
Our API is designed to have predictable, resource-oriented URLs and to use HTTP response codes to indicate API errors.
We use built-in HTTP features, like HTTP authentication and HTTP verbs, which can be understood by off-the-shelf HTTP
clients, and we support cross-origin resource sharing to allow you to interact securely with our API from a client-side
web application
(though you should remember that you should never expose your API credentials in any public website's client-side code).
JSON will be returned in all responses from the API, including errors.

The first thing you will have to find out is the correct API endpoint to use.

* For production environments, use **[https://api.ibercheck.com](https://api.ibercheck.com)**.
* For development/testing/staging environments, use **[https://api-dev.ibercheck.net](https://api-dev.ibercheck.net)**.

Note that all API calls to be [authenticated](#authentication).
