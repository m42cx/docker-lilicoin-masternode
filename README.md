lilicoin masternode for docker
===================

Docker image that runs the lilicoin daemon which can be turned into a masternode with the correct configuration.

donate: 13h7w3tc4xNEAv97Dr2i2ceSwnRkMcZDXE 


Quick Start
-----------

```bash
docker run \
  -d \
  -p 13333:13333 \
  -v /some/directory:/lili \
  --name=lili \
  m42cx/docker-lilicoin-masternode
```

This will create the folder `.terracoincore` in `/some/directory` with a bare `lilicoin.conf`. You might want to edit the `lilicoin.conf` before running the container because with the bare config file it doesn't do much, it's basically just an empty wallet.

Start as masternode
------------

To start the masternode functionality, edit your terracoin.conf (should be in /some/directory/.lilicoin/ following the docker run command example above):

```
rpcuser=<SOME LONG RANDOM USER NAME>
rpcpassword=<SOME LONG RANDOM PASSWORD>
rpcallowip=::/0
server=1
logtimestamps=1
maxconnections=256
printtoconsole=1
masternode=1
masternodeaddr=<SERVER IP ADDRESS>:51472
masternodeprivkey=<MASTERNODE PRIVATE KEY>
```

Where `<SERVER IP ADDRESS>` is the public facing IPv4 or IPv6 address that the masternode will be reachable at.
Don't forget to put your IPv6 address in brackets! For example `[aaaa:bbbb:cccc::0]:51472`

`<MASTERNODE PRIVATE KEY>` is the private key that you generated earlier (with `terracoin-cli masternode genkey`).
