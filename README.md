# alert

Push notifications on events from the unix journal.
A REST notification service (i.e. [Catapush](https://www.catapush.com/)) can be used.


## Usage

### Prerequisites

[`docker-compose`](https://github.com/docker/compose).
[`just`](https://github.com/casey/just).

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

### Screenshots
![alt text](screenshots/demo.png)
