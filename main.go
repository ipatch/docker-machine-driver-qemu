package qemu

import (

  // "fmt"
  // "os"

	"github.com/docker/machine/libmachine/drivers/plugin"
	// "github.com/jigtools/docker-machine-driver-qemu"
  "github.com/ipatch/docker-machine-driver-qemu/pkg/drivers/qemu"
)

func main() {
	plugin.RegisterDriver(qemu.NewDriver("", ""))
}

// func main() {
//   if len(os.Args) >= 2 && os.Args[1] == "qemu" {
//     runQemu()
//   } else {
//     ssh.SetDefaultClient(ssh.Native)
//     plugin.RegisterDriver(qemu.NewDriver("", ""))
//   }
// }

// func run Qemu() {
//   done := make(chan bool)
//   ptyCh := make(chan string)

//   args := os.Args[1:]

//   if os.Args[len(os.Args)-1] != "-M" {
// 		fmt.Printf("Waiting on a pseudo-terminal to be ready... ")
// 		pty := <-ptyCh
// 		fmt.Printf("done\n")
// 		fmt.Printf("Hook up your terminal emulator to %s in order to connect to your VM\n", pty)
// 	}

// 	<-done
// }
