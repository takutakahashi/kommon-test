.PHONY: all clean ruby go c rust test

all: ruby go c rust

ruby:
	ruby fizbuzz.rb

go:
	go run fizzbuzz.go

c: fizbuzz
	./fizbuzz

rust:
	rustc fizzbuzz.rs
	./fizzbuzz

fizbuzz: fizbuzz.c
	gcc -o fizbuzz fizbuzz.c

test:
	go test ./...

clean:
	rm -f fizbuzz fizzbuzz