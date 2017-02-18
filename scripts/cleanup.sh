#!/bin/bash

function cleanup_network {
  NETWORK=$1
  SUBNETS=`neutron net-show $NETWORK | grep -i subnets | awk '{print $4}'`
  if [[ $SUBNETS != "" ]]; then
      PORTS=`neutron port-list | grep -i $SUBNETS | awk '{print $2}'`
      for PORT in $PORTS; do
          echo "Deleting port $PORT"
          neutron port-delete $PORT
      done
  fi
  neutron net-delete $NETWORK
}

source ./admin-openrc.sh

echo "Deleting VMs"
# Delete all VMs
VMS=$( nova list --all-tenants|grep mysite|awk '{print $2}' )
for VM in $VMS
do
    nova delete $VM
done

echo "Waiting 5 seconds..."
sleep 5

cleanup_network lan_network
cleanup_network wan_network
cleanup_network mysite_vcpe-private
cleanup_network mysite_vsg-access
cleanup_network management
cleanup_network management_hosts

echo "Deleting networks"
# Delete all networks beginning with mysite_
NETS=$( neutron net-list --all-tenants|grep mysite|awk '{print $2}' )
for NET in $NETS
do
    neutron net-delete $NET
done

neutron net-delete lan_network || true
neutron net-delete subscriber_network || true
neutron net-delete public_network || true
neutron net-delete hpc_client_network || true
neutron net-delete ceilometer_network || true
neutron net-delete management || true
neutron net-delete management_hosts || true
neutron net-delete mysite_vsg-access || true
neutron net-delete public || true

echo "Deleting Users"
USERS=$(openstack user list | grep @ | awk '{print $2}')
for USER in $USERS
do
    openstack user delete $USER
done

echo "Deleting Projects"
PROJECTS=$(openstack project list | grep mysite | awk '{print $2}')
for PROJECT in $PROJECTS
do
    openstack project delete $PROJECT
done

echo "Deleting Images"
IMAGES=$(openstack image list | grep active | awk '{print $2}')
for IMAGE in $IMAGES
do
    openstack image delete $IMAGE
done

