#!/usr/bin/env bash
# Run the max Sharpe optimization for one FinSimCo quarter.
# Usage: ./run_quarter.sh Q2 [path/to/prices.xlsx]
# Default data file: data/Historical Data <QUARTER>.xlsx
set -euo pipefail
cd "$(dirname "$0")"

QUARTER="${1:?Usage: ./run_quarter.sh <QUARTER> [data file]}"
DATA_FILE="${2:-data/Historical Data ${QUARTER}.xlsx}"
[ -f "$DATA_FILE" ] || { echo "Data file not found: $DATA_FILE"; exit 1; }

mkdir -p "outputs/${QUARTER}"
QUARTER="$QUARTER" DATA_FILE="$DATA_FILE" uv run jupyter nbconvert \
  --to notebook --execute optimizacion_sharpe.ipynb \
  --ExecutePreprocessor.timeout=1200 \
  --output-dir "outputs/${QUARTER}" --output "optimizacion_sharpe_${QUARTER}.ipynb"

echo "Done: outputs/${QUARTER}/"
ls "outputs/${QUARTER}"
