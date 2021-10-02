# pushnotify

Dockerized push notifications on events from the unix journal.
A REST notification service (i.e. [Catapush](https://www.catapush.com/)) can be used.


## Usage

### Prerequisites

* [`docker-compose`](https://github.com/docker/compose)
* [`just`](https://github.com/casey/just)

### Install

Build the docker (`aarch64` / `arm64` default) :
```bash
just build
```

For `amd64`:
```bash
just build linux/amd64
```

### Running

```bash
just run
```

By default, a TTY will be allocated and pushnotify will run in foreground.
To run in daemon mode (background):

```bash
just run -d
```

### Screenshots
![alt text](screenshots/demo.png)

### Journalctl log snippet

```bash
Oct 02 10:15:07 bambam ovpn-server[1815]: 192.168.0.1:50541 [iPhone_Mihai_20210918] Peer Connection Initiated with [AF_INET]192.168.0.1:50541
Oct 02 10:16:44 bambam ovpn-server[1815]: 213.142.97.150:62531 [iPhone_Mihai_20210918] Peer Connection Initiated with [AF_INET]213.142.97.150:62531
```
