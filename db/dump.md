# PostgreSQL

## Dump

```bash
sudo -u postgres pg_dump -d mydb -f /tmp/mydb.sql
```

## Import

```bash
sudo -u postgres psql -f /tmp/mydb.sql mydb
```
