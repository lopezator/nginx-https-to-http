# nginx-https-to-http

nginx-https-to-http let's you test services that require a https connection without the burden of having to manage
a https server by yourself.

By default, it starts a https server in the port `4433` and redirects all the request to a http address in the port 
`8080` **to the same host and the same request path used in the https request**.

The two mentioned ports are customizable by using the `NGINX_HTTP_PORT` and `NGINX_HTTPS_PORT` environment variables. 

⚠ **Warning: Since the private key is obviously leaked in this repo, this image is only suitable for development. If you
need to use it in prod, you'll need to use your own cert files.**

## QuickStart

Default run (https->4433, http->8080): 

```bash
docker run -p 4433:4433 lopezator/nginx-https-to-http
```

Custom ports run:

```bash
docker run -p 4433:4433 -e NGINX_HTTP_PORT 8888 -e NGINX_HTTPS_PORT 4444 -d lopezator/nginx-https-to-http
```

## Playground

1. Run `lopezator/nginx-https-to-http` in your localhost:

```bash
docker run -p 4433:4433 -d lopezator/nginx-https-to-http 
```

2. Run a http server in your localhost on port 8080:

```bash
python3 -m http.server 8080
```

3. Simulate a `https` request on `localhost:4433`:

```bash
curl -k -L https://localhost:4433
```

And 💃, check your logs, and you'll see that your request arrived to `lopezator/nginx-https-to-http` and got redirected 
to your http server.

```bash
# lopezator/nginx-https-to-http
172.17.0.1 - - [04/May/2022:09:51:16 +0000] "GET / HTTP/1.1" 308 171 "-" "curl/7.58.0" "-"

# python3 http.server
127.0.0.1 - - [04/May/2022 11:51:16] "GET / HTTP/1.1" 200 -
```