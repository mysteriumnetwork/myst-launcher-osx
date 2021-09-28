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
	"io/ioutil"
	"log"
	"os"

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
	fmt.Println("gobridge init>")
}

func copyFile(sourceFile, destinationFile string) {
	input, err := ioutil.ReadFile(sourceFile)
	if err != nil {
		fmt.Println(err)
		return
	}

	err = ioutil.WriteFile(destinationFile, input, 0644)
	if err != nil {
		fmt.Println("Error creating", destinationFile)
		fmt.Println(err)
		return
	}
}

//export GoInit
func GoInit(res_path *C.char) {
	cfg.ResourcePath = C.GoString(res_path)

	targetDir := os.Getenv("HOME") + "/Library/LaunchAgents/"
	os.MkdirAll(targetDir, 0755)

	fileName := "com.mysterium.launcher.plist"
	copyFile(cfg.ResourcePath+"/"+fileName, targetDir+fileName)
 }

//export GoStart
func GoStart() {
    fmt.Println("GoStart >")
	ap = app.NewApp()
	mod = model.NewUIModel()
	sendConfig()

	mod.UIBus.Subscribe("state-change", func() {
		C.macSendMode(C.int(mod.State))
	})
	mod.UIBus.Subscribe("log", func(p []byte) {
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
	st.checkVirt = C.bool(mod.CheckVirt)
	st.checkDocker = C.bool(mod.CheckDocker)
    st.downloadFiles = C.bool(mod.DownloadFiles)
    st.installDocker = C.bool(mod.InstallDocker)

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

//export GoSetModalResult
func GoSetModalResult(rc C.int) {
	fmt.Println("CloseModal >", int(rc))
	ui.SetModalReturnCode(int(rc))
}

//export GoDialogueComplete
func GoDialogueComplete() {
	fmt.Println("DialogueComplete >")
	ui.DialogueComplete()
}

//export GoOnAppExit
func GoOnAppExit() {
	ap.TriggerAction("stop")

	// wait for SuperviseDockerNode to finish its work
	ap.WaitGroup.Wait()
}

//export GoSetStateAndConfig
func GoSetStateAndConfig(s *C.SetStateArgs) {
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

// required by runtime
func main() {}
