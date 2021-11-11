package main

/*
#cgo CFLAGS: -x objective-c
#cgo LDFLAGS: -framework Foundation
#cgo LDFLAGS: -L./ -linterface.o
#include "interface.h"
*/
import "C"

import "fmt"

type UiProxy struct {
	result    chan int
	waitClick chan int
}

func newUiProxy() *UiProxy {
	g := &UiProxy{}
	g.result = make(chan int)
	g.waitClick = make(chan int)

	return g
}

func (g *UiProxy) PopupMain()                 {}
func (g *UiProxy) ShowMain()                  {}
func (g *UiProxy) ShowNotificationInstalled() {}
func (g *UiProxy) ShowNotificationUpgrade()   {}

func (g *UiProxy) ConfirmModal(title, message string) int {
	var m C.NSModal
	m.title = C.CString(title)
	m.msg = C.CString(message)
	m.modal_type = C.MODAL_ConfirmModal
	C.macSendModal(&m)

	return <-g.result
}

func (g *UiProxy) YesNoModal(title, message string) int {
	var m C.NSModal
	m.title = C.CString(title)
	m.msg = C.CString(message)
	m.modal_type = C.MODAL_YesNoModal
	C.macSendModal(&m)

	return <-g.result
}

func (g *UiProxy) ErrorModal(title, message string) int {
	var m C.NSModal
	m.title = C.CString(title)
	m.msg = C.CString(message)
	m.modal_type = C.MODAL_ErrorModal
	C.macSendModal(&m)

	return <-g.result
}

func (g *UiProxy) SetModalReturnCode(rc int) {
	g.result <- rc
}

func (g *UiProxy) CloseUI() {
	fmt.Println("CloseUI")

	// g.model.WantExit = true
	// g.bus.Publish("exit")
}

func (g *UiProxy) OpenDialogue(id int) {
	C.macSendOpenDialogue(C.int(id))
	g.WaitDialogueComplete()
}

// returns false, if dialogue was terminated
func (g *UiProxy) WaitDialogueComplete() bool {
	fmt.Println("WaitDialogueComplete")
	_, ok := <-g.waitClick
	return ok
}

func (g *UiProxy) TerminateWaitDialogueComplete() {
	fmt.Println("TerminateWaitDialogueComplete")
	close(g.waitClick)
}

func (g *UiProxy) DialogueComplete() {
	select {
	case g.waitClick <- 0:
	default:
	}
}
