# Big Billion Days Regional Performance Review

## Project summary

This project builds a traceable BBD analytics pipeline from SQL through spreadsheet cleaning, dashboard specification and AI-assisted verification. The three most important findings are: **North** is the strongest region with INR 119,300 in completed revenue; **Electronics** is the largest category with INR 142,300; and **November** is the strongest month with INR 154,800, including a sharp Home-category increase to INR 83,200. These findings reconcile to the same INR 346,200 completed-revenue total across the SQL, spreadsheet and dashboard layers.

## Tools

- SQL compiler: SQLite 3 / SQLite dialect.
- Spreadsheet: Google Sheets.
- Tableau Public: Not built; Part C is completed as the required written dashboard specification using the cleaned CSV.

## File index

| File | Part |
|---|---|
| `README.md` | Whole project / submission guide |
| `sql/00_schema_and_seed.sql` | Part A — seed schema and data |
| `sql/q01.sql` … `sql/q13.sql` | Part A — SQL reporting queries |
| `sql/d1_corrected.sql` | Part D — corrected AI query |
| `results/query_results.md` | Part A — query results and seed checks |
| `data/orders_enriched.csv` | Part A — full q09 order-level fact table |
| `data/orders_clean.csv` | Part B — completed, cleaned dataset |
| `docs/spreadsheet_notes.md` | Part B — formulas, aggregates, pivots, reconciliation and validation |
| `docs/dashboard_spec.md` | Part C — dashboard specification and business narrative |
| `docs/ai_log.md` | Part D — prompts, AI defect inspection and human verification |

## Key reconciliation numbers

- Completed orders: **63**
- Completed revenue: **INR 346,200**
- Average completed order value: **INR 5,495.24**
- Minimum completed order amount: **INR 1,100**
- Maximum completed order amount: **INR 15,600**
- Completed units sold: **106**

## Assumptions and choices

The brief allows a choice of free SQL compiler and spreadsheet tool, so SQLite 3 and Google Sheets were selected. The dashboard was not built in Tableau Public; the repository contains the precise `docs/dashboard_spec.md` specification permitted by the brief. Revenue is consistently defined as the sum of `amount` for completed orders only. Missing source amounts remain blank rather than being converted to zero.

## Submission

Commit the complete repository to the `main` branch and submit the public GitHub repository URL ending in `/tree/main`.
