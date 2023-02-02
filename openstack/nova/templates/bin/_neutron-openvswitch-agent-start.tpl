#!/usr/bin/env bash


. /container.init/common.sh

function process_config {
    mkdir -p  /etc/neutron/plugins/ml2/

    cp /neutron-etc/neutron.conf  /etc/neutron/neutron.conf
    cp /neutron-etc/logging.conf  /etc/neutron/logging.conf
    cp /neutron-etc/ml2-conf.ini  /etc/neutron/plugins/ml2/ml2_conf.ini
    cp /neutron-etc/rootwrap.conf  /etc/neutron/rootwrap.conf
    cp /neutron-etc/neutron-policy.json  /etc/neutron/policy.json
}


function _start_application {
    # TODO: Move to image
    apt update
    apt install -y openvswitch-switch

    until ! pgrep -f /var/lib/openstack/bin/neutron-openvswitch-agent; do
      echo "Waiting to be the only highlander"
      sleep 5
    done

    exec neutron-openvswitch-agent --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini
}


process_config

start_application
