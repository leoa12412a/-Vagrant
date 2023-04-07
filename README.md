# 打包屬於自己的Vagrant

以下範例為打包centos stream 9

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
