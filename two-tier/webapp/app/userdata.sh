#!/bin/bash
              sudo dnf install httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json wget -y
              sudo systemctl enable httpd
              sudo systemctl start httpd
              sudo wget -P /tmp "https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz"
              sudo tar -xzf /tmp/mediawiki-1.34.2.tar.gz -C /var/www/html/
              sudo ln -s /var/www/html/mediawiki-1.34.2/ /var/www/html/mediawiki
              sudo chown -R apache:apache /var/www/html/mediawiki-1.34.2 
              sudo chown -R apache:apache /var/www/html/mediawiki
              sudo systemctl restart httpd
              sudo setsebool -P httpd_can_network_connect 1
