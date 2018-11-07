#!/bin/bash

gist="https://gist.githubusercontent.com/marcelmokos/8cb21782167f66847eb739790f2f0a06/raw"

bash <(curl -s -H 'Cache-Control: no-cache' "$gist/eslint-config-with-prettier.sh") $1
