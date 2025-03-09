#!/usr/bin/env ruby
require 'date'

# 明日の日付を取得する関数
def get_tomorrow_date
  tomorrow = Date.today + 1
  tomorrow.strftime('%Y-%m-%d')
end

# 日本語形式で明日の日付を取得する関数
def get_tomorrow_date_jp
  tomorrow = Date.today + 1
  "#{tomorrow.year}年#{tomorrow.month}月#{tomorrow.day}日"
end

# 明日の日付を表示
puts "明日の日付は:"
puts get_tomorrow_date
puts get_tomorrow_date_jp