#!/bin/sh -l

token_id=$1
chat_id=$2
thread_id=$3
text=$4
parse_mode=$5
disable_web_page_preview=$6
disable_notification=$7

response=`curl -X POST https://api.telegram.org/bot$token_id/sendMessage -H 'Content-Type: application/json' -d "{\"chat_id\": \"$chat_id\", \"text\": \"$text\", \"message_thread_id\": \"$thread_id\" \"parse_mode\": \"$parse_mode\", \"disable_web_page_preview\": \"$disable_web_page_preview\", \"disable_notification\": \"$disable_notification\"}"}`

echo "response=$response" >> $GITHUB_OUTPUT
