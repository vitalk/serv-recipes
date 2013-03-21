#!/usr/bin/env bash
# Create a ubuntu PV guest VM
# Usage: curl https://raw.github.com/vitalk/serv-recipes/master/install/create-ubuntu-pv-guest.sh | my_mirror=http://ftp.byfly.by/ubuntu my_domu_name=ubuntu my_vif_ip=192.168.1.99 my_vif_mac=00:16:3E:E0:4D:50 my_domu_memory=256 sh


# setup the initial guest configuration
if [ -f /etc/xen/auto/$my_domu_name.cfg ]; then
    echo "The domU with name $my_domu_name already exists. Exiting..."
    exit 0
fi
wget https://raw.github.com/vitalk/serv-recipes/master/xen/ubuntu.cfg -O /etc/xen/$my_domu_name.cfg
ln -s /etc/xen/$my_domu_name.cfg /etc/xen/auto/$my_domu_name.cfg

sed -i "s/YOUR_DOMU_NAME/$my_domu_name/" /etc/xen/$my_domu_name.cfg
sed -i "s/YOUR_DOMU_MEMORY/$my_domu_memory/" /etc/xen/$my_domu_name.cfg
sed -i "s/YOUR_VIF_IP/$my_vif_ip/" /etc/xen/$my_domu_name.cfg
sed -i "s/YOUR_VIF_MAC/$my_vif_mac/" /etc/xen/$my_domu_name.cfg
