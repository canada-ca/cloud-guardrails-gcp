#!/bin/bash

if test -f "report.txt"; then
    rm report.txt
fi
# Process file and run output through conftest
# This is necesary due to gcloud asset export outputting each asset as a json object and not as a list
for file in ./cai-dir/*.json; do
    echo $file >> report.txt
    cat $file | tr '\n' ',' | sed  '1s;^;[\n;' - | sed '$ a ]'  | conftest test -p guardrails - >> report.txt
    printf "\n" >> report.txt
done

