#!/bin/bash

set -e

echo -e "ΕΝΑΡΞΗ: Εγκατάσταση εργαλείων προγραμματισμού..."

if [ "$EUID" -ne 0 ]; then
  echo "Παρακαλώ τρέξε το script με sudo: sudo ./setup-dev.sh"
  exit 1
fi

echo -e "Ενημέρωση αποθετηρίων..."
apt update -y

# Λίστα με τα πακέτα προς εγκατάσταση
packages=(
  python3
  python3-pip
  python3-venv
  g++
  gcc
  build-essential
  nodejs
  npm
  php
  libapache2-mod-php
  php-mysql
  apache2
  default-jdk
  nodejs
  mysql-server
)

echo -e "Εγκατάσταση πακέτων..."
for pkg in "${packages[@]}"; do
  echo -e "================================================"
  echo -e "Εγκαθίσταται: $pkg"
  DEBIAN_FRONTEND=noninteractive apt install -y "$pkg"
done

echo -e "Τέλος! Όλα τα πακέτα εγκαταστάθηκαν με επιτυχία."
