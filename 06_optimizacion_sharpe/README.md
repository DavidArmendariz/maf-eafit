# Max Sharpe portfolio optimization (FinSimCo)

Runs the same optimization each quarter on new historical prices.

## Each quarter

1. Save the new price file as `data/Historical Data Q2.xlsx` (use the quarter label).
   Format: first column `Date`, one column per ticker with daily prices. Tickers can change between quarters.
2. Run:
   ```bash
   ./run_quarter.sh Q2
   ```
   Or with a file that has another name: `./run_quarter.sh Q2 "data/my_file.xlsx"`
3. Results land in `outputs/Q2/`:
   - `resultados_sharpe_Q2.xlsx`: parameters, summary, weights, leverage options, change vs. Q1, asset stats, covariance
   - `optimizacion_sharpe_Q2.ipynb`: executed notebook with all tables and charts
   - `frontier.png`, `weights_max_sharpe.png`, `leverage.png`

## Parameters

Set at the top of `optimizacion_sharpe.ipynb` (parameters cell):

| Parameter | Default | Meaning |
|---|---|---|
| `RF` | 4% | Risk-free rate |
| `LEVERAGE` | 2.0 | Max gross exposure / capital |
| `MARGIN_RATE` | `RF` | Cost of borrowing cash |
| `SHORT_REBATE` | `RF` | Interest earned on short proceeds |
| `BORROW_FEE` | 0.5% | Fee to borrow shares (placeholder, use broker rate) |
| `MAX_MISSING` | 30% | Tickers with more missing prices than this are dropped |

Missing prices are filled with the previous row's value.
