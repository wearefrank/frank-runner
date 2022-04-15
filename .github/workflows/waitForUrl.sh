#!/bin/bash

url=$1
numTries=$2
triesSoFar=0
result=1000
while [[ ${triesSoFar} -le ${numTries} ]]; do
  let triesSoFar++
  curl -s ${url}
  result=$?
  if [[ ${result} -eq 0 ]]; then
    break
  else
    sleep 1
  fi
done
# We want to see the output of this command only once
curl ${url}
result=$?
echo "Curl return code: ${result}"
exit ${result}
