# macOS

## 访达>显示>显示路径栏，隐藏文件

```shell
defaults write com.apple.finder AppleShowAllFiles -bool TRUE
killall Finder
```

## 禁止记录终端历史

```shell
chmod 444 ~/.zsh_history
```

## 打开任何来源选项

```shell
sudo spctl --master-disable
```

## 修改系统设置

* 节能-防止睡眠
* 锁定屏幕-需要密码-立即

## [关闭输入法图标](https://discussions.apple.com/thread/255159504?answerId=259892957022)

```shell
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO
```

## [阻止网络设备创建.DS_Store](https://support.apple.com/zh-cn/102064)

```shell
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
```

## 安装 command line developer tools

```shell
git
```

## [安装homebrew](https://brew.sh/zh-cn/)，[下载安装包](https://github.com/Homebrew/brew/releases/)

### 装好后，设置环境变量

```shell
echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

### 可选，[使用aliyun镜像](https://developer.aliyun.com/mirror/homebrew)

```shell
echo 'export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"' >> ~/.zshrc
echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"' >> ~/.zshrc
echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"' >> ~/.zshrc
echo 'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"' >> ~/.zshrc
source ~/.zshrc
brew update
```

## 通过brew安装应用

```shell
brew install php@8.3 nginx redis mysql@8.0
echo 'export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"' >> ~/.zshrc
echo 'export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 启用服务

```shell
brew services start php@8.3
brew services start nginx
brew services start redis
brew services start mysql@8.0
brew services list
```

#### 创建自签名证书

```shell
mkdir /opt/homebrew/etc/nginx/ssl
cd /opt/homebrew/etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.pem -subj "/C=CN/ST=Fujian/L=Xiamen/O=Def/OU=Def/CN=Def"
```

#### 可选，申请免费证书

```shell
sudo certbot certonly --manual --preferred-challenges dns -d "*.hmphp.com" -d "hmphp.com"
mkdir ~/ssl
sudo cp /etc/letsencrypt/live/hmphp.com/fullchain.pem ~/ssl/hmphp.com.pem
sudo cp /etc/letsencrypt/live/hmphp.com/privkey.pem ~/ssl/hmphp.com.key
sudo chmod 640 ~/ssl/hmphp.com.pem ~/ssl/hmphp.com.key
```

#### 添加默认项目文件

```shell
mkdir -p ~/www/_default_/
cat > ~/www/_default_/index.html <<EOF
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Coming Soon</title>
</head>
<body>
Coming Soon
</body>
</html>
EOF
```

#### 添加默认主机

```shell
cat > /opt/homebrew/etc/nginx/servers/macos-base.conf <<EOF
server {
    listen 80 default_server;
    server_name _;
    root $HOME/www/_default_;
}
server {
    listen 443 ssl default_server;
    server_name _;
    ssl_certificate /opt/homebrew/etc/nginx/ssl/nginx.pem;
    ssl_certificate_key /opt/homebrew/etc/nginx/ssl/nginx.key;
    root $HOME/www/_default_;
}
EOF
```

## 安装php-redis扩展

```shell
pecl list
pecl install igbinary
pecl install redis
```

### 修改php.ini顺序

```
extension="igbinary.so"
extension="redis.so"
```

## 安装swoole扩展

```shell
brew install pcre2
export CPPFLAGS="-I/opt/homebrew/include"
export LDFLAGS="-L/opt/homebrew/lib"
pecl install swoole
```

## [安装composer](https://pkg.xyz/#how-to-install-composer)

### 可以直接下载 [官网](https://getcomposer.org/download/) 的 [Latest Stable](https://getcomposer.org/download/latest-stable/composer.phar)，从步骤2开始

```shell
# 步骤1：检查环境，下载文件
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
# 步骤2
sudo mkdir -p /usr/local/bin
sudo +x composer.phar
sudo mv composer.phar /usr/local/bin/composer
echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.zshrc
source ~/.zshrc
# 设置镜像源
composer config -g repo.packagist composer https://packagist.phpcomposer.com
# 设置缓存目录
composer config -g cache-dir ~/.composer/cache
```

### 保持 Composer 为最新版本

```shell
sudo composer selfupdate
```

## [安装nvm](https://github.com/nvm-sh/nvm)

```shell
export HTTPS_PROXY=http://127.0.0.1:10808
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

### 执行上面输出的export命令后继续

```shell
source ~/.zshrc
nvm install 20
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

## [禁用 Firefox 自动更新](https://sysin.org/blog/disable-firefox-auto-update/)

```shell
mkdir /Applications/Firefox.app/Contents/Resources/distribution
echo '
{
"policies": {
"DisableAppUpdate": true
}
}
' > /Applications/Firefox.app/Contents/Resources/distribution/policies.json
```

## 附：安装个别 APP 时绕过签名认证

```shell
xattr -r -d com.apple.quarantine /Applications/Navicat\ Premium.app
xattr -r -d com.apple.quarantine /Applications/Sublime\ Text.app
xattr -r -d com.apple.quarantine /Applications/v2rayN.app
xattr -r -d com.apple.quarantine /Applications/EcoPaste.app
```

## 附：关闭SIP

```shell
csrutil disable
```

## 附：terminal终端设置代理

```shell
export HTTP_PROXY=http://127.0.0.1:10808
export HTTPS_PROXY=http://127.0.0.1:10808
export ALL_PROXY=socks5://127.0.0.1:10808
```

## 附：安装imagick

```shell
brew install imagemagick
brew install pkg-config
pecl install imagick
```

### php.ini

```
extension="imagick.so"
```

## 附：修改php-fpm监听，/opt/homebrew/etc/php/8.2/php-fpm.d/www.conf

```
; listen = 127.0.0.1:9000
listen = /tmp/php-fpm-82.sock
listen.mode = 0666
```

### 作为守护进程，/opt/homebrew/etc/php/8.2/php-fpm.conf

```
daemonize = yes
```

## 附：安卓path

```shell
export PATH=/Users/haoming/Library/Android/sdk/platform-tools:$PATH
```

## 附：修改apache配置，/private/etc/apache2/other/php7.conf

```apacheconf
LoadModule php7_module /opt/homebrew/opt/php@7.4/lib/httpd/modules/libphp7.so "haomingCA"
<FilesMatch \.php$>
SetHandler application/x-httpd-php
</FilesMatch>
```

## 附：钥匙串-创建证书颁发机构-“用户证书”选择“代码签名”

```shell
sudo codesign --sign "haomingCA" --force --keychain ~/Library/Keychains/login.keychain-db /opt/homebrew/opt/php@7.4/lib/httpd/modules/libphp7.so
```

## 附：[安装php-redis扩展](https://github.com/phpredis/phpredis)

```shell
pickle install redis
```

## 附：[如何下载和安装 macOS](https://support.apple.com/zh-cn/102662)，[创建可引导的 macOS 安装器](https://support.apple.com/zh-cn/101578)

```shell
sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume /Volumes/macos15
```
