#!/bin/bash

B="development"

if [ "$B" = "development" ];
then
  #for development
  echo "dev"

elif [ "$B" = "master" ];
then
  #for master
  echo "master"
else
  echo "other branch"
fi
