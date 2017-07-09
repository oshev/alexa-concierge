#!/usr/bin/env bash

set -e

SKILL_DIR=alexa_concierge

if [ ! -d env ]; then
    virtualenv -p /usr/local/bin/python3.6 env
else
    echo "Virtual environment already exists."
fi

source env/bin/activate

pip install -r requirements.txt

