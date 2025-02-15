#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative './fizzbuzz'

class TestFizzbuzz < Minitest::Test
  def test_normal_numbers
    assert_equal "1", fizzbuzz(1)
    assert_equal "2", fizzbuzz(2)
    assert_equal "4", fizzbuzz(4)
  end

  def test_fizz
    assert_equal "Fizz", fizzbuzz(3)
    assert_equal "Fizz", fizzbuzz(6)
    assert_equal "Fizz", fizzbuzz(9)
  end

  def test_buzz
    assert_equal "Buzz", fizzbuzz(5)
    assert_equal "Buzz", fizzbuzz(10)
    assert_equal "Buzz", fizzbuzz(20)
  end

  def test_fizzbuzz
    assert_equal "FizzBuzz", fizzbuzz(15)
    assert_equal "FizzBuzz", fizzbuzz(30)
    assert_equal "FizzBuzz", fizzbuzz(45)
  end
end