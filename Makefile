.PHONY: all clean ruby go c rust test tomorrow-all

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

# 明日の日付を表示する機能をすべての言語で実行
tomorrow-all: tomorrow-ruby tomorrow-go tomorrow-c tomorrow-rust

tomorrow-ruby:
	@echo "Ruby version:"
	@ruby tomorrow.rb

tomorrow-go:
	@echo "Go version:"
	@go run tomorrow.go

tomorrow-c: tomorrow
	@echo "C version:"
	@./tomorrow

tomorrow-rust:
	@echo "Rust version:"
	@rustc tomorrow.rs -o tomorrow_rs
	@./tomorrow_rs

tomorrow: tomorrow.c
	gcc -o tomorrow tomorrow.c

clean:
	rm -f fizbuzz fizzbuzz tomorrow tomorrow_rs