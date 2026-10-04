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

## Running with the actual FinSimCo portfolio

Set these as environment variables when running `./run_quarter.sh`:

| Variable | Meaning |
|---|---|
| `NAV` | Actual equity from FinSimCo (stocks + cash − loan). Without it, equity is estimated |
| `LEVERAGE` | Gross exposure / equity (2.0 default, 1.0 = no loan) |
| `MARGIN_RATE` | Loan interest rate shown in FinSimCo |
| `TRADING_COST` | Cost per $ traded; the optimizer starts from current holdings and only trades when it pays (0.5% default) |
| `HOLD_LOSERS` | `1` (default) never sells a position below its cost basis |
| `STRATEGY` | `A` long-only levered (default), `B` long/short |

Current holdings go in `data/holdings_<Q>.csv` (Ticker, Shares, Cost basis), copied from the Portfolio tab.
News for each quarter goes in `data/news.csv`.
Example: `NAV=147170000 LEVERAGE=1.0 MARGIN_RATE=0.0456 ./run_quarter.sh Q4`

Final report of the game (Spanish): `informe_finsimco.pdf`.
