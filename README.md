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

匯出BOX
```
vagrant package --base Centos9 --output centos9.box 
#將虛擬機(Centos9)匯出成BOX(centos9.box)
```

將BOX匯入vagrant box內
```
vagrant box add --name {your box name} {you box file} 
#vagrant box add --name centos9 centos9.box
```

Vagrantfile<a href="Vagrantfile">配置</a>
加入ssh帳號驗證
```
config.ssh.username = "vagrant"
config.ssh.password = "vagrant"
```
完整Vagrantfile
```
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos9"
  
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.30.75"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
```
