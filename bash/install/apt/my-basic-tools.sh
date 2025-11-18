#!/bin/bash

set -e

echo -e "ΕΝΑΡΞΗ: Εγκατάσταση εργαλείων προγραμματισμού..."

if [ "$EUID" -ne 0 ]; then
  echo "Παρακαλώ τρέξε το script με sudo: sudo ./setup-dev.sh"
  exit 1
fi

echo -e "Ενημέρωση αποθετηρίων..."
apt update -y

# Λίστα με τα  πακέτα
packages=(
  net-tools libreoffice hunspell-el zsh
  curl flameshot ncat speedtest-cli )

echo -e "Εγκατάσταση πακέτων..."
for pkg in "${packages[@]}"; do
  echo -e "Εγκαθίσταται: $pkg"
  apt install -y "$pkg"
done
