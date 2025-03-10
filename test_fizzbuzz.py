#!/usr/bin/env python3
"""
Unit tests for the Python FizzBuzz implementation.
"""
import unittest
from fizzbuzz import fizzbuzz


class TestFizzBuzz(unittest.TestCase):
    """Test cases for the fizzbuzz function."""
    
    def test_regular_numbers(self):
        """Test that regular numbers return as strings."""
        self.assertEqual(fizzbuzz(1), "1")
        self.assertEqual(fizzbuzz(2), "2")
        self.assertEqual(fizzbuzz(4), "4")
        self.assertEqual(fizzbuzz(7), "7")
        self.assertEqual(fizzbuzz(11), "11")
        
    def test_fizz_numbers(self):
        """Test that numbers divisible by 3 return 'Fizz'."""
        self.assertEqual(fizzbuzz(3), "Fizz")
        self.assertEqual(fizzbuzz(6), "Fizz")
        self.assertEqual(fizzbuzz(9), "Fizz")
        self.assertEqual(fizzbuzz(33), "Fizz")
        
    def test_buzz_numbers(self):
        """Test that numbers divisible by 5 return 'Buzz'."""
        self.assertEqual(fizzbuzz(5), "Buzz")
        self.assertEqual(fizzbuzz(10), "Buzz")
        self.assertEqual(fizzbuzz(20), "Buzz")
        self.assertEqual(fizzbuzz(25), "Buzz")
        
    def test_fizzbuzz_numbers(self):
        """Test that numbers divisible by both 3 and 5 return 'FizzBuzz'."""
        self.assertEqual(fizzbuzz(15), "FizzBuzz")
        self.assertEqual(fizzbuzz(30), "FizzBuzz")
        self.assertEqual(fizzbuzz(45), "FizzBuzz")
        self.assertEqual(fizzbuzz(60), "FizzBuzz")


if __name__ == "__main__":
    unittest.main()