# Baseline test — Chatwoot v4.19.1 (Community, Enterprise disattivato)

Data: 2026-11-12/13. Ambiente: Docker (Ruby 3.4.4, Node 24.22.1), `DISABLE_ENTERPRISE=true`.

| Suite | Esito |
|---|---|
| Health `/api` | 200, versione 4.19.1, queue_services ok, data_services ok |
| Login `/app/login` | 200 |
| Mailhog `:8025` | 200 |
| RSpec `spec/models` + `spec/policies` (escluso `conversation_spec.rb`) | 1079 esempi, 0 fallimenti, 31 pending |
| RSpec `spec/models/label_spec.rb` (sanity) | 10 esempi, 0 fallimenti |
| Vitest (`pnpm test --run`) | 513 file, 5251 test, tutti passati (1481 s) |

## Problemi noti
1. **`spec/models/conversation_spec.rb:1114` ("reply time calculation flows") si blocca** (CPU ~3%, nessun output, anche in isolamento). Causa non ancora individuata (sospetto: `perform_enqueued_jobs` con job che attendono Redis/rete). Da indagare. Il resto di `conversation_spec.rb` non e' stato eseguito in baseline.
2. **Non eseguiti in baseline:** `spec/services`, `spec/controllers`, `spec/jobs`, `spec/listeners`, `spec/lib`, lint (rubocop, eslint).
3. `docker compose build` in parallelo fallisce: costruire prima `base`.
4. `db:chatwoot_prepare` esegue `annotate` e modifica file tracciati (anche in `enterprise/`): ripristinare con `git checkout`.
5. Primo caricamento pagina ~30 s (compilazione Vite in dev).
6. File con CRLF da checkout Windows rompono gli entrypoint shell.

## Aggiornamento 2026-11-13
| Controllo | Esito |
|---|---|
| ESLint (`pnpm eslint`) | 0 errori, 456 warning (i18n gia' presenti in upstream) |
| RuboCop (intero repo, container) | 3361 file, 54 violazioni (`Rails/Output`, `Rails/Exit`) in 9 file NON applicativi: `docker/entrypoints/helpers/pg_database_url.rb`, `script/*.rb` (6), `spec/rails_helper.rb`, `spec/support/opensearch_check.rb`. Codice app/lib/config/db pulito. |
| App senza `enterprise/` | Avvio OK su export Community: `/api` 200 (4.19.1, queue/data ok); `enterprise` assente, `Enterprise` e `Captain::Document` non definiti, `ChatwootApp.enterprise?` falsy |
| Vitest | 513 file, 5251 test, tutti passati |

Nota: la CI di prodotto esegue RuboCop solo sui file Ruby modificati dalla PR per non ereditare le violazioni upstream.
