# Upgrade PostgreSQL 13 to 14 on Debian GNU/Linux 12 (bookworm)

Run everything as root.

```
apt-get update
apt-get install postgresql-14

systemctl --no-pager status postgresql@13-main.service
journalctl -f -u postgresql@13-main.service

export LANGUAGE=C
export LC_ALL=C
export LC_CTYPE=C
export LANG=C
pg_upgradecluster 13 main
pg_dropcluster 13 main
```

## Alternative (manually)

```
/usr/lib/postgresql/14/bin/initdb -D /var/lib/postgresql/14/main -U postgres

/usr/pgsql-14/bin/pg_upgrade \
    -b /usr/pgsql-13/bin \
    -B /usr/pgsql-14/bin \
    -d /var/lib/postgresql/13/main \
    -D /var/lib/postgresql/14/main \
    -j 4 \
    -k -p 5432 -P 5433 -U postgres
```
