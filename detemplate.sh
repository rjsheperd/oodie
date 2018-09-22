#!/bin/bash
set -e

self="$(basename "$0")"
template="Dockerfile.template"

# detemplate.sh
usage() {
  cat <<EOUSAGE

Usage: $self [machine]
   ie: $self raspberrypi3

Generates Machine-specific Dockerfiles from Dockerfile.template

Machines supported: raspberrypi3, beaglebone.

EOUSAGE
}

detemplate() {
  machine=$1
  sed -e s/%%RESIN_MACHINE_NAME%%/$machine/g \
    $template > Dockerfile.$machine
}

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    usage
    exit 1
fi

if [ ! -f $template ]; then
    echo "Dockerfile.template not found"
    usage
    exit 1
fi

for arg in "$@"; do
  case $arg in
    'raspberrypi3')
      detemplate $arg
      ;;
    *)
      {
        echo "error: unknown argument: $arg"
        usage
      } >&2
      exit 1
      ;;
  esac
done


