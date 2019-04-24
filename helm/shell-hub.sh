hub=$(kubectl -n primehub get pod -o json | jq -r '.items[].metadata.name' | grep '^hub')
kubectl -n primehub exec -it $hub --container hub -- bash
