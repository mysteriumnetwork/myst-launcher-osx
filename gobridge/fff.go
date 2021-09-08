package main

/*
#cgo CFLAGS: -x objective-c
#cgo LDFLAGS: -framework Foundation
#cgo LDFLAGS: -L./ -lff.o
#include "ff.h"
*/
import "C"

import (
	"fmt"
	"sync"

	"github.com/mysteriumnetwork/myst-launcher/app"
	"github.com/mysteriumnetwork/myst-launcher/gui"
	"github.com/mysteriumnetwork/myst-launcher/model"
	"github.com/mysteriumnetwork/myst-launcher/myst"
	"github.com/mysteriumnetwork/myst-launcher/utils"
)

var (
	manager *myst.Manager
	cfg     model.Config
	mon     *myst.DockerMonitor
	mod     *gui.UIModel

	ap *app.AppState

	// native, output
	st C.NSState
	mu sync.Mutex
)

func init() {
	utils.IsProcessRunning("Docker")

	fmt.Println("init fff 0.0.3>")
	ap = app.NewApp()

	mod = gui.NewUIModel()
	fmt.Println("init fff>", mod.Config)

	mod.UIBus.Subscribe("container-state", func() {
		fmt.Println("container-state")

		//g.dlg.Synchronize(func() {
		//	g.setImage()
		//})
	})

	mod.UIBus.Subscribe("model-change", func() {
		mu.Lock()

		st.imageName = C.CString(mod.ImgVer.ImageName)
		st.currentVersion = C.CString(mod.ImgVer.VersionCurrent)
		st.latestVersion = C.CString(mod.ImgVer.VersionLatest)
		st.hasUpdate = C.bool(mod.ImgVer.HasUpdate)

		st.dockerRunning = C.int(mod.StateDocker)
        st.containerRunning = C.int(mod.StateContainer)
        
  
		st.enablePortForwarding = C.bool(mod.Config.EnablePortForwarding)
		st.portRangeBegin = C.int(mod.Config.PortRangeBegin)
		st.portRangeEnd = C.int(mod.Config.PortRangeEnd)
        st.autoUpgrade = C.bool(mod.Config.AutoUpgrade)

		C.macSend(&st)

		mu.Unlock()
	})

	mod.SetApp(ap)
	ap.SetModel(mod)
	//ap.SetUI(ui)
	ap.WaitGroup.Add(1)

	go ap.SuperviseDockerNode()
}

//export TriggerUIEvent
func TriggerUIEvent(s *C.char) {
	call := C.GoString(s)
	fmt.Println("TriggerEvent >", call)
}

//export SetStateAndConfig
func SetStateAndConfig(s *C.SetStateArgs) {
	fmt.Println("SetState >", s)

    mod.Config.EnablePortForwarding = bool(s.enablePortForwarding)
    mod.Config.PortRangeBegin = int(s.portRangeBegin)
    mod.Config.PortRangeEnd = int(s.portRangeEnd)
    mod.Config.AutoUpgrade = bool(s.autoUpgrade)
    
	mod.Config.Save()

	ap.TriggerAction("upgrade")
}

func QueryState(st *C.NSState) {
	fmt.Println("p>", st)
	/*
		fmt.Println("p>", manager.CanPingDocker())
		// C.macSend()

		mod.ImgVer.CurrentImgDigest = manager.GetCurrentImageDigest()
		myst.CheckVersionAndUpgrades(mod)

		fmt.Println("d>>", mod.ImgVer, mod.ImgVer.VersionLatest)

		isRunning, _ := mon.IsRunning()
		st.dockerRunning = C.bool(isRunning)
		st.currentVersion = C.CString(mod.ImgVer.VersionCurrent)
		st.latestVersion = C.CString(mod.ImgVer.VersionLatest)
		st.hasUpdate = C.bool(mod.ImgVer.HasUpdate)
	*/
}

///

func main() {
	ap.WaitGroup.Wait()
}
