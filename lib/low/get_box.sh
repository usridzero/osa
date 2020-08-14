# ----------------------------------------------------------------------------
# Download and add the vagrant box used for the base of all VMs
# ----------------------------------------------------------------------------
OS=centos7
VERSION=2004
BOX_NAME="${OS}:${VERSION}"
FILE=/tmp/"${BOX_NAME}.box"
BOX_URL=http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box

if [ ! -f "$FILE" ]; then
    wget $BOX_URL -O $FILE
fi
vagrant box add --force --name $BOX_NAME $FILE