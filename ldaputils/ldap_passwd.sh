#!/bin/bash
#
# Description : Script to reset openldap user password
#
#

usage() { echo "Usage: $0  -u <user>  <password> " 1>&2; exit 1; }

while getopts "u:p:" o; do
    case "${o}" in
        u)
            UID_NUMBER=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${UID_NUMBER}" ]||[ -z "$1" ]; then
    usage
fi

PASS=$1

ldappasswd -v -Q -Y EXTERNAL -H ldapi:/// -s ${PASS}  "uid=${UID_NUMBER},ou=users,dc=nurlan,dc=az"

if [ $? -eq 0 ];then
echo "password is changed for : $UID_NUMBER"
else
echo "Cannot change password for $UID_NUMBER=$?"
exit 1
fi
