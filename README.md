# tcptunnel

Use this container to forward a local tcp port to a remote tcp port. The container is using the `network_mode: host`. 
Therefore it forwards the traffic on the machine itself. Because this feature is only available on Linux it will only 
run correctly on Linux.

## Quickstart

```bash
git clone https://github.com/dameyerdave/tcptunnel
cd tcptunnel
cp .env.TEMPLATE .env
vi .env
LHOST=0.0.0.0
LPORT=18184
RHOST=localhost
RPORT=8888
docker-compose up -d
```

In this example you have a open listening `18184` port on every interface what traffic is forwarded to localhost port `8888`.

```bash
       +------+           +-----+
:18184 | intf | --> :8888 | lo0 | --> whatever service is listening on lo0:8888 
       +------+           +-----+
```

For example this can be used if you want to forward proxy requests through a ssh tunnel:

```bash
       +------+           +-----+                          +-------+
:18184 | intf | --> :8888 | lo0 | --> SSH-Tunnel --> :3128 | proxy | 
       +------+           +-----+                          +-------+
```

With it you can configre docker proxy settings in `~/.docker/config.json` and use the setup to deploy containers:

```json
{
 "proxies":
 {
   "default":
   {
     "httpProxy": "http://172.17.0.1:18184",
     "httpsProxy": "http://172.17.0.1:18184",
     "noProxy": ""
   }
 }
}
```

Important to mention that you need to use the ip of the `docker0` network interface which is `172.17.0.1` by default:

```bash
ip a s docker0
```