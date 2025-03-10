#!/usr/bin/env python3
"""
FizzBuzz implementation in Python with command-line interface.
"""
import argparse
import sys


def fizzbuzz(n):
    """
    Return the FizzBuzz value for a given number.
    
    Args:
        n: The number to evaluate
        
    Returns:
        str: "FizzBuzz" if n is divisible by both 3 and 5,
             "Fizz" if n is divisible by 3,
             "Buzz" if n is divisible by 5,
             or the string representation of n otherwise.
    """
    if n % 15 == 0:
        return "FizzBuzz"
    elif n % 3 == 0:
        return "Fizz"
    elif n % 5 == 0:
        return "Buzz"
    else:
        return str(n)


def main():
    """
    Main function to process command-line arguments and run FizzBuzz.
    """
    parser = argparse.ArgumentParser(description="FizzBuzz implementation in Python")
    parser.add_argument("count", nargs="?", type=int, default=100, 
                        help="Number of iterations (default: 100)")
    args = parser.parse_args()
    
    # Handle negative or zero values
    if args.count <= 0:
        print("Please provide a positive number of iterations")
        sys.exit(1)
    
    # Print FizzBuzz sequence
    for i in range(1, args.count + 1):
        print(fizzbuzz(i))


if __name__ == "__main__":
    main()