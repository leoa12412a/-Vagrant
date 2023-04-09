# 打包屬於自己的Vagrant

以下範例為打包centos stream 9 (包含LAMP PHP8)

## Virtualbox設定

第一個網路配置必須為NAT(參考<a href="https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/boxes">官網</a>)
![image](https://github.com/leoa12412a/PackVagrant/blob/main/1.PNG)</br></br>
第二個網路必須是僅限主機介面卡，這樣才可以橋接上電腦的網路進行連線
![image](https://github.com/leoa12412a/PackVagrant/blob/main/2.PNG)</br></br>
安裝方式可以選最小的
![image](https://github.com/leoa12412a/PackVagrant/blob/main/3.PNG)</br></br>
![image](https://github.com/leoa12412a/PackVagrant/blob/main/4.PNG)</br></br>
使用者需要建立一個帳號密碼都為vagrant的使用者
![image](https://github.com/leoa12412a/PackVagrant/blob/main/5.PNG)</br></br>
必須安裝VirtualBox Guest Additions才能共享資料夾等等功能(參考<a href="https://www.tonystechanditblog.com/2021/04/virtualbox-guest-additions-centos.html">網站</a>)
```
dnf update
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
#dnf install gcc kernel-devel kernel-headers make bzip2 perl
```
接下來安裝PHP8，可以參考<a href="https://www.ggdoc.cn/archives/302">這裡</a>

先安裝remi源
```
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
```

查看可以安裝的PHP版本
```
dnf module list php
```
![image](https://github.com/leoa12412a/PackVagrant/blob/main/6.PNG)</br></br>
啟用PHP8.2版本
```
dnf module enable php:remi-8.2
```

安裝PHP和常用的套件
```
dnf install php-fpm php php-bcmath php-cli php-common php-gd php-imap php-mbstring php-mcrypt php-mysql php-mysqlnd php-pdo php-soap php-tidy php-xml php-xmlrpc php-opcache php-redis php-pecl-mcrypt -y
```

查看PHP版本和確認是否安裝成功
```
php -v
```
![image](https://github.com/leoa12412a/PackVagrant/blob/main/7.PNG)</br></br>

重啟PHP
```
systemctl restart php-fpm
```
設置PHP開機自啟
```
systemctl enable php-fpm
```
