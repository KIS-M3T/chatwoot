# Ambiente di sviluppo locale (Docker)

Nessun Ruby/Node sull'host: tutto gira in container.

## Prima configurazione
1. `cp .env.example .env`, poi in `.env` impostare:
   - `SECRET_KEY_BASE`: 64 caratteri esadecimali casuali;
   - `REDIS_PASSWORD` e `POSTGRES_PASSWORD`: valori casuali generati da voi (es. 32 caratteri esadecimali). `docker compose` rifiuta di partire se `POSTGRES_PASSWORD` manca;
   - `FRONTEND_URL=http://localhost:3000` e `DISABLE_ENTERPRISE=true`.

   `.env` e' ignorato da git: **mai committarlo** e non scrivere password nei file compose.
2. `docker compose build base` (prima!), poi `docker compose build rails vite`.
3. `docker compose up -d postgres redis mailhog`
4. `docker compose run --rm --no-deps rails bundle exec rails db:chatwoot_prepare`
5. **Ripristino dei file generati (procedura sicura).** Il task di prepare esegue `annotate` e puo' modificare modelli e `db/schema.rb`.
   - Ispezionare: `git status --short` e `git diff --stat`.
   - Se avete modifiche vostre non committate, committatele o fate `git stash` PRIMA.
   - Per ogni file modificato verificare che il diff contenga solo commenti di annotazione/schema (`git diff app/models/user.rb`), poi ripristinare solo quel file: `git restore app/models/user.rb`.
   - Non usare `git checkout -- <cartella>` ne' `git restore .` sull'intero albero: cancellerebbero lavoro non committato.
6. `docker compose up -d`

## Endpoint (solo 127.0.0.1)
- App: http://localhost:3000/app/login (primo caricamento ~30 s: compilazione Vite)
- Health: http://localhost:3000/api
- Mailhog: http://localhost:8025

## Rete e segreti
- `docker-compose.override.yml` pubblica **tutte** le porte (Rails 3000, Vite 3036, PostgreSQL 5432, Redis 6379, Mailhog 1025/8025) solo su `127.0.0.1`, usando `!override` per sostituire l'elenco delle porte del compose upstream.
- Verifica: `docker compose config` deve mostrare `host_ip: 127.0.0.1` per ogni porta, senza duplicati.
- La password di PostgreSQL viene letta da `.env` (il compose upstream la lascia vuota). Per cambiarla su un volume esistente: `docker compose exec postgres psql -U postgres` e poi `ALTER USER postgres PASSWORD '<nuova>';`, quindi aggiornare `.env` e ricreare i container.
- Su Windows usare checkout con LF (`git config core.eol lf`, `core.autocrlf false`), altrimenti gli script `docker/entrypoints/*.sh` si rompono.

## Test (nei container)
- RSpec: `docker compose run --rm --no-deps -T -e RAILS_ENV=test -e DISABLE_ENTERPRISE=true rails bundle exec rspec <path>` (caricamento ~50 s).
- Vitest: `docker compose exec -T vite pnpm test --run` (~25 min la prima volta).
