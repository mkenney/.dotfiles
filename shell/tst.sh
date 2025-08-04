#!/usr/bin/env bash

source ~/repos/src/github.com/mkenney/git-status/git-status.sh
status=$(__git_status)
exit_code=$?

echo "status:    '$status'"
echo "exit_code: '$exit_code'"

exit $exit_code
