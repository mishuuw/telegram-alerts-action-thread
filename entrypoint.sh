#!/bin/sh -l

token_id=$1
chat_id=$2
thread_id=$3
text=$4
parse_mode=$5
disable_web_page_preview=$6
disable_notification=$7

# Если текст содержит переносы строк, экранируем его через jq -Rs
json=$(jq -n \
  --arg chat_id "$chat_id" \
  --arg thread_id "$thread_id" \
  --arg text "$text" \
  --arg parse_mode "$parse_mode" \
  --argjson disable_web_page_preview "$disable_web_page_preview" \
  --argjson disable_notification "$disable_notification" \
  '{
    chat_id: $chat_id,
    message_thread_id: ($thread_id | tonumber?),
    text: $text,
    parse_mode: $parse_mode,
    disable_web_page_preview: $disable_web_page_preview,
    disable_notification: $disable_notification
  }')

echo "JSON payload:"
echo "$json"

# Отправка сообщения
response=$(curl -s -X POST "https://api.telegram.org/bot$token_id/sendMessage" \
  -H "Content-Type: application/json" \
  -d "$json")

echo "response=$response" >> $GITHUB_OUTPUT
