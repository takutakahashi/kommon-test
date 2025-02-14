package main

import "testing"

func TestFizzbuzz(t *testing.T) {
	tests := []struct {
		input    int
		expected string
	}{
		{1, "1"},
		{2, "2"},
		{3, "Fizz"},
		{4, "4"},
		{5, "Buzz"},
		{6, "Fizz"},
		{10, "Buzz"},
		{15, "FizzBuzz"},
		{30, "FizzBuzz"},
	}

	for _, test := range tests {
		result := Fizzbuzz(test.input)
		if result != test.expected {
			t.Errorf("Fizzbuzz(%d) = %s; want %s", test.input, result, test.expected)
		}
	}
}