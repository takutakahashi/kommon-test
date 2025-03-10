#!/usr/bin/env ruby

def fizzbuzz(n)
  return "FizzBuzz" if n % 15 == 0
  return "Fizz" if n % 3 == 0
  return "Buzz" if n % 5 == 0
  return n.to_s
end

def run_fizzbuzz(count)
  (1..count).each do |i|
    puts fizzbuzz(i)
  end
end

# コマンドライン引数を処理
count = 100 # デフォルト値
if ARGV.length > 0
  begin
    count = Integer(ARGV[0])
    if count <= 0
      puts "Please provide a positive number of iterations"
      exit(1)
    end
  rescue ArgumentError
    puts "Please provide a valid number"
    exit(1)
  end
end

run_fizzbuzz(count)