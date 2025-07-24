#!/bin/bash
#
# Script: 01-install-lamp-php-modules.sh
# Description: Installs and configures Apache, MariaDB, and PHP 8.3 with required modules.
#              Also downloads and sets up the latest WordPress files in /var/www/html.
# OS: CentOS 7 / RHEL 7
# Author: Furqan Imtiaz
# Usage: sudo ./01-install-lamp-php-modules.sh
# Prerequisites:
#   - Run as root or with sudo privileges.
#   - Ensure internet access to download repos and WordPress.
#
# Actions Performed:
#   1. Enables EPEL and Remi repos.
#   2. Installs Apache, MariaDB, PHP 8.3, and related extensions.
#   3. Starts and enables httpd and mariadb services.
#   4. Downloads WordPress and places it in /var/www/html.
#   5. Sets appropriate permissions.

