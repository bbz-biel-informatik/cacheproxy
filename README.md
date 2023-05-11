# BBZ Biel Caching CORS proxy

## Operations

### Fetch data

To perform a GET request, use the `/get` endpoint. A request to
`https://cacheproxy.bbz.cloud/get/api.icndb.com/jokes/1285` is automatically
proxied to `https://api.icndb.com/jokes/1285` and the response is cached.

### Clear cache

To clear a specific entry of the cache, send a GET request to the `/del`
endpoint. Requesting the url `https://cacheproxy.bbz.cloud/del/api.icndb.com/jokes/1285`
clears the cache entry for the above URL.

## Reporting

The server returns the `X-Cache-Status` header containing either the
text `HIT` for a redis cache hit or `MISS` if the entry was not found
in the cache and requested from the origin server.
