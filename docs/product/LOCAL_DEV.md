# Ambiente di sviluppo locale (Docker)

Nessun Ruby/Node sull'host: tutto gira in container.

## Prima configurazione
1. `cp .env.example .env` e impostare `SECRET_KEY_BASE` (64 hex), `REDIS_PASSWORD`, `POSTGRES_PASSWORD=postgres`, `FRONTEND_URL=http://localhost:3000`, `DISABLE_ENTERPRISE=true`.
2. `docker compose build base` (prima!), poi `docker compose build rails vite`.
3. `docker compose up -d postgres redis mailhog`
4. `docker compose run --rm --no-deps rails bundle exec rails db:chatwoot_prepare`
5. `git checkout -- app enterprise db` (il task di prepare esegue `annotate` e modifica modelli e schema: NON committare quelle modifiche).
6. `docker compose up -d`

## Endpoint
- App: http://localhost:3000/app/login (primo caricamento ~30 s: compilazione Vite)
- Health: http://localhost:3000/api
- Mailhog: http://localhost:8025

## Note
- `docker-compose.override.yml` imposta la password di PostgreSQL (il compose upstream la lascia vuota).
- `.env` e' ignorato da git; non committare segreti.
- Su Windows usare checkout con LF (`git config core.eol lf`, `core.autocrlf false`), altrimenti gli script `docker/entrypoints/*.sh` si rompono.

## Test (nei container)
- RSpec: `docker compose run --rm --no-deps -T -e RAILS_ENV=test -e DISABLE_ENTERPRISE=true rails bundle exec rspec <path>` (caricamento ~50 s).
- Vitest: `docker compose exec -T vite pnpm test --run` (~25 min la prima volta).
