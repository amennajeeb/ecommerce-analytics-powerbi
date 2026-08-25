# E-Commerce Analytics Dashboard

## Project Overview

This project analyzes an e-commerce business using SQL and Power BI to understand sales performance, customer behavior, marketing effectiveness, delivery performance, and product returns.

The project combines relational data from customers, products, orders, marketing, delivery, and returns into a four-page interactive Power BI dashboard.

## Business Objectives

The analysis was designed to answer questions such as:

- How is overall revenue and profit performing?
- Which products and categories perform best?
- Which customer segments generate the most value?
- Which customers are loyal, inactive, or at risk?
- Which marketing channels generate the strongest conversions?
- How efficiently is marketing spend being used?
- How well are orders being delivered on time?
- Why are customers returning products?
- Which products have the highest return rates?
- Which states contribute the most revenue and profit?

## Data Model

The project uses six core tables:

| Table | Purpose |
|---|---|
| `customers` | Customer demographics and signup information |
| `products` | Product, category, cost, and selling price information |
| `orders` | Orders, sales, profit, quantities, discounts, and status |
| `marketing` | Campaign, channel, spend, and conversion information |
| `delivery` | Dispatch, delivery, and delivery-status information |
| `returns` | Return records and return reasons |

The SQL schema defines relationships between customers and orders, products and orders, customers and marketing, orders and delivery, and orders and returns.

## Tools & Technologies

- **SQL / MySQL** — data preparation, validation, analysis, aggregations, joins, segmentation
- **Power BI** — interactive dashboard and data visualization
- **DAX** — calculated measures and KPI calculations
- **Figma** — dashboard layout and visual design planning

## SQL Analysis

The SQL analysis covers:

### Customer Analysis
- Overall orders, customers, revenue, profit, and average order value
- Top customers by revenue
- Customer order frequency
- Customer recency
- Customer revenue
- Customer segmentation
- Segment-level revenue and engagement

### Marketing Analysis
- Marketing spend by channel
- Campaign records
- Conversions
- Conversion rate
- Cost per conversion
- Customers reached by channel
- Delivered orders
- Revenue and profit by channel

### Product Analysis
- Monthly revenue and profit
- Top products
- Units sold
- Product revenue
- Product profit
- Category performance
- Profit margin
- Product return count
- Product return rate
- Category return rate
- State-level performance

### Returns & Operations Analysis
- Delivery status
- On-time versus delayed orders
- Delivery percentage
- Return count
- Return reasons
- Return percentage
- Delivery status versus return rate
- Returned orders with matching delivery records

## Customer Segmentation

Customers were segmented using order frequency, revenue, and recency.

| Segment | Definition |
|---|---|
| **VIP Active** | Recent customers with 15+ orders and ₹500K+ revenue |
| **Loyal** | Recent customers with 10+ orders |
| **High Value At Risk** | Customers inactive for more than 120 days with ₹400K+ revenue |
| **Inactive** | Customers inactive for more than 120 days |
| **Active** | Customers active within the last 60 days |
| **Needs Attention** | Customers who do not meet the other segment criteria |

These rules were implemented in SQL and then represented in the Power BI customer analytics dashboard.

## Power BI Dashboard

The final dashboard contains **4 pages**.

### Page 1 — Executive Overview

Provides a high-level view of the business using executive KPIs and performance visuals.

Focus areas:
- Revenue
- Profit
- Orders
- Customers
- Category performance
- Geographic performance
- Overall business trends

### Page 2 — Customer Analytics

Focuses on customer value, engagement, and customer segments.

Key analysis:
- Customer segments
- Average customer revenue
- Average orders
- Customer value vs engagement
- VIP customers
- High-value customers at risk
- Customers needing attention
- Inactive customers
- Customer action recommendations

### Page 3 — Marketing Performance

Analyzes marketing channels and campaign efficiency.

Key analysis:
- Marketing spend
- Marketing conversions
- Conversion rate
- Cost per conversion
- Revenue by channel
- Profit by channel
- Channel performance

### Page 4 — Operations & Returns

Focuses on delivery performance and product returns.

Key analysis:
- Delivery SLA
- On-time orders
- Delayed orders
- On-time percentage
- Return rate
- Return reasons
- Product return rate
- Highest-return products
- Category return performance

## Key KPIs

The dashboard includes measures such as:

- Total Revenue
- Total Profit
- Total Orders
- Total Customers
- Average Order Value
- Marketing Spend
- Marketing Conversions
- Conversion Rate
- Cost Per Conversion
- On-Time Delivery %
- Delayed Orders
- Total Returns
- Return Rate
- Product Return Rate
- Average Customer Revenue
- Average Customer Orders

## Example Business Insights

The analysis highlights several actionable areas:

### Customer Retention
High-value customers who have become inactive represent an important retention opportunity. The dashboard identifies these customers separately as **High Value At Risk**.

### VIP Customer Protection
VIP Active customers have high order frequency and high revenue contribution. These customers should receive retention-focused offers and personalized experiences.

### Marketing Optimization
Marketing channels can be compared using spend, conversions, conversion rate, cost per conversion, revenue, and profit to identify efficient channels and areas for optimization.

### Delivery Performance
The delivery analysis separates on-time and delayed orders, allowing the business to monitor service-level performance and identify potential operational issues.

### Return Reduction
Quality issues, damaged products, size/fit problems, changed minds, late delivery, and wrong items are analyzed separately so the business can prioritize return-reduction initiatives.

### Product Risk
Product-level return rate highlights products that may require quality, packaging, sizing, supplier, or product-description improvements.

## DAX

DAX measures were used in Power BI for dynamic KPIs and dashboard calculations, including:

```DAX
Total Revenue =
SUM(orders[Sales])
```

```DAX
On Time % =
DIVIDE(
    [On Time Orders],
    [On Time Orders] + [Delayed Orders],
    0
)
```

```DAX
Return Rate =
DIVIDE(
    [Total Returns],
    [Total Orders],
    0
)
```

```DAX
Product Return Rate =
DIVIDE(
    [Product Returns],
    [Product Orders],
    0
)
```

Additional measures were created for marketing performance, customer value, customer segments, profit, revenue, conversions, and operational KPIs.

## Project Structure

```text
Ecommerce Analytics Dashboard/
│
├── PowerBI/
│   └── Ecommerce_Analytics_Dashboard.pbix
│
├── SQL/
│   ├── 01_Customer_Analysis.sql
│   ├── 02_Marketing_Analysis.sql
│   ├── 03_Returns_Analysis.sql
│   └── 04_Product_Analysis.sql
│
├── Screenshots/
│   ├── page1_executive_overview.png
│   ├── page2_customer_analytics.png
│   ├── page3_marketing_performance.png
│   └── page4_operations_returns.png
│
└── Documentation/
    └── README.md
```

## Key Takeaway

This project demonstrates an end-to-end analytics workflow:

**Relational Data → SQL Analysis → Customer & Business Insights → DAX → Power BI Dashboard → Business Recommendations**

The goal is not only to visualize the data, but to turn operational and customer data into insights that can support decisions around retention, marketing allocation, delivery performance, and return reduction.

## Author

**Muhammed Amen Najeeb**

E-commerce Analytics Project  
SQL | Power BI | DAX
