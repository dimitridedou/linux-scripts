#!/bin/sh
clear
apt update -y
apt list --upgradable
apt upgrade -y
apt autoremove -y
clear
