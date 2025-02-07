
# Building releases

requires:
- gnu make
- c89 compiler
- xxd
- tar
- plzip
- gzip
- bzip2

```
$ gmake clean
$ gmake genrelease
$ ls release/distributables
nowrap-0.2-beta.tar
nowrap-0.2-beta.tar.bz2
nowrap-0.2-beta.tar.gz
nowrap-0.2-beta.tar.lz
```

