title() {
  echo "==================================="
  echo $@
  echo
}

newlines() {
  echo ""
  echo ""
}

title "keycloak password"
keycloak_password=$(kubectl -n primehub get secret primehub-keycloak-http -o jsonpath='{.data.password}' | base64 --decode)
echo "password: $keycloak_password"
echo
echo "./keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user keycloak --password $keycloak_password"
newlines

title "hub environment variables"
hub=$(kubectl -n primehub get pod -o json | jq -r '.items[].metadata.name' | grep '^hub')
kubectl -n primehub exec -it $hub --container hub -- bash -c 'export' | grep KEYCLOAK
newlines

title "primhub-secret"
echo "clientSecret: $(kubectl -n primehub get secret primehub-secret -o jsonpath='{.data.keycloak\.clientSecret}' |  base64 --decode)"
echo "url: $(kubectl -n primehub get secret primehub-secret -o jsonpath='{.data.keycloak\.url}' |  base64 --decode)"
user_password=$(kubectl -n primehub get secret primehub-secret -o jsonpath='{.data.user\.password}' |  base64 --decode)
echo "user password: $user_password"
echo "./keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm primehub --user phuser --password $user_password"
newlines

title "last 10 lines log from keycloak"
kubectl -n primehub logs primehub-keycloak-0 --tail 10
newlines

title "last 10 lines log from hub"
kubectl -n primehub logs $hub --container hub --tail 50
newlines

