# Summer2021-No.110 操作系统安全漏洞扫描与报警项目

## 介绍

Euler Guardian: EulerOS 操作系统风险评估系统

https://gitee.com/openeuler-competition/summer-2021/issues/I3PRRT

## 模块说明

### local scan 本地扫描模块

#### check current id

检查当前的UID是否为root, 兼容Solaris, SunOS和Linux(包括Euler)

#### path

检查SetUID, 若不正常，即退出。

检查当前工作目录，`WorkDir`

#### system info

检查系统信息。

检查内核信息并输出，包括内核版本, 编译使用的gcc版本，编译的时间和release信息。

#### Security policy check

检查是否开启了SELinux, 检查资源的限制情况。

#### user info

检查用户信息。

检查hostname和id, 检查口令是否以hash存储，检查上一次登录的用户。

#### file premission

检查无属组的777权限文件。

检查指定目录下文件的权限, 默认rwxrwxrwx权限。

文件权限的检查和用户的需求有很大关系。

#### 软件包版本漏洞检查

利用OVAL，根据软件包版本检查是否存在CVE漏洞。

#### Function 函数

调用函数。

#### selinux检查

检查是否开启了SELinux

### ER emergency response 应急响应模块

详见代码注释

#### 基本检查

`/tmp`下文件 `init.d`下services, `$PATH`

#### 文件检查

输入文件类型、指定目录，检查该目录下24h改变过的/有777权限的该类型文件

输入时间、指定目录，检查该目录下该时间改变过的文件

#### 进程检查

网络连接命令检查可疑PID

输入PID, 查看详情

检查隐藏的process

#### history和log检查

检查命令记录中的wget ssh scp tar zip, 匹配ssh中IP

检查有root权限/能登录的users, 列出所有用户最后一次登录，列出用户登录情况

#### webshell检查

基于文件的webshell检查, 支持php asp jsp

## 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

## 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

## 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request
