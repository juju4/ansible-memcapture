#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
[ ! -d $rolesdir/juju4.volatility ] && git clone https://github.com/juju4/ansible-volatility $rolesdir/juju4.volatility
[ ! -d $rolesdir/juju4.golang ] && git clone https://github.com/juju4/ansible-golang $rolesdir/juju4.golang
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.memcapture ] && ln -s ansible-memcapture $rolesdir/juju4.memcapture
[ ! -e $rolesdir/juju4.memcapture ] && cp -R $rolesdir/ansible-memcapture $rolesdir/juju4.memcapture

## don't stop build on this script return code
true
