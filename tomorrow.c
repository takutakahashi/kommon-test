#include <stdio.h>
#include <time.h>

int main() {
    // 現在の時間を取得
    time_t now = time(NULL);
    struct tm *today = localtime(&now);
    
    // 明日の日付を計算
    struct tm tomorrow = *today;
    tomorrow.tm_mday += 1;
    mktime(&tomorrow); // 日付の繰り上げを自動処理
    
    // 標準形式（YYYY-MM-DD）で出力
    char date_str[11];
    strftime(date_str, sizeof(date_str), "%Y-%m-%d", &tomorrow);
    
    // 日本語形式で出力
    printf("明日の日付は:\n");
    printf("%s\n", date_str);
    printf("%d年%d月%d日\n", 
           tomorrow.tm_year + 1900, 
           tomorrow.tm_mon + 1, 
           tomorrow.tm_mday);
    
    return 0;
}