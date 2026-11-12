# Workflow di sviluppo

- `product/main`: branch di prodotto, da proteggere (PR obbligatoria, nessun push diretto).
- `feature/<nome>`, `fix/<nome>`, `chore/<nome>`: branch di lavoro creati da `product/main`.
- Ogni modifica passa da pull request verso `product/main`, con lint e test verdi.
- Aggiornamenti upstream: `git fetch upstream --tags` e merge/cherry-pick di tag stabili in un branch `chore/upstream-<tag>`.
- Il merge in `product/main` richiede l'approvazione del proprietario.
