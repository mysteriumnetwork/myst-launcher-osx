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
	"net/url"
	"strconv"
	"unsafe"

	"github.com/mysteriumnetwork/myst-launcher/model"
	"github.com/mysteriumnetwork/myst-launcher/myst"
)

var (
	m   *myst.Manager
	cfg model.Config
)

func init() {
	fmt.Println("init fff>")

	m, _ = myst.NewManagerWithDefaults()
	cfg.Read()
}

//export QueryState
func QueryState(st *C.NSState) {
	fmt.Println("p>", st)
	fmt.Println("p>", m.CanPingDocker())

	//C.nsarray_additem((*C.NSArray)(arr), C.ulong(200))
	//C.nsstate_set((*C.NSState)(arr))

	vi := myst.ImageVersionInfo{}
	vi.CurrentImgDigest = m.GetCurrentImageDigest()
	myst.CheckVersionAndUpgrades(&vi, &cfg)
	fmt.Println("d>>", vi, vi.VersionLatest)

	st.currentVersion = C.CString(vi.VersionCurrent)
	st.latestVersion = C.CString(vi.VersionLatest)
    st.hasUpdate = C.bool(vi.HasUpdate)
}

//export FreeState
func FreeState(s *C.NSState) {
    C.free(unsafe.Pointer(s.currentVersion))
    C.free(unsafe.Pointer(s.latestVersion))
}

/////////////////////

// NSString -> C string
func cstring(s *C.NSString) *C.char { return C.nsstring2cstring(s) }

// NSString -> Go string
func gostring(s *C.NSString) string { return C.GoString(cstring(s)) }

// NSNumber -> Go int
func goint(i *C.NSNumber) int { return int(C.nsnumber2int(i)) }

// NSArray length
func nsarraylen(arr *C.NSArray) uint { return uint(C.nsarraylen(arr)) }

// NSArray item
func nsarrayitem(arr *C.NSArray, i uint) unsafe.Pointer {
	return C.nsarrayitem(arr, C.ulong(i))
}

// NSURL -> Go url.URL
func gourl(nsurlptr *C.NSURL) *url.URL {
	nsurl := *C.nsurldata(nsurlptr)

	userInfo := url.UserPassword(
		gostring(nsurl.user),
		gostring(nsurl.password),
	)

	host := gostring(nsurl.host)

	if nsurl.port != nil {
		port := goint(nsurl.port)
		host = host + ":" + strconv.FormatInt(int64(port), 10)
	}

	return &url.URL{
		Scheme:   gostring(nsurl.scheme),
		User:     userInfo, // username and password information
		Host:     host,     // host or host:port
		Path:     gostring(nsurl.path),
		RawQuery: gostring(nsurl.query),    // encoded query values, without '?'
		Fragment: gostring(nsurl.fragment), // fragment for references, without '#'
	}
}

// NSArray<NSURL> -> Go []url.URL
func gourls(arr *C.NSArray) []url.URL {
	var result []url.URL
	length := nsarraylen(arr)

	for i := uint(0); i < length; i++ {
		nsurl := (*C.NSURL)(nsarrayitem(arr, i))
		u := gourl(nsurl)
		result = append(result, *u)
	}

	return result
}

func UserApplicationSupportDirectories() []url.URL {
	return gourls(C.UserApplicationSupportDirectories())
}

/////////////////

func main() {
	fmt.Printf("%#+v\n", UserApplicationSupportDirectories())
}
