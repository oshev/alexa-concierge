#!/usr/bin/env bash

set -e

# You need to add your profile credentials to ~/.aws/credentials:
# [YOUR_PROFILE_NAME]
# aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
# aws_access_key_id = YOUR_ACCESS_KEY_ID

LAMBDA_PROJECT_HOME="$(pwd)"
PROFILE_NAME=$1
LAMBDA_FUNCTION_NAME="conciergeFunction"
SKILL_DIR="alexa_concierge"
PIP_ENV_DIR_NAME="env"

# TODO: check if the function isn't created, then create it

chmod u=rwx,go=r ${SKILL_DIR}/*.py

echo "Cleaning up dist dir ..."
rm -rf dist/*

echo "Adding source files ..."
cp -rf ${SKILL_DIR} dist

echo "Adding pip libs ..."
env_path=${LAMBDA_PROJECT_HOME}/${PIP_ENV_DIR_NAME}
cp -rf ${env_path}/lib/python3.6/site-packages/* dist

echo "Create deployment package ..."
cd dist
zip -q -r ${LAMBDA_FUNCTION_NAME} .

mv ${LAMBDA_FUNCTION_NAME}.zip ${LAMBDA_PROJECT_HOME}/

cd -

ls -hola ${LAMBDA_FUNCTION_NAME}.zip

echo "Upload lambda content ..."
aws lambda update-function-code --function-name ${LAMBDA_FUNCTION_NAME} \
    --zip-file fileb://${LAMBDA_FUNCTION_NAME}.zip --profile ${PROFILE_NAME} --publish

rm ${LAMBDA_FUNCTION_NAME}.zip