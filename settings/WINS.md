## 更改RDP端口

计算机\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
PortNumber

## 解决[挂载SMB错误1272](https://help.aliyun.com/zh/nas/user-guide/fix-mount-issues#section-ktz-20x-xj8)

```shell
New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters -Name AllowInsecureGuestAuth -PropertyType DWORD -Value 1
```

```textmate
net use z: \\307f44bdb7-rgk94.cn-shanghai.nas.aliyuncs.com\myshare
```

## 远程桌面服务安装

```text
服务器管理->(左边)仪表盘->(右边)添加角色和功能->下一步
->(左边)服务器角色->(右边末尾)远程桌面服务->(左边)角色服务->(右边第2个)远程桌面会话主机
```

## 远程桌面服务120天超期说明

```text
重启电脑后，等待右下角弹出期限提醒后，再删除以下注册表：
在到期前删除以下注册表项，重启服务器即可
运行 regedit
找到 HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod
删除右边类型为 REG_BINARY 的键值，可以每次重启服务器后操作一遍
第一次删除需要修改权限，GracePeriod右键->权限->高级->更改所有者，改为users，再修改权限，然后删除键值
```
