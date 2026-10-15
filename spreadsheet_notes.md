# Spreadsheet Notes

## Setup

- Spreadsheet tool: Google Sheets.
- Tabs created: `orders`, `products`, and `completed_orders`.
- Rows imported into `orders`: 90 data rows (plus the header).
- `products` occupies `A1:C10`, including the header.
- `order_month` was kept as Plain text so values remain like `2026-09`.
- Before creating `completed_orders`, the `orders` tab was filtered to `status = completed` and the visible rows were sorted by `amount` descending.
- The spare-cell XLOOKUP test used `Mystery Item` and displayed `UNKNOWN_ITEM`.

## Formulas

Assuming the q09 columns are A:J:

- `clean_first_name` in K2: `=PROPER(TRIM(C2))`
- `clean_last_name` in L2: `=PROPER(TRIM(D2))`
- `category` in M2: `=VLOOKUP(G2,products!$A$2:$C$10,2,FALSE)`
- `unit_price` in N2: `=XLOOKUP(G2,products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")`
- `revenue_calc` in O2: `=N2*H2`

All formulas were filled down through the 90 order rows.

## Completed-order aggregates

| Metric | Spreadsheet result |
|---|---:|
| COUNT | 63 |
| SUM | 346200 |
| AVERAGE | 5495.24 |
| MIN | 1100 |
| MAX | 15600 |

## Pivot 1 — Revenue by category and region

| category | East | North | South | West | Grand Total |
|---|---:|---:|---:|---:|---:|
| Apparel | 10600 | 19400 | 10000 | 37500 | 77500 |
| Electronics | 21400 | 73400 | 28700 | 18800 | 142300 |
| Home | 37500 | 26500 | 43800 | 18600 | 126400 |
| Grand Total | 69500 | 119300 | 82500 | 74900 | 346200 |

## Pivot 2 — Revenue and order count by month

| order_month | Sum of amount | Count of order_id |
|---|---:|---:|
| 2026-09 | 98300 | 19 |
| 2026-10 | 93100 | 20 |
| 2026-11 | 154800 | 24 |
| Grand Total | 346200 | 63 |

## Reconciliation

| Metric | Spreadsheet | Part A q05 | Match/Mismatch |
|---|---:|---:|---|
| COUNT | 63 | 63 | Match |
| SUM | 346200 | 346200 | Match |
| AVERAGE | 5495.24 | 5495.24 | Match |

## Data validation

- The three missing amounts are order IDs `1001`, `1010`, and `1064`. All three are pending orders, so their missing amounts do not enter completed-order revenue. They were preserved as blank rather than replaced with zero because the source amount is unknown and zero would falsely imply a measured amount.
- Numeric fields such as `order_id`, `customer_id`, `quantity`, `unit_price`, and `amount` were kept as numbers; `order_month` was intentionally kept as text.
- No duplicate `order_id` exists in the completed orders.
- The largest completed `amount` is INR 15,600. The tied order IDs are `1061`, `1065`, `1069`, and `1077`.
- Decision for the next analyst: keep raw source fields separate from cleaned fields and preserve the original missing amounts as blanks; do not overwrite source values during cleaning.

