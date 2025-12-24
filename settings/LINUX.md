### 重置Machine-ID

```shell
sudo cp /dev/null /etc/machine-id
sudo systemd-machine-id-setup
sudo reboot
```
