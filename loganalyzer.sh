#!/usr/bin/env bash
#
# Log Analyzer - Bash script for Apache/Nginx access logs
# Usage: ./loganalyzer.sh /path/to/access.log
#

# Config
LOGFILE="$1"

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# Check Input
if [[ -z "$LOGFILE" || ! -f "$LOGFILE" ]]; then
  echo "Usage: $0 /path/to/access.log"
  exit 1
fi

# Helpers 
header() {
  echo -e "\n${BOLD}${BLUE}=== $1 ===${RESET}\n"
}

bar_chart() {
  local count=$1
  local label=$2
  local bars=$(( count / 10 )) 
  local graph=""
  for ((i=0; i<bars; i++)); do graph+="#"; done
  echo -e "${YELLOW}${label}${RESET}: ${graph} ($count)"
}

#Stats
total_requests() {
  header "Total Requests"
  echo "$(wc -l < "$LOGFILE")"
}

unique_ips() {
  header "Unique Visitors (IPs)"
  awk '{print $1}' "$LOGFILE" | sort -u | wc -l
}

top_ips() {
  header "Top 10 IPs"
  awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -10 |
  while read count ip; do bar_chart "$count" "$ip"; done
}

top_urls() {
  header "Top 10 Requested URLs"
  awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -10 |
  while read count url; do bar_chart "$count" "$url"; done
}

status_codes() {
  header "Status Code Distribution"
  awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr |
  while read count code; do bar_chart "$count" "$code"; done
}

errors_404() {
  header "Top 10 404 Errors"
  awk '$9 ~ /404/ {print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -10 |
  while read count url; do bar_chart "$count" "$url"; done
}

requests_per_hour() {
  header "Requests Per Hour"
  awk -F: '{print $2":00"}' "$LOGFILE" | sort | uniq -c |
  while read count hour; do bar_chart "$count" "$hour"; done
}

user_agents() {
  header "Top 5 User Agents"
  awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 |
  while read count agent; do bar_chart "$count" "$agent"; done
}

# Menu 
while true; do
  echo -e "\n${BOLD}Log Analyzer Menu${RESET}"
  echo "1) Total requests"
  echo "2) Unique IPs"
  echo "3) Top IPs"
  echo "4) Top URLs"
  echo "5) Status codes"
  echo "6) 404 errors"
  echo "7) Requests per hour"
  echo "8) User agents"
  echo "q) Quit"
  read -p "Choose an option: " choice
  case $choice in
    1) total_requests ;;
    2) unique_ips ;;
    3) top_ips ;;
    4) top_urls ;;
    5) status_codes ;;
    6) errors_404 ;;
    7) requests_per_hour ;;
    8) user_agents ;;
    q|Q) echo "Goodbye!"; exit ;;
    *) echo "Invalid choice." ;;
  esac
done

