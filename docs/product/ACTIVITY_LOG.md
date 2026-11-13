# Registro attività

## Fase 1 — GitHub e workspace (completata)
- Git 2.46, gh 2.103, Docker 29.9 disponibili. Node e Ruby NON installati sull'host (si userà Docker).
- gh autenticato come KIS-M3T (scope repo, workflow, read:org, gist).
- Tag v4.19.1 verificato su chatwoot/chatwoot (c5c325a0...).
- Fork creato: https://github.com/KIS-M3T/chatwoot
- Remoti: origin = fork, upstream = chatwoot/chatwoot.
- Branch `product/main` creato dal tag v4.19.1 e pubblicato su origin.
- Branch di lavoro: `feature/*` da `product/main`, integrati solo via pull request.

## Vincoli legali
- Codice principale: MIT (mantenere LICENSE e copyright Chatwoot).
- `enterprise/`: licenza separata (Chatwoot Subscription Terms). Non copiare, modificare per sbloccare né commercializzare senza licenza.
- Il branding del prodotto sarà originale ma manterrà le attribuzioni obbligatorie.

## Prossimi passi (Fase 2)
- Leggere README/docs, analizzare architettura (Ruby 3.4.4, Node 24.22.1, PostgreSQL, Redis, Sidekiq, Vue 3).
- Ambiente Docker di sviluppo, avvio app, test di baseline.
