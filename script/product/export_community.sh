#!/usr/bin/env bash
# Esporta una copia "Community-only" del repository, SENZA la directory enterprise/
# (licenza separata, vedi enterprise/LICENSE). Usare questa copia come contesto di build
# per immagini distribuibili / di staging / di produzione.
#
# Uso: script/product/export_community.sh <directory-di-destinazione> [git-ref]
set -euo pipefail

OUT="${1:?uso: $0 <directory-destinazione> [git-ref]}"
REF="${2:-HEAD}"

mkdir -p "$OUT"
if [ -n "$(ls -A "$OUT")" ]; then
  echo "La directory di destinazione non e' vuota: $OUT" >&2
  exit 1
fi

# git archive esporta solo i file tracciati (niente .env, .git, node_modules).
git archive "$REF" | tar -x -C "$OUT"

rm -rf "$OUT/enterprise" "$OUT/spec/enterprise"

if [ -e "$OUT/enterprise" ]; then
  echo "ERRORE: enterprise/ ancora presente nell'export" >&2
  exit 1
fi

# Le licenze e le attribuzioni devono restare.
test -f "$OUT/LICENSE" || { echo "ERRORE: LICENSE mancante" >&2; exit 1; }

echo "Export Community pronto in: $OUT (enterprise/ rimossa)"
