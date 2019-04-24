kind delete cluster --name primehub
kind create cluster --name primehub

while [ ! "$(kubectl get nodes -o json | jq -r '.items[].status.conditions[] | select(.reason | contains("KubeletReady")) | .type')" == "Ready" ]
do
    sleep 5
    echo "Wait Node Ready"
done

echo
echo "setup helm"
../scripts/00-setup.sh

./install-primehub.sh
