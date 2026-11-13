# Isolamento del codice Enterprise

Obiettivo: nessuna immagine distribuibile contiene `enterprise/` (licenza separata, `enterprise/LICENSE`).

## Come
- `script/product/export_community.sh <dir> [ref]` esporta i soli file tracciati e rimuove `enterprise/` e `spec/enterprise/`. Usare quella directory come contesto di build Docker (`docker build -f docker/Dockerfile <dir>`).
- Lo stesso approccio e' usato dalla CI upstream (`run_foss_spec.yml`: "Strip enterprise code").
- La CI di prodotto (`.github/workflows/product-ci.yml`) fallisce se `enterprise/` o `spec/enterprise/` differiscono dal tag upstream (`UPSTREAM_TAG`).

## Verifiche eseguite (2026-11-13)
- Copia Community senza `enterprise/`: Rails parte, `/api` risponde 200; `defined?(Enterprise)` e `defined?(Captain::Document)` sono nil.
- `LICENSE` (MIT) e attribuzioni restano presenti nell'export (lo script fallisce se mancano).

## Da fare
- Dockerfile/pipeline di staging che invochi lo script (B2/B12).
- Verificare con RSpec completo sull'export Community (la CI esegue modelli e policy).
