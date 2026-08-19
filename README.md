# Market Analysis – Retail Customer & Product Analytics

## Project Overview

This project analyzes retail grocery transaction data to understand customer purchasing behavior, product performance, reorder patterns, order trends, and departmental performance.

The analysis combines **MySQL, Excel, and Power BI** to transform transactional data into actionable business insights. SQL was used for data exploration and analytical queries, while Power BI was used to independently analyze the cleaned data and create interactive visualizations and a summary dashboard.

The project was completed as part of the **DataMites Data Analytics Internship – Client Project (CDACL-006)**.

---

## Project Objectives

The key objectives of the analysis were to:

- Identify top-performing products, aisles, and departments.
- Analyze product reorder behavior and customer loyalty.
- Understand order patterns by day and hour.
- Evaluate customer ordering frequency and average basket size.
- Identify high-demand products and customer segments.
- Analyze customer purchasing behavior and product performance.
- Generate actionable recommendations for inventory management, marketing, and customer retention.

---

## Dataset Overview

The project uses a relational retail dataset consisting of five tables:

| Table | Description |
|---|---|
| `orders` | Customer order information, order sequence, day, hour, and days since previous order |
| `order_products_train` | Products purchased within each order and their reorder status |
| `products` | Product names, aisle IDs, and department IDs |
| `aisles` | Product aisle information |
| `departments` | Product department information |

### Table Relationships

- Orders → Order Products using `order_id`
- Order Products → Products using `product_id`
- Products → Aisles using `aisle_id`
- Products → Departments using `department_id`

---

## Tools & Technologies

- **MySQL** – Data exploration, joins, aggregations, subqueries, CTEs, window functions, and analytical queries
- **Power BI** – Data visualization, interactive analysis, KPIs, and dashboard development
- **Power Query** – Data preparation and transformation
- **Microsoft Excel** – Cleaning and correcting affected records in the Products table

---

## Data Cleaning & Preparation

During data exploration, data-quality issues were identified in the `products` table.

The original project database was **read-only**, so the Products table was exported for preprocessing.

The cleaning process included:

- Identifying overlapping product information
- Correcting missing Product IDs and inconsistent product records
- Separating combined product information
- Using Excel formulas to reconstruct affected records
- Validating Product IDs and product information
- Checking for missing values and duplicate Product IDs
- Verifying relationships between Products, Aisles, and Departments

The cleaned Products table was then imported into **MySQL** and **Power BI** for analysis.

---

## Analysis Performed

The project answered 20 analytical questions covering:

### Product & Department Analysis

- Top 10 aisles by number of products
- Distribution of products across departments
- Products with the highest reorder rates
- Top 10 most ordered products
- Most reordered products within each department
- Products reordered more than once
- Reorder rates across aisles
- Product distribution across aisles and departments

### Customer Analysis

- Number of unique customers
- Average number of days between customer orders
- Customers within each department
- Top customers based on ordering frequency

### Order Analysis

- Peak ordering hours
- Order volume by day of the week
- Average products per order
- Hourly order patterns
- Distribution of order sizes
- Average order size by day of the week

---

## Key KPIs

| KPI | Result |
|---|---:|
| Total Orders | 1,048,575 |
| Total Products | 104,879 |
| Total Departments | 21 |
| Total Aisles | 134 |
| Unique Customers | 63,100 |
| Average Products per Order | 10.53 |
| Most Ordered Product | Banana |
| Highest Customer Department | Produce |

---

## Key Insights

### Customer Purchasing Behavior

- Customer ordering activity is highest during the afternoon, with **2:00 PM recording the highest order volume**.
- Customers purchase an average of **10.53 products per order**.
- Orders containing approximately **4–8 products** are among the most common basket sizes.
- More than **20,000 products** were reordered more than once, indicating substantial repeat-purchase behavior.
- The most active customers completed **100 orders each**, identifying a valuable customer segment for retention strategies.

### Product Performance

- **Banana** is the most frequently ordered product.
- Other high-demand products include **Bag of Organic Bananas, Organic Strawberries, Organic Baby Spinach, and Organic Whole Milk**.
- **Produce** attracts the highest number of unique customers.
- Essential grocery categories such as Produce, Dairy & Eggs, and Beverages demonstrate strong customer engagement.
- High reorder rates are concentrated in essential-product aisles including Milk, Fresh Fruits, Eggs, and Water/Seltzer/Sparkling Water.

An important finding is that **a larger product assortment does not necessarily result in greater customer demand**. Personal Care contains the largest product assortment, while Produce generates stronger customer engagement.

---

## Business Recommendations

Based on the analysis:

1. **Prioritize High-Demand Products**  
   Maintain sufficient inventory of frequently purchased and reordered products to minimize stockouts.

2. **Develop Personalized Promotions**  
   Use customer purchasing history to provide targeted discounts, digital coupons, and product recommendations.

3. **Strengthen Customer Loyalty Programs**  
   Reward frequent customers through points, exclusive offers, and personalized incentives.

4. **Optimize Inventory Planning**  
   Align inventory availability with peak shopping periods and high-demand departments.

5. **Improve Product Visibility**  
   Give frequently purchased products stronger visibility through merchandising and promotional placement.

6. **Increase Basket Value**  
   Use cross-selling and product-bundling strategies to encourage complementary purchases.

7. **Review Low-Performing Categories**  
   Evaluate assortment, pricing, and promotional strategies for categories with comparatively low customer activity.

---

## My Contribution

This was a collaborative DataMites client project.

My individual contribution included:

- Performing the **complete SQL analysis** for the project
- Writing and validating the analytical most SQL queries
- Applying joins, aggregations, CTEs, window functions, filtering, grouping, and ranking techniques
- Contributing to data validation and interpretation of analytical results
- Preparing the **complete project report**
- Contributing to the project presentation and visualization documentation

---

## Repository Structure

```text
Market-Analysis/
│
├── README.md
│
├── SQL/
│   └── Market_Analysis.sql
│
├── PowerBI/
│   └── Market_Analysis.pbix
│
├── Dashboard/
│   └── Customer Purchasing Behaviour.png
│   └── Market Analysis Executive Dashboard.png
│   └── Product Performance Dashbaord.png
│
├── Report/
│   └── Market Analysis Project Report.pdf
│
└── Presentation/
    └── Market_Analysis.pptx
