#!/bin/bash

if [ "$PROJECT" = "" ]; then
    PROJECT=emulator
fi

ARGS=(--project=$PROJECT)
if [ "$DATASET" != "" ]; then
    ARGS+=(--dataset=$DATASET)
fi
if [ "$DATABASE" != "" ]; then
    ARGS+=(--database=$DATABASE)
fi
if [ "$DATA_FROM_YAML" != "" ]; then
    ARGS+=(--data-from-yaml=$DATA_FROM_YAML)
fi

exec /bin/bigquery-emulator "${ARGS[@]}"
