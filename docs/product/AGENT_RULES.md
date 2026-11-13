# Regole operative per gli agenti

1. **Branch e PR:** un branch `feature|fix|chore/<nome>` da `product/main` per ogni voce di backlog; PR piccole verso `product/main`. Nessun push diretto. **Mai fare merge** senza consenso esplicito del titolare.
2. **Enterprise:** non leggere per copiare, non modificare, non riusare codice di `enterprise/`. Sviluppo con `DISABLE_ENTERPRISE=true`. Se un task richiede una funzione Enterprise: fermarsi e segnalare.
3. **Riutilizzo:** preferire funzioni Community esistenti; niente riscritture di componenti funzionanti. Rispettare `AGENTS.md` upstream (Composition API, Tailwind only, i18n, migrazioni via generator, niente SQL raw).
4. **Ciclo per ogni modifica:** analisi → piano → implementazione → test → lint → verifica regressioni → documentazione → PR.
5. **Ambiente:** solo Docker (vedi `LOCAL_DEV.md`). Non installare Ruby/Node sull'host. Dopo `db:chatwoot_prepare` ripristinare i file modificati da `annotate`.
6. **Segreti e dati:** mai committare `.env` o chiavi. Solo dati fittizi nelle demo. Nessun dato reale senza approvazione.
7. **Richiedere autorizzazione per:** costi/acquisti, deploy, merge su branch protetto, operazioni distruttive, modifiche di sicurezza rilevanti, decisioni commerciali.
8. **Registro:** aggiornare `docs/product/ACTIVITY_LOG.md` (attivita', test eseguiti con numeri reali, problemi, prossimi passi). Riportare solo risultati verificati.
9. **Worktree paralleli:** un worktree per agente; non toccare gli stessi file; rebase su `product/main` prima della PR.
10. **Line ending:** LF; `core.autocrlf=false`.
