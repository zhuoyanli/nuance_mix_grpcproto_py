#!/bin/bash
if [[ -z "$1" ]]; then
  WORKING_DIR="$PWD"
else
  WORKING_DIR="$1"
fi
echo "Using working dir to download Google API proto: ${WORKING_DIR}"
echo "Pulling Google api proto files"
mkdir -p "${WORKING_DIR}/google/api"
wget -O "${WORKING_DIR}/google/api/annotations.proto" https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto || \
    (echo Failed to download Google api proto files && exit 1)
#curl -s "https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto" --output "${WORKING_DIR}/google/api/annotations.proto"
wget -O "${WORKING_DIR}/google/api/http.proto" https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto || \
  (echo Failed to download Google api proto files && exit 1)
#curl -s "https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto" --output "${WORKING_DIR}/google/api/http.proto"
