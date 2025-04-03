# Upgrade PostgreSQL 14 to 16 on macOS

And `pgvector`.

## pgvector

```bash
# not for v16
brew uninstall pgvector

git clone git@github.com:pgvector/pgvector.git
cd pgvector
make all
sudo make install
```

## PostgreSQL

```bash
/opt/homebrew/Cellar/postgresql@16/16.8_1/bin/pg_upgrade \
    -b /opt/homebrew/Cellar/postgresql@14/14.17_1/bin \
    -B /opt/homebrew/Cellar/postgresql@16/16.8_1/bin \
    -d /opt/homebrew/var/postgresql@14 \
    -D /opt/homebrew/var/postgresql@16
```

## Useful commands

```bash
pg_config --libdir
brew list postgresql@14

```

## Resources

- <https://stackoverflow.com/questions/78388178/how-to-update-a-postgresql-database-with-brew>
- <https://stackoverflow.com/questions/75664004/install-pgvector-extension-on-mac>
