## Versioning

> v1 request

``` http
GET /users HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v1+json
Host: api-dev.ibercheck.net
```

```shell
curl "https://api-dev.ibercheck.net/users" \
 -H "accept: application/vnd.ibercheck.v1+json"
```

> v2 request

``` http
GET /users HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/vnd.ibercheck.v2+json
Host: api-dev.ibercheck.net
```

```shell
curl "https://api-dev.ibercheck.net/users" \
 -H "accept: application/vnd.ibercheck.v2+json"
```


When we make backwards-incompatible changes to the API, we release new versions. The current version is `v1`.
Read our API upgrades guide to see our API changelog and to learn more about backwards compatibility.

API versions are released with changes in the negotiated media type.
So version 1 is `application/vnd.ibercheck.v1+json` and version 2 will be `application/vnd.ibercheck.v2+json`
