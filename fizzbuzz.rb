#!/usr/bin/env ruby

def fizzbuzz(n)
  if n % 15 == 0
    "FizzBuzz"
  elsif n % 3 == 0
    "Fizz"
  elsif n % 5 == 0
    "Buzz"
  else
    n.to_s
  end
end

if __FILE__ == $0
  # メインの実行部分
  (1..100).each do |i|
    puts fizzbuzz(i)
  end
end