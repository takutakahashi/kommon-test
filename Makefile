.PHONY: all clean ruby go c test

all: ruby go c

ruby:
	ruby fizbuzz.rb

go:
	go run fizzbuzz.go

c: fizbuzz
	./fizbuzz

fizbuzz: fizbuzz.c
	gcc -o fizbuzz fizbuzz.c

test:
	go test ./...

clean:
	rm -f fizbuzz