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
	mod     *model.UIModel

	ap *app.AppState
	ui model.Gui_
)

const (
	gitHubOrg  = "mysteriumnetwork"
	gitHubRepo = "myst-launcher-osx"
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
func GoInit(resPath *C.char, prodVer *C.char) {
	mod = model.NewUIModel()
	mod.SetProductVersion(C.GoString(prodVer))
	// set product repo

	targetDir := os.Getenv("HOME") + "/Library/LaunchAgents/"
	os.MkdirAll(targetDir, 0755)
	fileName := "com.mysterium.launcher.plist"
	resourcePath := C.GoString(resPath)
	copyFile(resourcePath+"/"+fileName, targetDir+fileName)
}

//export GoStart
func GoStart() {
	fmt.Println("GoStart >")
	ap = app.NewApp()
	sendConfig()

	mod.UIBus.Subscribe("state-change", func() {
		C.macSendMode(C.int(mod.State))
	})
	mod.UIBus.Subscribe("log", func(p []byte) {
		C.macSendLog(C.CString(string(p)))
	})
	mod.UIBus.Subscribe("launcher-update", func() {
		C.macSendOpenDialogue(C.int(1))
	})
	mod.DuplicateLogToConsole = true
	log.SetOutput(ap)

	mod.UIBus.Subscribe("model-change", sendState)
	ui = newUiProxy()

	mod.SetApp(ap)
	ap.SetModel(mod)
	ap.SetUI(ui)

	ap.WaitGroup.Add(1)
	go ap.SuperviseDockerNode()
	go ap.CheckLauncherUpdates(gitHubOrg, gitHubRepo)

}

func sendState() {
	var st C.NSState

	st.imageName = C.CString(mod.Config.GetFullImageName())
	st.currentVersion = C.CString(mod.ImageInfo.VersionCurrent)
	st.latestVersion = C.CString(mod.ImageInfo.VersionLatest)
	st.hasUpdate = C.bool(mod.ImageInfo.HasUpdate)
	st.dockerRunning = C.int(mod.StateDocker)
	st.containerRunning = C.int(mod.StateContainer)
	st.networkCaption = C.CString(mod.Config.GetNetworkCaption())

	// installation state
	st.checkVirt = C.int(mod.CheckVirt)
	st.checkDocker = C.int(mod.CheckDocker)
	st.downloadFiles = C.int(mod.DownloadFiles)
	st.installDocker = C.int(mod.InstallDocker)

	st.launcherHasUpdate = C.bool(mod.LauncherHasUpdate)
	st.productVersionLatestUrl = C.CString(mod.ProductVersionLatestUrl)
	st.launcherVersionLatest = C.CString(mod.ProductVersionLatest)

	C.macSendState(&st)
}

func sendConfig() {
	var cf C.NSConfig

	cf.enablePortForwarding = C.bool(mod.Config.EnablePortForwarding)
	cf.portRangeBegin = C.int(mod.Config.PortRangeBegin)
	cf.portRangeEnd = C.int(mod.Config.PortRangeEnd)
	cf.autoUpgrade = C.bool(mod.Config.AutoUpgrade)
	cf.enabled = C.bool(mod.Config.Enabled)
	cf.network = C.CString(mod.Config.Network)

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

//export GoTriggerUpgrade
func GoTriggerUpgrade() {
	ap.TriggerAction("upgrade")
}

//export GoSetState
func GoSetState(s *C.NSConfig) {

	if mod.Config.AutoUpgrade != bool(s.autoUpgrade) {
		mod.Config.AutoUpgrade = bool(s.autoUpgrade)
		mod.Config.Save()
	}

	if mod.Config.Enabled != bool(s.enabled) {
		if bool(s.enabled) {
			ap.TriggerAction("enable")
		} else {
			ap.TriggerAction("disable")
		}
	}
}

//export GoSetNetworkConfig
func GoSetNetworkConfig(s *C.NSConfig) {

	mod.Config.EnablePortForwarding = bool(s.enablePortForwarding)
	mod.Config.PortRangeBegin = int(s.portRangeBegin)
	mod.Config.PortRangeEnd = int(s.portRangeEnd)

	ap.TriggerAction("restart")
}

//export GoUpdateToMainnet
func GoUpdateToMainnet() {
	mod.UpdateToMainnet()
	sendConfig()
}

// required by runtime
func main() {}
