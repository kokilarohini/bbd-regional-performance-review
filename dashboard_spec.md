# Dashboard Specification

## Data source

Connect the dashboard to `data/orders_clean.csv`.

| Field | Type |
|---|---|
| order_id | Dimension |
| order_month | Dimension |
| clean_first_name | Dimension |
| clean_last_name | Dimension |
| region | Dimension |
| rep_name | Dimension |
| item | Dimension |
| category | Dimension |
| unit_price | Measure |
| quantity | Measure |
| amount | Measure |
| revenue_calc | Measure |
| status | Dimension |

There are 9 Dimensions and 4 Measures. `order_id` is treated as a Dimension because it is an identifier, not a value to add up.

## KPI cards

1. **Total Revenue** — `SUM(amount)` = **INR 346,200**.
2. **Total Units Sold** — `SUM(quantity)` = **106 units**.

The Total Revenue card equals Part A q05 `total_revenue` of INR 346,200.

## Chart sheets

### Revenue by Region

- Chart type: horizontal bar chart.
- Rows: `region`.
- Columns: `SUM(amount)`.
- Colour: `region`.
- Reason: bars make regional revenue differences easy to compare and rank.

| region | revenue |
|---|---:|
| North | 119300 |
| South | 82500 |
| West | 74900 |
| East | 69500 |

### Revenue by Category

- Chart type: horizontal bar chart.
- Rows: `category`.
- Columns: `SUM(amount)`.
- Colour: `category`.
- Reason: a bar chart clearly compares the contribution of the three categories.

| category | revenue |
|---|---:|
| Electronics | 142300 |
| Home | 126400 |
| Apparel | 77500 |

### Revenue Trend by Month and Category

- Chart type: line chart.
- Rows: `SUM(amount)`.
- Columns: `order_month`.
- Colour: `category`.
- Reason: lines show how each category changes across the three months.

| order_month | category | revenue |
|---|---|---:|
| 2026-09 | Apparel | 24700 |
| 2026-09 | Electronics | 43000 |
| 2026-09 | Home | 30600 |
| 2026-10 | Apparel | 30600 |
| 2026-10 | Electronics | 49900 |
| 2026-10 | Home | 12600 |
| 2026-11 | Apparel | 22200 |
| 2026-11 | Electronics | 49400 |
| 2026-11 | Home | 83200 |

### Region x Category Detail

- Chart type: text table.
- Rows: `region`.
- Columns: `category`.
- Text/value: `SUM(amount)`.
- Colour: none.
- Reason: a text table gives the exact cross-tab values needed for operational decisions.

| region | Apparel | Electronics | Home |
|---|---:|---:|---:|
| East | 10600 | 21400 | 37500 |
| North | 19400 | 73400 | 26500 |
| South | 10000 | 28700 | 43800 |
| West | 37500 | 18800 | 18600 |

## Dashboard layout

From top to bottom:

1. KPI cards in a horizontal container.
2. `category` filter directly below the KPI cards in the top band.
3. Revenue Trend by Month and Category in a full-width horizontal container.
4. Revenue by Region and Revenue by Category in a horizontal container with the two comparison charts side by side.
5. Region x Category Detail at the bottom in a full-width horizontal container.

Use a vertical outer container for the full dashboard. Use horizontal containers for the KPI row and comparison-chart row.

The `category` filter is applied to all four worksheets using this data source. When a user clicks a bar in Revenue by Region with **Use as Filter** switched on, the trend chart, category chart and detail table update to show only the selected region.

## Insight and recommendation narrative

### Visualization summary

The dashboard shows INR 346,200 of completed-order revenue across 106 units. North is the highest-revenue region at INR 119,300, Electronics is the largest category at INR 142,300, and November is the strongest month at INR 154,800. The trend view also shows a major November increase in Home revenue.

### Summary analysis

1. **North leads the regions.** North generated INR 119,300, compared with INR 69,500 in East, a difference of INR 49,800. North is therefore the strongest regional revenue base in the completed-order data.
2. **Electronics is the largest category.** Electronics generated INR 142,300, ahead of Home at INR 126,400 and Apparel at INR 77,500. North Electronics alone contributed INR 73,400.
3. **November is the strongest month.** Revenue increased from INR 98,300 in September to INR 154,800 in November, a rise of about 57.5%. The main November category change is Home, which reached INR 83,200 versus INR 12,600 in October.

### Recommendations

1. **North + Electronics — promotional push.** Allocate a focused promotional budget to North Electronics because it generated INR 73,400, the single largest region-category contribution. Watch North Electronics monthly revenue and units sold to judge whether the promotion lifts both value and volume.
2. **South + Home — stock and promotion support.** Increase Home promotion and stock readiness in South because South Home generated INR 43,800, the highest Home contribution among the four regions. Watch South Home revenue and order count after the intervention.
3. **West + Apparel — protect the strongest local category.** Prioritise Apparel availability and targeted offers in West because West Apparel generated INR 37,500, the highest West category contribution. Watch West Apparel revenue and units sold to confirm that stock and promotion changes improve performance.

## Reconciliation

| Measure | Value |
|---|---:|
| Total Revenue KPI | 346200 |
| Sum of Revenue by Region | 346200 |
| Sum of Revenue by Category | 346200 |
| Part B pivot grand total | 346200 |
