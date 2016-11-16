#!/bin/bash
set -e

NAME=${@:$#} # last parameter 
ASPELL_ARGS=${*%${!#}} # all parameters except the last

output=$(aspell list ${ASPELL_ARGS} < ${NAME})
error_count=$(wc -w <<< "$output")
echo "$error_count errors:"
echo -e "$output"

if [[ $error_count -ne 0 ]]
then
    exit 1
fi