#!/bin/bash
#
# Script: 02-create-db.sh
# Description: Creates a new MariaDB database and user for WordPress.
#              Grants all privileges to the user on the new DB.
# OS: CentOS 7 / RHEL 7
# Author: Furqan Imtiaz
# Usage: sudo ./02-create-db.sh
# Prerequisites:
#   - MariaDB service must be running.
#   - Run as root or with sudo access.
#   - Default root access to MySQL (`mysql -u root`) should be allowed.
#
# Actions Performed:
#   1. Prompts for database name, user, and password.
#   2. Executes SQL commands to create DB and user.
#   3. Grants privileges for WordPress access.

