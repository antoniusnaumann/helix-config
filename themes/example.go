package main

import (
	"fmt"
	"time"
)

// Generic function that works with any type
func PrintTwice[T any](value T) {
	fmt.Println(value)
	fmt.Println(value)
}

// Interface definition
type Speaker interface {
	Speak() string
}

// Struct implementation
type Person struct {
	Name string
}

func (p Person) Speak() string {
	return "Hello, " + p.Name
}

// Generic struct
type Container[T any] struct {
	Value T
}

func main() {
	// Using the generic function
	PrintTwice("Hello, generics in Go!")
	PrintTwice(42)

	// Goroutine example
	go sayHello("world")

	// Channel usage
	messages := make(chan string)
	go func() { messages <- "ping" }()
	msg := <-messages
	fmt.Println(msg)

	// Defer usage
	defer fmt.Println("Deferred call")

	// Interface implementation
	var s Speaker = Person{"Alice"}
	fmt.Println(s.Speak())

	// Using a generic struct
	container := Container[int]{Value: 123}
	fmt.Println("Container value:", container.Value)

	// Select statement with channels
	c1 := make(chan string)
	c2 := make(chan string)

	go func() {
		time.Sleep(time.Second * 1)
		c1 <- "one"
	}()
	go func() {
		time.Sleep(time.Second * 2)
		c2 <- "two"
	}()

	select {
	case msg1 := <-c1:
		fmt.Println("Received", msg1)
	case msg2 := <-c2:
		fmt.Println("Received", msg2)
	}

	// Error handling using panic and recover
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("Recovered from panic:", r)
		}
	}()
	panic("something went wrong")
}

// Function with a goroutine
func sayHello(name string) {
	fmt.Println("Hello,", name)
	time.Sleep(time.Second)
}
