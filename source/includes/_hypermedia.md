## Hypermedia

The Ibercheck API is organized around
[REST](http://en.wikipedia.org/wiki/Representational_State_Transfer) and
[HATEOAS](http://en.wikipedia.org/wiki/HATEOAS). Almost every resource representation will contain a `_links` section
with links to operations with the resource itself.

Ibercheck API follows the [Hypertext Application Language](https://tools.ietf.org/html/draft-kelly-json-hal-06) model
for hypermedia representation.

```json
{
  "_links": {
    "self": {
      "href": "https://api_dev.ibercheck.net/user"
    }
  },
  "total_items": 1,
  "_embedded": {
    "users": [
      {
        "_links": {
          "self": {
            "href": "https://api_dev.ibercheck.net/user/1"
          },
          "sale": {
            "href": "https://api_dev.ibercheck.net/user/1/sale"
          }
        },
        "id": "1",
        "name": "John",
        "surnames": "Doe"
      }
    ]
  }   
}
```

Attribute           | Description
-----------         | -----------
_links              | Collection of links related and available to the resource itself.
_embedded           | Collection of related resources "embedded" in the same response.

<aside class="warning">
  Always use the `links` provided for navigate across the API. Never try to guess the URI.
</aside>

The link collection is dynamically generated for each resource state. So you may expect to disappear links and appear
new ones adapted for the resource state (i.e. a payment action will disappear from a Sale already pay)
