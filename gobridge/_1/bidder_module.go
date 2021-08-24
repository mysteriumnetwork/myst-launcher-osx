package main

/*
#cgo CFLAGS: -x objective-c
#cgo LDFLAGS: -framework Foundation
#include "foundation.h"
*/
import "C"

import (
	"sort"
	"fmt"
)

//export Add
func Add(a, b int) int {
	return a + b
}

//export Sub
func Sub(a, b int) int {
	return a - b
}

//export Print
func Print(str string) {
	fmt.Printf("Go prints: %s\n", str)
} 

func strFxn(input string) string {
    return "Hello " + input + " World"
}

//export StrFxn
func StrFxn(cinput *C.char) *C.char {
    // C data needs to be manually managed in memory.
    // But we will do it from C++.
    input := C.GoString(cinput)
    return C.CString(strFxn(input))
}

//export Sort
func Sort(vals []int) {
	sort.Ints(vals)
}

/*
func CheckUpdates(arr *C.char) {
    C.nsarray_additem(nil, 123)
}
*/

/////////////////////////////////////////////////////////////////////
func init() {
	fmt.Println("init >>");
	/*
    go func() {
		for ;; {
			fmt.Println("init >>");
			time.Sleep(2* time.Second)
		}
	}()
    */
}

func main() {
	fmt.Println("main >>");

	// We need the main function to make possible
	// CGO compiler to compile the package as C shared library
}
