# Backlog tecnico MVP

Priorita': P0 (blocca) > P1 (MVP) > P2 (dopo MVP). Dipendenze tra parentesi.

| ID | Priorita' | Titolo | Dipende da | Criteri di accettazione |
|---|---|---|---|---|
| B0 | P0 | Merge PR docs e Docker locale | — | PR #1 e PR ambiente approvate dal titolare; `docker compose up -d` porta l'app su :3000 seguendo `LOCAL_DEV.md` |
| B1 | P0 | Completare baseline test | B0 | RSpec `services/controllers/jobs/lib` + rubocop + eslint eseguiti e risultati in `BASELINE.md`; hang `conversation_spec:1114` diagnosticato |
| B2 | P0 | Isolamento Enterprise in build | B0 | Dockerfile prod rimuove `enterprise/`; app parte e `/api` risponde; check CI che nessun file `enterprise/` sia modificato |
| B3 | P1 | Branding originale (nome, logo, colori) | B2 | Nessuna occorrenza visibile di "Chatwoot" in UI/email salvo crediti legali; installation config applicata via seed; attribuzione MIT presente |
| B4 | P1 | Localizzazione italiana predefinita | B2 | Nuovo account: lingua `it`, timezone Europe/Rome; UI e email principali in italiano; test i18n passano |
| B5 | P1 | Preset "assistenza tecnica": attributi cliente/impianto/matricola | B2 | Seed idempotente crea custom attributes (contatto: ragione sociale, P.IVA; conversazione: impianto, matricola, modello); visibili in UI; spec seeder verdi |
| B6 | P1 | Preset label, macro e risposte rapide in italiano | B5 | Seed idempotente; elenco etichette (guasto, garanzia, ricambio, intervento) disponibile in nuovo account |
| B7 | P1 | Priorita', stati e assegnazione | B5 | Flusso crea richiesta→assegna→cambia priorita'→risolvi verificato con test; regole automazione di esempio |
| B8 | P1 | Viste/filtri salvati (Da assegnare, Urgenti, In ritardo) | B7 | Filtri personalizzati creati dal seed; spec |
| B9 | P1 | Test end-to-end flussi principali | B5-B8 | Scenario: email/widget→inbox→assegnazione→risposta→chiusura passa in CI headless |
| B10 | P1 | Demo con dati fittizi | B9 | Comando di seed demo (solo dati inventati); nessun dato reale |
| B11 | P1 | CI GitHub Actions | B1 | Workflow lint+test su PR; reso obbligatorio solo dopo verifica (richiede conferma titolare) |
| B12 | P2 | Staging: HTTPS, segreti, backup, monitoraggio | B2, B11 | Compose/manifest di staging, TLS via reverse proxy, segreti fuori dal repo, backup Postgres con ripristino provato, health check; **nessun deploy senza approvazione** |
| B13 | P2 | Hardening sicurezza | B12 | Checklist (bundler-audit, pnpm audit, header, rate limit, 2FA) con esiti |
| B14 | P2 | Costi e guida al deployment | B12 | Stima costi hosting/mail/backup documentata |
| B15 | P2 | Integrazione gestionale/ticketing esterno via webhook | B7 | Webhook documentato e testato |

## Decisioni che richiedono il titolare
- Nome e marchio del prodotto; parere legale sulla distribuzione SaaS.
- Scelta provider hosting e relativi costi; dominio.
- Attivazione CI obbligatoria e merge in `product/main`.
