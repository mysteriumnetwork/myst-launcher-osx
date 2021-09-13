package main

/*
#cgo CFLAGS: -x objective-c
#cgo LDFLAGS: -framework Foundation
#cgo LDFLAGS: -L./ -linterface.o
#include "interface.h"
*/
import "C"

import (
	"fmt"
	"log"

	"github.com/mysteriumnetwork/myst-launcher/app"
	"github.com/mysteriumnetwork/myst-launcher/model"
	"github.com/mysteriumnetwork/myst-launcher/myst"
)

var (
	manager *myst.Manager
	cfg     model.Config
	mon     *myst.DockerMonitor
	mod     *model.UIModel

	ap *app.AppState
	ui model.Gui_
)

func init() {
	fmt.Println("init>")
	ap = app.NewApp()

	mod = model.NewUIModel()
	fmt.Println("init fff>", mod.Config)
	sendConfig()

	mod.UIBus.Subscribe("state-change", func() {
		fmt.Println("state-change >", mod.State)
		C.macSendMode(C.int(mod.State))
	})
	mod.UIBus.Subscribe("log", func(p []byte) {
		//fmt.Println("log > > >", p)
		C.macSendLog(C.CString(string(p)))
	})
	log.SetOutput(ap)

	mod.UIBus.Subscribe("model-change", sendState)
	ui = newUiProxy()

	mod.SetApp(ap)
	ap.SetModel(mod)
	ap.SetUI(ui)

	ap.WaitGroup.Add(1)
	go ap.SuperviseDockerNode()
}

func sendState() {
	var st C.NSState

	st.imageName = C.CString(mod.ImgVer.ImageName)
	st.currentVersion = C.CString(mod.ImgVer.VersionCurrent)
	st.latestVersion = C.CString(mod.ImgVer.VersionLatest)
	st.hasUpdate = C.bool(mod.ImgVer.HasUpdate)
	st.dockerRunning = C.int(mod.StateDocker)
	st.containerRunning = C.int(mod.StateContainer)

	// instllation state
	st.checkVTx = C.bool(mod.CheckVTx)
	st.checkDocker = C.bool(mod.CheckDocker)

	C.macSendState(&st)
}

func sendConfig() {
	var cf C.NSConfig

	cf.enablePortForwarding = C.bool(mod.Config.EnablePortForwarding)
	cf.portRangeBegin = C.int(mod.Config.PortRangeBegin)
	cf.portRangeEnd = C.int(mod.Config.PortRangeEnd)
	cf.autoUpgrade = C.bool(mod.Config.AutoUpgrade)
	cf.enabled = C.bool(mod.Config.Enabled)

	C.macSendConfig(&cf)
}

//export SetModalResult
func SetModalResult(rc C.int) {
	fmt.Println("CloseModal >", int(rc))
	ui.SetModalReturnCode(int(rc))
}

//export DialogueComplete
func DialogueComplete() {
	fmt.Println("DialogueComplete >")

	ui.DialogueComplete()
}

//export SetStateAndConfig
func SetStateAndConfig(s *C.SetStateArgs) {
	fmt.Println("SetState >", s)
	saveConf := false

	if mod.Config.AutoUpgrade != bool(s.autoUpgrade) {
		mod.Config.AutoUpgrade = bool(s.autoUpgrade)
		saveConf = true
	}

	if mod.Config.Enabled != bool(s.enabled) {
		if bool(s.enabled) {
			ap.TriggerAction("enable")
		} else {
			ap.TriggerAction("disable")
		}
	}

	if mod.Config.EnablePortForwarding != bool(s.enablePortForwarding) || mod.Config.PortRangeBegin != int(s.portRangeBegin) || mod.Config.PortRangeEnd != int(s.portRangeEnd) {
		mod.Config.EnablePortForwarding = bool(s.enablePortForwarding)
		mod.Config.PortRangeBegin = int(s.portRangeBegin)
		mod.Config.PortRangeEnd = int(s.portRangeEnd)

		ap.TriggerAction("upgrade")
		saveConf = true
	}

	if saveConf {
		mod.Config.Save()
	}
}

///
func main() {
	ap.WaitGroup.Wait()
}
