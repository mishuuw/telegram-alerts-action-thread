#!/bin/sh -l

token_id=$1
chat_id=$2
thread_id=$3
text=$4
parse_mode=$5
disable_web_page_preview=$6
disable_notification=$7

payload=$(jq -Rn \
  --arg chat_id "$chat_id" \
  --arg thread_id "$thread_id" \
  --arg text "$text" \
  --arg parse_mode "$parse_mode" \
  --arg disable_web_page_preview "$disable_web_page_preview" \
  --arg disable_notification "$disable_notification" \
  '{
    chat_id: $chat_id,
    text: $text,
    message_thread_id: $thread_id,
    parse_mode: $parse_mode,
    disable_web_page_preview: ($disable_web_page_preview == "true"),
    disable_notification: ($disable_notification == "true")
  }'
)

response=$(curl -X POST \
  -H "Content-Type: application/json" \
  -d "$payload" \
  "https://api.telegram.org/bot$token_id/sendMessage")

echo "response=$response" >> $GITHUB_OUTPUT
