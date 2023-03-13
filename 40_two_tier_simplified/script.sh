#!/bin/bash

# Install necessary packages
sudo amazon-linux-extras install nginx1.12 -y
sudo yum install -y php mysql php-mysql

# Start Nginx and set it to start on boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Create config file with DB credentials
cat <<EOF > /var/www/html/config.php
<?php
define('DB_HOST', '${rds_endpoint}');
define('DB_USER', '${db_username}');
define('DB_PASSWORD', '${db_password}');
define('DB_NAME', '${db_name}');
?>
EOF

# Create config file with Hello-world
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
    <head>
        <title>Example</title>
    </head>
    <body>
        <p>This is an example of a simple HTML page with one paragraph.</p>
    </body>
</html>
EOF

# Set permissions on the configuration file
sudo chown nginx:nginx /var/www/html/config.php
sudo chmod 640 /var/www/html/config.php

# Set permissions on the index_html file
sudo chown nginx:nginx /usr/share/nginx/html/index.html
sudo chmod 640 /usr/share/nginx/html/index.html

# Restart Nginx to apply the configuration
sudo systemctl restart nginx
