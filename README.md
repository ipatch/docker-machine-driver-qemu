# Docker machine qemu driver

I needed a **non-libvirt** qemu driver, so this is it.

from [@SvenDowideit](https://github.com/SvenDowideit)

Its initial use is going to be for running the [Rancher OS](https://github.com/rancher/os) tests, but maybe you'll find a use for it too.

from @fventuri

#### QEMU

Create machines locally using [QEMU](http://www.qemu.org/).
This driver requires QEMU to be installed on your host.

> See [Installing QEMU](#installing-qemu) for instructions on installing QEMU for your OS

    $ docker-machine create --driver=qemu qemu-test

**Options**

 - `--qemu-boot2docker-url`: The URL of the boot2docker image. Defaults to the latest available version.
 - `--qemu-disk-size`: Size of disk for the host in MB. Default: `20000`
 - `--qemu-memory`: Size of memory for the host in MB. Default: `1024`
 - `--qemu-cpu-count`: Number of CPUs. Default: `1`
 - `--qemu-program` : Name of the qemu program to run. Default: `qemu-system-x86_64`
 - `--qemu-display` : Show the graphical display output to the user. Default: false
 - `--qemu-display-type` : Select type of display to use (sdl/vnc=localhost:0/etc)
 - `--qemu-nographic` : Use -nographic instead of -display none. Default: false
 - `--qemu-virtio-drives` : Use virtio for drives (cdrom and disk). Default: false
 - `--qemu-network`: Networking to be used: user, tap or bridge. Default: `user`
 - `--qemu-network-interface`: Name of the network interface to be used for networking. Default: `tap0`
 - `--qemu-network-address`: IP of the network address to be used for networking.
 - `--qemu-network-bridge`: Name of the network bridge to be used for networking. Default: `br0`

The `--qemu-boot2docker-url` flag takes a few different forms.  By
default, if no value is specified for this flag, Machine will check locally for
a boot2docker ISO.  If one is found, that will be used as the ISO for the
created machine.  If one is not found, the latest ISO release available on
[boot2docker/boot2docker](https://github.com/boot2docker/boot2docker) will be
downloaded and stored locally for future use.  Note that this means you must run
`docker-machine upgrade` deliberately on a machine if you wish to update the "cached"
boot2docker ISO.

This is the default behavior (when `--qemu-boot2docker-url=""`), but the
option also supports specifying ISOs by the `http://` and `file://` protocols.
`file://` will look at the path specified locally to locate the ISO: for
instance, you could specify `--qemu-boot2docker-url
file://$HOME/Downloads/rc.iso` to test out a release candidate ISO that you have
downloaded already.  You could also just get an ISO straight from the Internet
using the `http://` form.

Note that when using virtio the drives will be mounted as `/dev/vda` and `/dev/vdb`,
instead of the usual `/dev/cdrom` and `/dev/sda`, since they are using paravirtualization.

If using the real network (tap or bridge), note that it needs a DHCP server running.
The user network has it's own NAT network, which usually means it is running on 10.0.2.15
Ultimately this driver should be able to query for IP, but for now the workaround is
to use `--qemu-network-address` (and fixed addresses) until that feature is implemented.

Environment variables:

Here comes the list of the supported variables with the corresponding options. If both environment
variable and CLI option are provided the CLI option takes the precedence.

| Environment variable              | CLI option                        |
|-----------------------------------|-----------------------------------|
| `QEMU_BOOT2DOCKER_URL`            | `--qemu-boot2docker-url`          |
| `QEMU_VIRTIO_DRIVES`              | `--qemu-virtio-drives`            |

## Installing QEMU

### macOS

To install QEMU on macOS, one of the quickest ways is to install via [brew](http://brew.sh)

> Instructions on installing Homebrew can be found at [brew.sh](https://brew.sh/)

Once Homebrew has been installed and setup,

```
brew install qemu
```

### GNU/Linux

> Installing QEMU on GNU/Linux with an agnostic package manager, ie [Linuxbrew](http://linuxbrew.sh/) 

```
brew install qemu
```

> Instructions for installing Linuxbrew can be found at [linuxbrew.sh](linuxbrew.sh)

## Building `docker-machine-qemu-driver` from source

> To build this particular docker-machine driver, one will require a working Go envrionment, for more information about Go, [click here](https://golang.org/)

To get a working Go environment setup on macOS or GNU/Linux using [Homebrew](brew.sh) or [Linuxbrew](linuxbrew.sh)

```
brew install go
```

The above command will get a working version [the Go Programming language](http://golang.org) setup on the localhost.

After Go has been installed and setup, one can download docker-machine-driver-qemu with the below command

```
go get -d github.com/machine-drivers/docker-machine-driver-qemu
```

The downloaded repo / project will be stored in `$GOPATH/src/github.com/machine-drivers/docker-machine-driver-qemu`

To build the driver using the **Makefile** change directory to the driver machine project root, and run `make build`.  If all goes well a binary with the name of `docker-machine-driver-qemu` will be placed in `$GOPATH/src/github.com/machine-drivers/docker-machine-driver-qemu/bin/`

The above mentioned driver can be copied to any location on the system as long as the binary is executable and located in the user's `$PATH` ie. `/usr/local/bin`

<details>
<summary><strong>For Developers Only</strong></summary>
<p>

This project uses [dep](https://golang.github.io/dep/) to manage Go Language project dependancies.

The **vendor** directory within this project is the directory that **dep** uses to maintain dependancies for the project.

**Note** Go lang tends to lean more towards convention over configuration, ie. when building a _cmd_ ie. `docker-machine-driver-qemu` the Go compiler looks for a `.go` file with the name of the command within the directory `cmd`.

For more information about Go lang project structure [click me](https://golang.org/pkg/go/build/)

#### Build using native Go tooling

To build the `docker-machine-driver-qemu` cmd directly using `go` thus bypassing the Makefile

```
go build
```

The above command should create a system binary located in the project root called `docker-machine-driver-qemu`.

To get a more diagnostic understanding of what is going on under the hood of the `build` sub command, pass the `-x` flag to build, ie.

```
go build -x -v -o [./bin/docker-machine-driver-qemu-name-change]
```

> Changing the name of the binary is required to see full verbose output of the above command.

#### Build using Makefile

To build and install this project / docker-machine driver using the accompanying `Makefile`

```
cd $GOPATH/github.com/machine-drivers/docker-machine-driver-qemu
make build
make install
make clean
```

The above commands will build the docker-machine driver and put `docker-machine-driver-qemu` located within `/usr/local/bin`, and clean the local build artifacts.

</p>

</details>



