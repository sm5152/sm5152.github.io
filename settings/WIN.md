# Windows

## [php](https://windows.php.net/download)，[php-redis](https://pecl.php.net/package/redis)，[php-igbinary](https://pecl.php.net/package/igbinary)

```apacheconf
extension=php_igbinary.dll
extension=php_redis.dll
```

## 安装[openssl](https://slproweb.com/products/Win32OpenSSL.html)

### 安装后将 C:\Program Files\OpenSSL-Win64\bin 加入环境变量 Path，再生成自签名SSL证书

```shell
mkdir D:\app\nginx\ssl
cd D:\app\nginx\ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.pem -subj "/C=CN/ST=Fujian/L=Xiamen/O=Def/OU=Def/CN=Def"
```

## 安装[nssm](http://nssm.cc/download)

### 安装后的服务命令示例：nssm restart nginx

```
nssm install nginx "D:\app\nginx\nginx.exe"
nssm install phpcgi "D:\app\php83\php-cgi.exe" -b 127.0.0.1:9000
```

## 安装node.js，[nvm](https://github.com/coreybutler/nvm-windows/releases)

```shell
nvm install 20
nvm use 20
npm config set registry https://registry.npmmirror.com
npm install -g @vue/cli
npm install -g pnpm
npm install -g yarn
```

## [python镜像](https://developer.aliyun.com/mirror/pypi)

```shell
pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/
pip config set install.trusted-host mirrors.aliyun.com
```

## 操作系统其它配置

### 零副作用关闭自动更新

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings
新建32位DWORD
FlightSettingsMaxPauseDays
十进制777
```

### win11恢复经典右键

```text
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```

```text
HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID
{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
InprocServer32
双击右侧窗格中的默认条目，什么内容都不需要输入，按下回车键。
重启explorer
```

### 去除右键AMD

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions
Blocked
新建字符串值
{FDADFEE3-02D1-4E7C-A511-380F4C98D73B}
AMD Software : Adrenalin Edition
重启explorer
```
