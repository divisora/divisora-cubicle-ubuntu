#!/usr/bin/env bash

# Check if machine already have been joined into a domain
FILE=/etc/krb5.keytab
if [ -f "$FILE" ]; then
    echo "$FILE exists. Exiting"
    exit
fi

# TODO: Probably want a better/more secure way of checking if the machine is already joined. Maybe this is only for failsafe if systemd ran twice?

# Set some default values
# Having them on their own lines makes it esier to change them later with 'sed'
KEYTAB=/opt/keytabs/krb5.keytab
IPA_DOMAIN=domain.internal
IPA_SERVER="ipa.$IPA_DOMAIN"

# Join the machine into FreeIPA
# TODO: Fix NTP and home dir. Should be dynamic and not fixed
ipa-client-install --keytab $KEYTAB --server=$IPA_SERVER --domain=$IPA_DOMAIN --no-ntp --no-ssh --no-sshd --mkhomedir -U