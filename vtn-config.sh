#!/bin/bash
ID=$1
HOSTNAME=$2
LOG=/etc/maas/ansible/logs/$ID.log

APIKEY=$(sudo maas-region-admin apikey --user=cord)
maas login cord http://localhost/MAAS/api/1.0 "$APIKEY" > /dev/null
NODES=$(maas cord nodes list | jq '.[].hostname' | sed -e 's/"//g')
maas logout cord

INV=$(tempfile)
cat >$INV <<EO_INV
[head]
juju-head-node ansible_user=ubuntu

[compute:vars]
ansible_user=ubuntu

[compute]
EO_INV

source /home/ubuntu/admin-openrc.sh

openstack compute service list | grep nova-compute | awk '{print $6}' >> $INV

cat $INV
sudo ansible --private-key=/etc/maas/ansible/id_rsa -i $INV compute -m ping
ANSIBLE_ROLES_PATH=/etc/maas/ansible/roles ansible-playbook --private-key=/etc/maas/ansible/id_rsa -i $INV /etc/maas/ansible/vtn-config.yml
RESULT=$?
rm $INV
exit $RESULT
