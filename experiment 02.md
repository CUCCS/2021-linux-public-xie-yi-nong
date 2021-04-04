# 动手实战Systemd

## 实验环境

- Virtualbox

- Ubuntu 20.04 Server 64bit

- Windows10 -cmd

## 实验任务

1. 参照第2章作业的要求，完整实验操作过程通过asciinema进行录像并上传，文档通过github上传

2. 完成自查清单

## 实验步骤

### 一、学习Systemd

1. 3.1-3.6

[![asciicast](https://asciinema.org/a/ezHg1WFwvODKALTXjArjbyA3T.svg)](https://asciinema.org/a/ezHg1WFwvODKALTXjArjbyA3T)

2. 4.1-4.4

[![asciicast](https://asciinema.org/a/Ss7n3TqUOlyptjig4vI0qxg0C.svg)](https://asciinema.org/a/Ss7n3TqUOlyptjig4vI0qxg0C)

3. 5.1-5.4

[![asciicast](https://asciinema.org/a/XQwXdSvEWFZX6b95cP13JsAal.svg)](https://asciinema.org/a/XQwXdSvEWFZX6b95cP13JsAal)

4. 6.target

[![asciicast](https://asciinema.org/a/S5DB5tcDj05I0dI4bXQ2n9Omu.svg)](https://asciinema.org/a/S5DB5tcDj05I0dI4bXQ2n9Omu)

5. 7.日志管理

[![asciicast](https://asciinema.org/a/0iJ0zxYYMSkVWDIbq5p1lqt4W.svg)](https://asciinema.org/a/0iJ0zxYYMSkVWDIbq5p1lqt4W)

6. 实战篇

[![asciicast](https://asciinema.org/a/WZ4LfXQqlXZyDCF2k6YAFBGT8.svg)](https://asciinema.org/a/WZ4LfXQqlXZyDCF2k6YAFBGT8)

### 二、自查清单

1. 如何添加一个用户并使其具备sudo执行程序的权限？

```
sudo adduser user_name
username ALL=(ALL) ALL
```

2. 如何将一个用户添加到一个用户组？

```
usermod -a -G {{group1,group2}} {{user}}
```

3. 如何查看当前系统的分区表和文件系统详细信息？

```
sudo fdisk -l  
df -h
```

4. 如何实现开机自动挂载Virtualbox的共享目录分区？

```
sudo mount -t vboxsf [共享文件夹名称] /mnt/dirname
```

5. 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

```
lvextend --size {{120G}} {{logivcal_volume}}
lvextend --size +{{40G}} -r {{logical_volume}}
lvextend --size {{100%%FREE}} {{logical_volume}}

lvreduce --size {{120G}} {{logical_volume}}
lvreduce --size -{{40G}} -r {{logical_volume}}
```

6. 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

```
[Service]中修改：
ExecStartPost = <脚本位置>
ExecStopPost = <脚本位置>

sudo systemctl daemon-reload
sudo systemctl restart demo.service
```

7. 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？

```
[Service]中修改：
Restart=always

sudo systemctl daemon-reload
sudo systemctl restart demo.service
```

### 三、问题

- 在设置时区与系统时间时，要注意关闭计算机的自动校验时间功能

```
timedatectl set-ntp no
```

### 四、参考文献

[Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

[Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)