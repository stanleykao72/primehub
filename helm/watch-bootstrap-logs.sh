kubectl -n primehub logs -f $(kubectl -n primehub get pod | awk '/primehub-bootstrap/ {print $1}')
