#!/bin/bash

# Usage: git-commit-messages <commit_range>
# Example: git-commit-messages origin/stage...@

COMMIT_RANGE=$1

if [[ -z "$COMMIT_RANGE" ]]; then
  echo "Usage: `basename "$0"` <commit_range>"
  exit 1
fi

# Use a unique delimiter to separate commits
DELIM="__COMMIT_DELIMITER__"

git log "$COMMIT_RANGE" --reverse --pretty=format:"$DELIM%n%s%n%b" |
awk -v delim="$DELIM" '
  $0 == delim {
    in_commit = 1
    printed_header = 0
    next
  }

  in_commit {
    if (!printed_header) {
      print "- " $0
      printed_header = 1
    } else if ($0 != "") {
      print "  " $0
    }
  }
'

