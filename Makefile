.PHONY: all clean ruby go c rust test

all: ruby go c rust

ruby:
	ruby fizzbuzz.rb

go:
	go run fizzbuzz.go

c: fizzbuzz
	./fizzbuzz

rust:
	rustc fizzbuzz.rs
	./fizzbuzz

fizzbuzz: fizzbuzz.c
	gcc -o fizzbuzz fizzbuzz.c

test:
	go test ./...

clean:
	rm -f fizbuzz fizzbuzz