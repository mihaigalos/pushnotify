# alert

Push notifications on events from the unix journal.
A REST notification service (i.e. [Catapush](https://www.catapush.com/)) can be used.


## Usage

### Prerequisites

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

### Screenshots
![alt text](screenshots/demo.png)
