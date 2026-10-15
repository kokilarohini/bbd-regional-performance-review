# AI Verification Log

## Scenario D1 — Five-part prompt for q13

### Role
You are a Business Analyst writing a production-ready SQL reporting query for the Big Billion Days regional sales dataset.

### Task
Write the q13 query that reports sales-rep performance against monthly target for completed orders only. Return `rep_name`, `order_month`, `monthly_target`, `revenue`, and `performance_tier`, grouped by rep, month and monthly target, and ordered by rep name then order month.

### Context
The SQL dialect used is SQLite. The real tables are:
- `reps(rep_id, rep_name, region, monthly_target)`
- `customers(customer_id, first_name, last_name, city, region, age, rep_id)`
- `orders(order_id, customer_id, item, quantity, amount, status, order_month)`

`customers.rep_id` joins to `reps.rep_id`, and `orders.customer_id` joins to `customers.customer_id`. Revenue means `SUM(amount)` for orders whose `status` is `completed`.

### Constraints
- Use completed orders only.
- `Below Target` when revenue is below `monthly_target`.
- `On Target` when revenue is at least `monthly_target` but below `1.1 * monthly_target`.
- `Above Target` otherwise.
- Do not use a `WITH` clause.
- Do not use stored procedures.
- Do not reference an aggregate alias inside `WHERE` or `GROUP BY`.
- Write the aggregate expression directly inside the tier logic.

### Format
Return raw SQL only, with inline comments. No Markdown explanation.

## Scenario D1 — Defect inspection

| Defect | Classification | Correct fix |
|---|---|---|
| `sales` table does not exist in the real schema | fake method/function | Use the real `orders` table and join `customers` to obtain region. |
| `region_name` and `total_sales` do not exist | fake method/function | Use `c.region` and `o.amount`. |
| `WHERE SUM(total_sales) > 80000` places an aggregate in `WHERE` | logic error | Put the aggregate condition in `HAVING SUM(o.amount) > 80000` after grouping. |
| “North ... grew 38% month over month” is not supported by the query/data | phantom statistic | Calculate the month-specific values from q11; North is INR 53,500 in 2026-09 and INR 41,300 in 2026-10, giving -22.8%, not +38%. |

## Scenario D1 — Corrected query

Saved as `sql/d1_corrected.sql`:

```sql
-- Corrected Scenario D1: regions with completed revenue above INR 80,000.
SELECT c.region,
       SUM(o.amount) AS revenue
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.region
HAVING SUM(o.amount) > 80000
ORDER BY revenue DESC;
```

Expected/run result:

| region | revenue |
|---|---:|
| North | 119300 |
| South | 82500 |

North month-over-month change from 2026-09 to 2026-10:

`(41,300 - 53,500) / 53,500 × 100 = -22.8%` rounded to one decimal place.

The assistant's +38% growth claim is contradicted by the q11 data.

## Scenario D1 — Human-in-the-loop protocol

### Specification
I defined the real schema, the revenue definition, the completed-order requirement, and the INR 80,000 threshold before accepting any generated query or business claim.

### Execution
I ran the corrected SQL against the supplied seed and checked that it returned exactly two regions above the threshold: North at INR 119,300 and South at INR 82,500.

### Inspection
I inspected the original answer and found an invented `sales` table, invented column names, an aggregate inside `WHERE`, and a month-over-month growth statement not produced by the query.

### Verification
I compared the regional result with the q11 region/month data. North moved from INR 53,500 in September to INR 41,300 in October, which is -22.8%.

### Decision
Reject the original answer because its schema is not the real schema, its aggregate filter is logically invalid, and its 38% claim is contradicted by the data. Accept the corrected version because it uses the real tables, completed-order revenue, `HAVING`, the required threshold, and returns the verified North and South totals.

## Scenario D2 — Five-part prompt

### Role
You are a spreadsheet troubleshooting analyst.

### Task
Find the root cause of a VLOOKUP error and provide the repaired formula.

### Context
The `products` tab occupies `A1:C10`. Row 1 is the header. Product item names are in column A and unit prices are in column C. On the `orders` tab, cell `G2` contains the item text `Smart Watch`, but there is a leading space before the first letter. The current formula is `=VLOOKUP(G2, $A$2:$C$10, 3, FALSE)`. The expected behaviour is to return the Smart Watch unit price from the products table.

### Constraints
Keep the VLOOKUP exact-match behaviour. Do not change the product table. The repaired formula must handle the leading space in the lookup key.

### Format
State the root cause in one sentence and provide the repaired formula.

**Root cause:** The lookup key in `G2` contains a leading space, so exact-match VLOOKUP does not see it as identical to `Smart Watch` in the products table.

**Repaired formula:**

`=VLOOKUP(TRIM(G2), products!$A$2:$C$10, 3, FALSE)`

## Skeptical-analyst check for the first Part C recommendation

### Prompt

Act as a skeptical business analyst. Challenge my recommendation to allocate a promotional push to North Electronics. Do not accept correlation as proof of cause. Identify the assumptions that must be true for the recommendation to work, request the specific figures or checks needed to test those assumptions, and distinguish evidence of demand from evidence of promotion effectiveness. Use only the supplied BBD dataset and clearly state what cannot be established from this observational data.

### Unstated assumptions and checks

1. **Assumption: North Electronics' high revenue represents strong underlying demand rather than a temporary mix effect.**
   - Check: North Electronics revenue is INR 73,400 across the completed-order period. Compare its monthly values and order counts; a sustained or repeated contribution would strengthen the assumption, while a one-month spike would weaken it.

2. **Assumption: North has enough unit demand to justify additional promotion, rather than revenue being driven only by a few high-value orders.**
   - Check: compare North Electronics revenue with its units sold and order count in the cleaned data. The recommendation should be stronger if both revenue and units are substantial.

3. **Assumption: A promotional push would cause incremental revenue rather than simply shifting sales that would have happened anyway.**
   - Check: there is no randomized promotion/control variable in this dataset. Therefore, compare future North Electronics revenue and units against the current baseline of INR 73,400 and document that causal lift cannot be proven from this dataset alone.

4. **Assumption: Stock availability will not constrain the response to promotion.**
   - Check: inspect quantity and order patterns for North Electronics and monitor future stock-outs. A promotion without sufficient inventory could fail even when demand is strong.
