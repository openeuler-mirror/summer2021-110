# Summer2021-No.110 操作系统安全漏洞扫描与报警项目

#### 介绍

Euler Guardian: EulerOS 操作系统风险评估系统

https://gitee.com/openeuler-competition/summer-2021/issues/I3PRRT

#### 软件架构
软件架构说明

##### check current id

检查当前的UID是否为root, 兼容Solaris, SunOS和Linux(包括Euler)

##### path

检查SetUID, 若不正常，即退出。

检查当前工作目录，`WorkDir`

##### system info

检查系统信息。

检查内核信息并输出，包括内核版本, 编译使用的gcc版本，编译的时间和release信息。

##### user info

检查用户信息。

检查hostname和id, 检查口令是否以hash存储，检查上一次登录的用户。

##### file premission

检查目录下文件的权限。

##### 软件包版本漏洞检查

利用OVAL，根据软件包版本检查是否存在CVE漏洞。

##### Function 函数

调用函数。

##### MountOption 函数

检查fs的挂载选项。

/etc/fstab 的数据项：设备名称(实际设备名称或设备名称标签), 挂载点, 分区的类型(fs)，挂载选项, dump选项(0/1),fsck选项(0/1)

> 为了增加Linux系统安全性，建议将/tmp目录单独的挂载于一个独立的系统分区之上。但是仅仅挂载还不够，需要在挂载时为该分区指定nodev/nosuid/noexec选项，才能提高tmp文件目录的安全性。

`/tmp`挂载安全的选项参考: https://www.huaweicloud.com/articles/22202d2c18e5c9e28e2ee8374bc9b667.html

##### selinux检查

检查是否开启了SELinux

#### 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

#### 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
