Scripts
===

 - add-instance \$1 \$2 \$3
	 -在CORD 擁有network={management, mysite_vsg-access}和hack-ubuntu image的環境下，用來建立一個 net-mgmt=\$1, net-vsg=\$2, instance-name=\$3 的openstack instance
 - cleanup.sh
	 - 更新R-CORD裡面的cleanup.sh，多清除所有的User, Project, Image
 - onos-restart
	 - 用來重啟onos-fabric 和onos-cord
 - pod-inventory
	 - 會回傳包含head和maas所安裝的compute list，可用於Ansible
 - restart-xos.yml
	 - 在headnode user是vagrant的環境下，用來重啟cord-pod所有環境
