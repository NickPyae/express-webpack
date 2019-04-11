#!/bin/bash

# Copy a .env.${NODE_ENV} file (ex: .env.production) as a .env file in the root folder.
# if NODE_END is not set, will use 'development' as default

set -e # Exit with nonzero exit code if anything fails

ENV=development
SOURCE_PREFIX="${PWD}/ops/env/.env."
TARGET="${PWD}/.env"

echo "== Start .env copy =="

# Setting ENV
if [ -z "${NODE_ENV}" ]
then
    echo "NODE_ENV environment variable is not set. Will default ENV to $ENV"
else
    ENV=${NODE_ENV}
    echo "ENV is set to NODE_ENV value '${NODE_ENV}'"
fi

ENV_FILE=$SOURCE_PREFIX$ENV


# Checking if env file exist
if [ ! -f $ENV_FILE ]; then
    echo "Expected env file '$ENV_FILE' not found. Stopping script."
    exit 1
fi

echo "Copying $ENV_FILE to $TARGET..."
cp $ENV_FILE $TARGET