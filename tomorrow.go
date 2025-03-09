package main

import (
	"fmt"
	"time"
)

// GetTomorrowDate 明日の日付を YYYY-MM-DD 形式で返す
func GetTomorrowDate() string {
	tomorrow := time.Now().AddDate(0, 0, 1)
	return tomorrow.Format("2006-01-02")
}

// GetTomorrowDateJP 明日の日付を日本語形式（YYYY年MM月DD日）で返す
func GetTomorrowDateJP() string {
	tomorrow := time.Now().AddDate(0, 0, 1)
	return fmt.Sprintf("%d年%d月%d日", 
		tomorrow.Year(), 
		tomorrow.Month(), 
		tomorrow.Day())
}

func main() {
	fmt.Println("明日の日付は:")
	fmt.Println(GetTomorrowDate())
	fmt.Println(GetTomorrowDateJP())
}