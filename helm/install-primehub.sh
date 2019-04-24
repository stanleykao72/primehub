echo
echo "helm install"
../scripts/01-helm-release.sh

while [ "$(kubectl -n primehub get pods primehub-keycloak-0 -o json | jq -r '.status.conditions[] | select(.type | contains("ContainersReady")) | .status')" == "False" ]
do
    echo "wait keycloak"
    sleep 7
done
echo
