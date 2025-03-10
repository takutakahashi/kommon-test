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
    
    // コマンドライン引数がない場合は1から100までの数を出力
    if args.len() == 1 {
        for i in 1..=100 {
            println!("{}", fizzbuzz(i));
        }
        return;
    }
    
    // 引数があれば、それを使用
    if args.len() != 2 {
        println!("Usage: {} <number>", args[0]);
        return;
    }

    // 引数を数値に変換
    let n: i32 = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            println!("Please provide a valid number");
            std::process::exit(1);
        }
    };
    
    // 正の数値を確認
    if n <= 0 {
        println!("Please provide a positive number of iterations");
        std::process::exit(1);
    }
    
    // 1からnまで出力
    for i in 1..=n {
        println!("{}", fizzbuzz(i));
    }
}