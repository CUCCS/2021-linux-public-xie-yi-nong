# **Focal Fossa无人值守安装iso制作过程示例**

## **手动安装Ubuntu 20.04**

+ 提前下载好纯净版Ubuntu安装镜像iso文件（ubuntu-20.04.2-live-server-amd64.iso）

![提前下载好的ubuntu镜像](./pictures/01.png)

+ 校验下载好的文件，并与官网镜像文件的校验值进行比对

+ 右键官网下载链接中的SHA256SUMS，在新页面中打开链接；

+ 启动Win10自带的PowerShell，输入“*Get-FileHash "D:\linux\ubuntu-20.04.2-live-server-amd64.iso" | Format-List*”，即“*Get-FileHash 文件路径 | Format-List*”格式

+ 比对两者

![镜像校验无误](./pictures/02.png)

+ 开始手动安装Ubuntu

![开始手动安装](./pictures/03.png)

+ 修改动态分配的内存大小

![修改动态分配内存](./pictures/04.png)

+ 修改网络设置，启用 Host-only 网卡

![修改网络设置](./pictures/05.png)

+ 修改存储设置，添加之前下载好的镜像

![添加镜像](./pictures/06.png)

+ 启动

![启动](./pictures/07.png)

+ 定制普通用户名和默认密码

![定制普通用户名和默认密码](./pictures/08.png)

+ 定制安装OpenSSH Sever

![定制安装OpenSSH Sever](./pictures/09.png)

+ 完成手动安装

![完成手动安装](./pictures/10.png)

---

## **制作iso镜像文件**

+ 主机链接手动安装的那台虚拟机 *ssh xyn@192.168.56.106*

![链接虚拟机](./pictures/iso01.png)

+ 获取文件 *cat /var/log/installer/autoinstall-user-data*

+ 修改autoinstall-user-data

![修改文件](./pictures/iso02.png)

+ 新建空白文件meta-data，将获取并修改后的autoinstall-user-data重命名为user-data，与meta-data一起导入虚拟机

![将user-data和meta-data导入虚拟机](./pictures/iso03.png)

+ 新建network-config文件，文件内容如图；并将该文件导入虚拟机

![network-config文件具体内容](./pictures/iso04.png)

![将network-config导入虚拟机](./pictures/iso05.png)

+ 重新链接虚拟机，执行图示操作

![step01](./pictures/iso06.png)

![step02](./pictures/iso07.png)

![step03](./pictures/iso08.png)

+ 将制作好的init.iso导出到主机（查找主机ip地址的命令行如图）

![查找主机ip地址](./pictures/iso09.png)

![导出init.iso文件](./pictures/iso10.png)

---

## **无人值守安装**

+ 开始无人值守安装Ubuntu

![开始无人值守安装](./pictures/11.png)

+ 修改动态分配内存大小

![修改动态内存大小](./pictures/12.png)

+ 修改存储设置移除当前的控制器

![移除IDE](./pictures/13.png)

+ 先挂载纯净版Ubuntu安装镜像iso文件

![挂载Ubuntu镜像文件](./pictures/14.png)

+ 再挂载制作好的光盘镜像 init.iso

![挂载init镜像文件](./pictures/15.png)

+ 修改网络设置

![修改网络设置](./pictures/16.png)

+ 启动进行安装，需要输入一次yes

![输入yes](./pictures/17.png)

+ 完成安装！

![Complete!](./pictures/18.png)

---

## **遇到的问题**

+ 无法将user-data和meta-data和network-config导入进虚拟机；也无法将init.iso导出虚拟机

#### 解决方式：查阅网络，通过scp方式在虚拟机和主机之间传输文件，具体方式如图所示

![第一个问题](./pictures/ques01.png)

---

## **实验问题**

1、 如何配置无人值守安装iso并在Virtualbox中完成自动化安装？

+ 解决方式：先进行手动安装，获取手动安装产生的系统文件autoinstall-user-data，稍加修改用于制作无人值守安装的iso镜像，该镜像中包含手动安装过程中选择的各项信息

2、 Virtualbox安装完Ubuntu之后新添加的网卡如何实现系统开机自动启用和自动获取IP？

+ 解决方法：修改00-installer-config.yaml文件，如下图所示

![第二个问题](./pictures/ques02.png)

3、 如何使用sftp在虚拟机和宿主机之间传输文件？

+ 解决方式：通过sftp guestname@guest_ip 链接虚拟机，再分别通过get、put命令从虚拟机获取文件、传送文件到虚拟机（以下图为例）

![第三个问题](./pictures/ques03.png)