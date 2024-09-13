#!/bin/bash

# Variables
COMMAND="vendor/bin/sail test"
TARGET_EXIT_CODE=1
TARGET_MESSAGE="The process has been signaled with signal \"11\"."
COUNT_TOTAL=100  # Number of times to run the command

COUNT_TARGET_EXIT_CODE=0
COUNT_TARGET_MESSAGE=0

for ((i=1; i<=COUNT_TOTAL; i++)); do
  OUTPUT=$($COMMAND 2>&1)  # Execute command and capture both stdout and stderr
  EXIT_CODE=$?

  # Check for target exit code
  if [[ $EXIT_CODE -eq $TARGET_EXIT_CODE ]]; then
    ((COUNT_TARGET_EXIT_CODE++))
  fi

  # Check for target message in output
  if [[ "$OUTPUT" == *"$TARGET_MESSAGE"* ]]; then
    ((COUNT_TARGET_MESSAGE++))
  fi

done

# Results
echo "Total Runs: $COUNT_TOTAL"
echo "Target Exit Code ($TARGET_EXIT_CODE) Occurrences: $COUNT_TARGET_EXIT_CODE"
echo "Target Message ('$TARGET_MESSAGE') Occurrences: $COUNT_TARGET_MESSAGE"
