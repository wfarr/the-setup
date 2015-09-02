#!/bin/bash

args=""

while test $# -gt 0; do
  case $1 in
    "--dry"|"-d")
      args="-W ${args}"
      ;;
    "--verbose"|"-v")
      args="--log_level debug ${args}"
      ;;
    *)
      ;;
    esac

  shift
done

cd $HOME/src/the-setup
/opt/chefdk/bin/chef-solo -c solo.rb $args
