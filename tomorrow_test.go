package main

import (
	"testing"
	"time"
)

func TestGetTomorrowDate(t *testing.T) {
	// 明日の日付をtime.Time型で取得
	expectedTomorrow := time.Now().AddDate(0, 0, 1)
	expectedFormat := expectedTomorrow.Format("2006-01-02")
	
	// 関数から取得した明日の日付
	result := GetTomorrowDate()
	
	if result != expectedFormat {
		t.Errorf("GetTomorrowDate() = %s; want %s", result, expectedFormat)
	}
}