#!/usr/bin/env bash

# Creating the perfect GPG keypair.
# Original: https://alexcabal.com/creating-the-perfect-gpg-keypair/

KEY=xyz
DATE=$(date +"%Y%m%d")
SCRIPT_BASEDIR=$(dirname "$0")


cd "${SCRIPT_BASEDIR}"
echo "This script is not for use in automation"; echo "Use it step by step"; exit 1

# Generate
gpg --gen-key
# (1) RSA and RSA (default)
# 0 = key does not expire

# Strengthening Hash Preferences
gpg --edit-key $KEY
# setpref SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
# save

# Add subkey
gpg --edit-key $KEY
# addkey
# (4) RSA (sign only)
# 0 = key does not expire
# save

# Export Public Key
gpg -a -o ${KEY}_${DATE}.public.asc --export $KEY

# Export Private Key
gpg -a -o ${KEY}_${DATE}.private.asc --export-secret-keys $KEY

# Creating Revocation Certificate
gpg -a -o ${KEY}_${DATE}.revoccert.asc --gen-revoke $KEY

# Integrity check
shasum -a 256 -b ${KEY}_${DATE}.public.asc ${KEY}_${DATE}.private.asc ${KEY}_${DATE}.revoccert.asc > ${KEY}_${DATE}.sha256sum

# Transforming your Master Key Pair into your laptop
# Import all keys into your laptop

# Export all of the subkeys
gpg -a -o ${KEY}_${DATE}.subkeys.asc --export-secret-subkeys $KEY

# Delete the original signing subkey
gpg --delete-secret-key $KEY

# Import only the subkeys
gpg --import ${KEY}_${DATE}.subkeys.asc
rm ${KEY}_${DATE}.subkeys.asc

# Symetric
#gpg --no-tty --batch --passphrase supersecret --cipher-algo AES256 -c file.txt
#gpg --no-tty --batch --passphrase supersecret -d -o file.txt file.txt.gpg
