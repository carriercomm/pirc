PerlIRC : Yet another IRC server
========

Basic IRC server written in perl.

The IRC protocol
--------

> All according to the [RFC 1459](https://tools.ietf.org/html/rfc1459)

### Currently supported

Basic client-server handshake
```
CLIENT->SERVER : USER <username> <hostname> <servername> <realname>
CLIENT->SERVER : NICK <nickname>
```
Additionally, the server can send a ping request.
```
SERVER->CLIENT : PING <token>
CLIENT->SERVER : PONG <token>
```

Testing
-------

Testing can be done using any IRC client (like hexchat) or using netcat :
```BASH
nc <server_address> 6667 -v # fun to play with, but be fast when you type !
```
