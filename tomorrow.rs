fn main() {
    // 日付を表示
    println!("明日の日付は:");
    
    // シェルコマンドを実行して明日の日付を取得
    if let Ok(output) = std::process::Command::new("date")
        .args(&["-d", "tomorrow", "+%Y-%m-%d"])
        .output() {
        
        if let Ok(date) = String::from_utf8(output.stdout) {
            println!("{}", date.trim());
            
            // 年月日に分解する
            let parts: Vec<&str> = date.trim().split('-').collect();
            
            if parts.len() == 3 {
                println!("{}年{}月{}日", parts[0], parts[1], parts[2]);
            }
        }
    } else {
        println!("明日の日付を取得できませんでした。");
    }
}