#!/bin/bash

set -e

function check_requirements() {
  if [[ -z "$(command -v python)" ]]; then
    echo "Please install 'python' before running this script"
    exit 1
  elif [[ -z "$(command -v jupyter)" ]]; then
    echo "Please install 'jupyter' before running this script"
    exit 1
  elif [[ -z "$(command -v ipython)" ]]; then
    echo "Please install 'ipython' before running this script"
    exit 1
  fi
}

function main() {
  check_requirements

  [[ -z "$(command -v virtualenv)" ]] && \
    python -m pip install virtualenv

  test -d .venv || python -m venv .venv
  . .venv/bin/activate

  python -m pip install --upgrade pip

  python -m pip install build

  python -m pip install --no-cache -e '.[dev]'
  
  ipython kernel install --user --name=.venv
}

main
