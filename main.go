package main

import "fmt"

//garble:controlflow
func main() {
	doSomething("thingy")
}

//garble:controlflow
func doSomething(thing string) {
	fmt.Println(thing)
}
