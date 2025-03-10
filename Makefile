.PHONY: all clean ruby go c rust python test

all: ruby go c rust python

ruby:
	ruby fizbuzz.rb 15

go:
	go run fizzbuzz.go 15

c: fizbuzz
	./fizbuzz 15

rust:
	rustc fizzbuzz.rs
	./fizzbuzz 15

python:
	mise exec python@latest -- python fizzbuzz.py 15

fizbuzz: fizbuzz.c
	gcc -o fizbuzz fizbuzz.c

test:
	go test fizzbuzz_test.go fizzbuzz.go
	mise exec python@latest -- python -m unittest test_fizzbuzz.py

clean:
	rm -f fizbuzz fizzbuzz