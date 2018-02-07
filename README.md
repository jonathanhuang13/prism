# prism

## Installation
## API
### Setup Postgres
```
brew update && brew install postgresql
initdb /usr/local/var/postgres
pg_ctl -D /usr/local/var/postgres -l logfile start
```

*Create User*

```
createuser -P -s -e -d prism
```

Set password to "prism"

*Create Database*

```
createdb prism
createdb prism_test
```

*Migrate and Seed*
```
cd api
mix deps.get
mix ecto.reset
```
