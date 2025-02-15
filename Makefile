.PHONY: all clean ruby go c test test-ruby test-go test-c

all: ruby go c

ruby:
	ruby fizzbuzz.rb

go:
	go run fizzbuzz.go

c: fizzbuzz
	./fizzbuzz

fizzbuzz: fizzbuzz.c
	gcc -o fizzbuzz fizzbuzz.c

test: test-ruby test-go test-c

test-ruby:
	ruby fizzbuzz_test.rb

test-go:
	go test ./...

test-c: fizzbuzz_test
	./fizzbuzz_test

fizzbuzz_test: fizzbuzz_test.c fizzbuzz.c
	gcc -o fizzbuzz_test fizzbuzz_test.c

clean:
	rm -f fizzbuzz fizzbuzz_test