# WordPress Deployment on LAMP Stack (CentOS 7)

This project automates the deployment of a WordPress site on a CentOS 7-based LAMP stack (Linux, Apache, MariaDB, PHP). It includes scripts to install required packages, configure the web server, and set up the WordPress database.

## Directory Structure

```
wordpress-lamp-setup/
│
├── scripts/
│   ├── 01-install-lamp-php-modules.sh   # Installs Apache, MariaDB, PHP 8.3
│   └── 02-create-db.sh                  # Creates WordPress database and user
│
└── README.md                            # Documentation
```

## Prerequisites

- CentOS 7 system with sudo/root privileges
- Internet access to download packages and WordPress
- SELinux disabled or properly configured for web hosting

## Setup Instructions

### 1. Install Apache, MariaDB, and PHP 8.3

Run the following script to install LAMP stack components and set up the web server:

```bash
cd scripts/
chmod +x 01-install-lamp-php-modules.sh
./01-install-lamp-php-modules.sh
```

This will:
- Install Apache, MariaDB, PHP 8.3 and essential PHP modules
- Enable the Remi repo for PHP 8.3
- Download and extract WordPress
- Set correct permissions for Apache

### 2. Create WordPress Database and User

Run the DB creation script and enter your custom values:

```bash
chmod +x 02-create-db.sh
./02-create-db.sh
```

Prompts:
- Database name
- Username
- Password

## Apache Configuration

Ensure `/etc/httpd/conf/httpd.conf` contains the following:

```apache
<Directory "/var/www/html">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```

Then restart Apache:

```bash
sudo systemctl restart httpd
```

## WordPress Admin Access

This setup uses the WPS Hide Login plugin. After setup, the default login path `/wp-login.php` is replaced with:

```
http://<your-server-ip>/securelogin
```

Use this path to access the WordPress admin dashboard.

## Script Details

### scripts/01-install-lamp-php-modules.sh

```bash
#!/bin/bash

# Enable Remi repo for PHP 8.3
yum install epel-release -y
yum install -y yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php83

# Install Apache, MariaDB, PHP 8.3
yum install -y httpd mariadb-server php php-mysqlnd php-fpm php-xml php-mbstring php-gd php-curl

# Start and enable services
systemctl enable --now httpd mariadb

# Download and set up WordPress
cd /var/www/
mkdir -p html
cd html
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz --strip-components=1
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
```

### scripts/02-create-db.sh

```bash
#!/bin/bash

read -p "Enter WordPress DB Name: " dbname
read -p "Enter WordPress DB User: " dbuser
read -s -p "Enter WordPress DB Password: " dbpass
echo ""

mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE $dbname;
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';
GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "Database '$dbname' and user '$dbuser' created successfully."
```

## Final Steps

- Visit `http://<server-ip>/` to begin WordPress setup
- Use the DB credentials you created
- Admin login URL: `http://<server-ip>/securelogin`

## Security Tips

- Keep your system and WordPress updated
- Use strong DB/user credentials
- Regularly backup `/var/www/html` and MariaDB
- Configure firewall (e.g., firewalld or ufw) to limit access

## Furqan Imtiaz
