package main

/*
#cgo CFLAGS: -x objective-c
#cgo LDFLAGS: -framework Foundation
#cgo LDFLAGS: -L./ -lff.o
#include "ff.h"
*/
import "C"

import "fmt"

type UiProxy struct {
	result chan int
}

func newUiProxy() *UiProxy {
	g := &UiProxy{}
	g.result = make(chan int)

	return g
}

func (g *UiProxy) ShowMain() {}

func (g *UiProxy) ShowNotificationInstalled() {}

func (g *UiProxy) ShowNotificationUpgrade() {}

func (g *UiProxy) ConfirmModal(title, message string) int {   
    var m C.NSModal
    m.title = C.CString(title)
    m.msg = C.CString(message)
    m.modal_type = C.MODAL_ConfirmModal;
    C.macSendModal(&m)

    return <-g.result
}

func (g *UiProxy) YesNoModal(title, message string) int {
	var m C.NSModal
	m.title = C.CString(title)
	m.msg = C.CString(message)
    m.modal_type = C.MODAL_YesNoModal;
	C.macSendModal(&m)

	return <-g.result
}

func (g *UiProxy) ErrorModal(title, message string) int {
    var m C.NSModal
    m.title = C.CString(title)
    m.msg = C.CString(message)
    m.modal_type = C.MODAL_ErrorModal;
    C.macSendModal(&m)

    return <-g.result
}

func (g *UiProxy) SetModalReturnCode(rc int) {
    g.result <- rc
}
