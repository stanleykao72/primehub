kubectl delete secret -n primehub primehub-secret
helm delete primehub --purge
kubectl -n primehub delete job primehub-bootstrap
