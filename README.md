# nginx-ajp-docker
This repo contains a dockerfile that can be used to set up an nginx webserver that will forward to an AJP proxy running on a given server.

Build with:
```shell
podman build --build-arg NGINX_VERSION='1.22.1' -t nginx-ajp:1.0 .
```

Run with:
```shell
podman run -p 8081:8081 -e AJP_ADDRESS='<HOST>:8009' --name nginx-ajp nginx-ajp:1.0
```

Access by visiting `localhost:8081` in your browser.

