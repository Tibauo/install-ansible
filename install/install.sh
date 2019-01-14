#!/bin/bash

PROGNAME=$0

HOME_DIR=$PWD
echo "HOME_DIR=$HOME_DIR"

source $HOME_DIR/var

usage(){
cat <<EOF
Need to be sudoer or root (install pip, ansible)
Please check var in folder $HOME_DIR/var. All var in this folder need exist

How to use
----------
$PROGNAME

EOF
exit 1
}


requiredInstallYum(){
  yum install -y epel-release
  yum install -y python-pip
}

requiredInstallApt(){
  apt install -y python-pip
}

installAnsible(){
  pip install ansible
}

createUser(){
if [ -z $(id -u $user) ]; then
  echo "user $user doesn't exist"
  useradd -m $user -s /bin/bash
  echo "user $user created"
fi

if [ -f $path_home_user ]; then
  echo "home directory $path_home_directory for $user doesn't exist"
  usage
fi
}

configureAnsible(){

if [ ! -e $path_ansible_cfg ]; then
  echo "Create ansible cfg"
  cp $HOME_DIR/template/ansible.cfg $path_ansible_cfg
  chown $user:$user $path_ansible_cfg
fi

if [ ! -e $path_ansible_host ]; then
  echo "Create ansible host"
  cp $HOME_DIR/template/host $path_ansible_host
  chown $user:$user $path_ansible_host
  sed -i "s|{{ path_ansible_host }}|$path_ansible_host|g" $path_ansible_cfg
fi


}

main(){

if [ -n "$(command -v yum)" ]; then
  echo "Yum"
  requiredInstallYum
elif [ -n "$(command -v apt-get)" ]; then
  echo "Apt"
  requiredInstallApt
else
  echo [ "don't know" ]
  usage
fi

createUser
installAnsible
configureAnsible
}

while getopts ":h" option; do
    case "${option}" in
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  usage
fi

main
