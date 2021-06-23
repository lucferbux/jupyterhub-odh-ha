#!/bin/sh

ENDPOINT="jupyterhub-ha-election"
ME="$(cat /etc/hostname)"

function get_leader() {
  echo "$(oc get endpoints "${ENDPOINT}" -ojson | jq -r '.metadata.annotations' | jq '.["control-plane.alpha.kubernetes.io/leader"]' | sed 's/\\//g;s/^"//;s/"$//' | jq -r .holderIdentity)"
}

until [ "${ME}" == "$(get_leader)" ]; do
  sleep 6
done

echo "Became leader! Start the program!"
