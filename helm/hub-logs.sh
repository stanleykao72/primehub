hub=$(kubectl -n primehub get pod -o json | jq -r '.items[].metadata.name' | grep '^hub')
kubectl -n primehub logs $hub --container hub -f
