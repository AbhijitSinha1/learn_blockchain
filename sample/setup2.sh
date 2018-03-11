#! /bin/bash

echo "1/2 Attaching geth"

echo -n "geth.ipc location: "
read -a path

echo "NOTE: Make sure to unlock the account once inside the get console"
echo "personal.unlockAccount('account', 'password', 0)"

geth attach "ipc:/$path"

