kind delete cluster --name primehub
kind create cluster --name primehub


export KUBECONFIG="$(kind get kubeconfig-path --name="primehub")"

while [ ! "$(kubectl get nodes -o json | jq -r '.items[].status.conditions[] | select(.reason | contains("KubeletReady")) | .type')" == "Ready" ]
do
    sleep 5
    echo "Wait Node Ready"
done

echo
echo "setup helm"
./00-setup.sh

echo
echo "helm install"
./01-helm-release.sh

while [ "$(kubectl -n primehub get pods primehub-keycloak-0 -o json | jq -r '.status.conditions[] | select(.type | contains("ContainersReady")) | .status')" == "False" ]
do
    echo "wait keycloak"
    sleep 7
done
echo
