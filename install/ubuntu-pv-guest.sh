#!/usr/bin/env bash
# Create a ubuntu PV guest VM
#
# Note: list of the official ubuntu mirrors available on https://launchpad.net/ubuntu/+archivemirrors
# Usage: curl https://raw.github.com/vitalk/serv-recipes/master/install/ubuntu-pv-guest.sh | my_mirror=http://ftp.byfly.by/ubuntu my_domu_name=ubuntu my_vif_ip=192.168.1.99 my_vif_mac=00:16:3E:E0:4D:50 my_domu_memory=256 sh

# Usage: hex [<string>]
# return the unique hex string to generate valid MAC address 00:16:3E:xx:xx:xx
# to create unique part uses the passed <string> or current machine FQDN
hex() {
    local unique=$1 || $(hostname -f 2>/dev/null)
    echo 00163e$($unique | md5sum)
}

# Usage: mac <string>
# create a unique network address from <string>
mac() {
    echo $(hex $1) | sed -e 's/\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*/\1:\2:\3:\4:\5:\6/'
}

# setup the initial guest configuration
if [ -f /etc/xen/$my_domu_name.cfg ]; then
    echo "The domU with name $my_domu_name already exists. Exiting..."
    exit 0
fi
wget https://raw.github.com/vitalk/serv-recipes/master/xen/ubuntu.cfg -O /etc/xen/$my_domu_name.cfg
ln -s /etc/xen/$my_domu_name.cfg /etc/xen/auto/$my_domu_name.cfg

sed -i "s/YOUR_DOMU_NAME/$my_domu_name/" /etc/xen/$my_domu_name.cfg
sed -i "s/YOUR_DOMU_MEMORY/$my_domu_memory/" /etc/xen/$my_domu_name.cfg
sed -i "s/YOUR_VIF_IP/$my_vif_ip/" /etc/xen/$my_domu_name.cfg

# generate unique MAC if it's not set explicitly
sed -i "s/YOUR_VIF_MAC/${my_vif_mac:-$(mac $my_domu_name)}/" /etc/xen/$my_domu_name.cfg
