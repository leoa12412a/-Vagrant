#install httpd -y;
sudo dnf install epel-release -y; 
sudo dnf install httpd -y; 
sudo systemctl start httpd; 
sudo systemctl enable httpd;

#install mysql
dnf install mysql mysql-server -y;
mysql --version;
systemctl start mysqld;
systemctl enable mysqld;

#install php
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y;
dnf install gcc kernel-devel kernel-headers make bzip2 perl -y;
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y;
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm -y;
dnf install php-fpm php php-bcmath php-cli php-common php-gd php-imap php-mbstring php-mcrypt php-mysql php-mysqlnd php-pdo php-soap php-tidy php-xml php-xmlrpc php-opcache php-redis php-pecl-mcrypt -y;
php -v;
systemctl restart php-fpm;
systemctl enable php-fpm;

#install git
dnf install git -y;
git --version;