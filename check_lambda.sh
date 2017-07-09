#!/usr/bin/env bash

set -e

# You need to add your profile credentials to ~/.aws/credentials:
# [YOUR_PROFILE_NAME]
# aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
# aws_access_key_id = YOUR_ACCESS_KEY_ID

PROFILE_NAME=$1
LAMBDA_FUNCTION_NAME="conciergeFunction"
SKILL_DIR=alexa_concierge

aws lambda get-function --function-name ${LAMBDA_FUNCTION_NAME} --profile ${PROFILE_NAME}
