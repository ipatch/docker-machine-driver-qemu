package qemu

import (
	"github.com/docker/machine/libmachine/drivers/plugin"
  //
  // NOTE: I changed the package source path to my local fork,
  // ...there's probably a better way to handle this.
  //
  "github.com/ipatch/docker-machine-driver-qemu/cmd"
	// "github.com/jigtools/docker-machine-driver-qemu"
)

func main() {
	plugin.RegisterDriver(qemu.NewDriver("", ""))
}

