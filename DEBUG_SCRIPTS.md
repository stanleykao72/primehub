# debug scripts

It is only used with debugging and development. We would not ship it with production and developers should not merge it into master branch.

## Get scripts

In the root of your development branch:

```
git checkout origin/feature/debug-scripts scripts/*
```

## Create a installed cluster

```
./reset-kind.sh
```

