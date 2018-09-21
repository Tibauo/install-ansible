#!/bin/bash
docker run test-ansible ansible all -m ping
retour=$?

if [ $retour == 0 ]; then
  echo "[SUCCESS]"
else
  echo "[FAILED]"
  exit $retour
fi
