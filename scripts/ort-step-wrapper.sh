#!/bin/bash

# Wrapper for individual ORT bash scripts so we can capture
# status, start and end times and use them in metadata.json

STEP=$1
[[ -z "$STEP" ]] && { echo "STEP is not specified" ; exit 1; }
STEP_NAME_UPPERCASED=${STEP^^}

START_TIME=$(date +"%Y-%m-%dT%H:%M:%S%z")

$ORT_SCRIPTS_DIR/ort-${STEP}.sh
EXIT_CODE=$?

END_TIME=$(date +"%Y-%m-%dT%H:%M:%S%z")

case "$EXIT_CODE" in
    0 ) STATUS="success"
    ;;
    1 ) STATUS="failed"
    ;;
    * ) STATUS="unstable"
    ;;
esac


[[ $EXIT_CODE -eq 1 ]] && exit 1 || exit 0
