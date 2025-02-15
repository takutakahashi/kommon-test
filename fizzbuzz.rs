fn fizzbuzz(n: i32) -> String {
    match (n % 3, n % 5) {
        (0, 0) => String::from("FizzBuzz"),
        (0, _) => String::from("Fizz"),
        (_, 0) => String::from("Buzz"),
        (_, _) => n.to_string(),
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        println!("Usage: {} <number>", args[0]);
        return;
    }

    let n: i32 = args[1].parse().unwrap_or_else(|_| {
        println!("Please provide a valid number");
        std::process::exit(1);
    });

    println!("{}", fizzbuzz(n));
}