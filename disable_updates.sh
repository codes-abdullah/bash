#!/bin/bash


sudo systemctl disable --now unattended-upgrades
sudo geany /etc/apt/apt.conf.d/20auto-upgrades
sudo geany /etc/apt/apt.conf.d/50unattended-upgrades
sudo systemctl status unattended-upgrades
