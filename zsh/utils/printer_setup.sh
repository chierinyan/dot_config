#!/usr/bin/bash

user=
pass=
printer=hw312a
# name=HW312A-BW
# location=HW312
while getopts u:p:n:N:l flag; do
    case "${flag}" in
        u) user=${OPTARG};;
        p) pass=${OPTARG};;
        n) printer=${OPTARG};;
        N) name=${OPTARG};;
        l) location=${OPTARG};;
    esac
done

if [ -z "$printer" ] || [ -z "$user" ] || [ -z "$pass" ]; then
    >&2 echo 'Usage: printer_setup.sh -u <cs_account> -p <pwd> -n <printer> [-N <friendly_name>] [-l <location>]'
    exit 1
fi

if [ -z "$name" ]; then
    name="$printer"
fi

lpadmin -E \
    -p "$name" -L "$location" \
    -m drv:///sample.drv/generic.ppd \
    -o printer-is-shared=false -o PageSize=A4 -o Option1=True \
    -v ipps://${user}:${pass}@print-server.cs.hku.hk:631/printers/${printer} \
    -E
