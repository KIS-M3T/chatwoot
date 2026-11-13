# Audit architettura e licenze — Chatwoot v4.19.1

## Stack
- Backend: Rails 7.2.3.1, Ruby 3.4.4; PostgreSQL (+ pgvector), Redis, Sidekiq 7.3; Devise, Pundit, Administrate (super admin).
- Frontend: Vue 3.5 (Composition API, `<script setup>`), Vite 6, Pinia + Vuex, Tailwind 3 (solo utility class), vitest.
- Runtime dev: `Procfile.dev` (rails, sidekiq, vite); Docker compose upstream (rails, sidekiq, vite, postgres, redis, mailhog).
- API: `app/controllers/api/v1/accounts/*` (agenti, conversazioni, contatti, inbox, label, team, macro, automazioni, attributi personalizzati, filtri, campagne, CSAT, portali/articoli, webhook, agent bot, dashboard apps, import dati).
- i18n: `config/locales/*.yml` e `app/javascript/dashboard/i18n/locale/<lingua>`; l'italiano e' gia' presente (48 file dashboard).

## Licenze e isolamento Enterprise
- Codice Community: MIT (`LICENSE`, Copyright Chatwoot Inc.). Mantenere avviso di copyright e testo MIT in ogni distribuzione.
- `enterprise/` (app, config, lib): licenza separata (`enterprise/LICENSE`): uso in produzione solo con sottoscrizione valida; vietato copiare, pubblicare, distribuire, vendere. Uso per sviluppo/test consentito.
- Punti di aggancio: `config/application.rb` (autoload di `enterprise/lib`, `listeners`, `app/**`, view, initializer) e `lib/chatwoot_app.rb` (`enterprise?`, `DISABLE_ENTERPRISE`, `chatwoot_cloud?`, piani).
- **Regole del prodotto:**
  1. Sviluppo/test locale con `DISABLE_ENTERPRISE=true`.
  2. Le immagini di staging/produzione vengono costruite **senza** la directory `enterprise/` (rimossa nel Dockerfile di build); `ChatwootApp.enterprise?` diventa falso.
  3. Nessuna modifica, copia o reimplementazione 1:1 di file in `enterprise/`. Le funzioni nostre vivono in nuovi file/namespace Community (es. `app/**/assistenza/`), mai in `enterprise/`.
  4. Non sbloccare funzioni a piano (Captain/AI, SLA, audit log, ecc.) aggirando i controlli di piano.
  5. Mantenere i crediti Chatwoot (README/NOTICE) anche con branding originale; ricontrollare i marchi (nome, logo) prima del rilascio.
  6. Verifica CI: fallire la build se un file di `enterprise/` risulta modificato rispetto al tag upstream.
- Da fare: parere legale sull'uso del nome/logo e sulla distribuzione SaaS (decisione commerciale: chiedere al titolare).

## Funzionalita' Community riutilizzabili per l'MVP
| Esigenza MVP | Funzione esistente | Note |
|---|---|---|
| Inbox centralizzata | Inbox + canali (email, web widget, WhatsApp, API) | Riutilizzo diretto |
| Richieste di assistenza | Conversazioni, stati (open/pending/resolved/snoozed) | Nessun nuovo modello necessario in v1 |
| Cliente, impianto, matricola | Custom attributes su contatto e conversazione | Definizioni via seed/migrazione dati, nessun codice |
| Priorita' | Priorita' conversazione (urgent/high/medium/low) | Verificare presenza nella 4.19.1 Community |
| Assegnazioni | Agenti, team, assegnazione automatica, inbox members | Verificare cosa e' Enterprise (assignment policies) |
| Etichette / tipologie guasto | Labels | Seed iniziale in italiano |
| Risposte rapide | Canned responses, macro | Seed in italiano |
| Automazioni | Automation rules | Es. assegnazione per tipo richiesta |
| Qualita' | CSAT | Verificare disponibilita' piano |
| Filtri/viste | Custom filters | Viste "In ritardo", "Da assegnare" |
| Base di conoscenza | Portali/articoli | Opzionale |
| Integrazioni | Webhooks, API, agent bot, dashboard apps | Per gestionale/CRM |

## Lacune da colmare (nuovo codice Community, fuori da `enterprise/`)
- Seed "preset assistenza tecnica" (attributi, label, macro, risposte in italiano).
- Branding originale (nome, logo, colori, email, pagine legali) via installation config.
- Impostazioni IT: lingua default `it`, timezone Europe/Rome, formato data, valuta EUR.
- Hosting gestito: multi-tenancy (account), onboarding, backup, monitoraggio.
