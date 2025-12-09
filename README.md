# web-analytics-funnel
Beginner website analytics project

# E-commerce Clickstream Funnel & Customer Insights (SQL-First)

## Overview
This project analyzes real e-commerce clickstream events to understand how shoppers move through the purchase funnel, where they drop off, what drives revenue, and what customer segments are worth different marketing strategies.  

I used SQL (DuckDB in Google Colab) to build a funnel from raw events (`view → cart → purchase`), identify revenue concentration across products/brands/categories, flag “high-interest / low-conversion” products, and segment customers using RFM.

---

## Dataset
**Source:** Kaggle — *eCommerce events history in electronics store*  
**Fields used:**  
- `event_time`  
- `event_type` (view, cart, purchase)  
- `product_id`  
- `category_code`  
- `brand`  
- `price`  
- `user_id`  
- `user_session`

---

## Business Questions
1. What is the conversion rate from **view → cart → purchase**?  
2. Where is the **largest drop-off** in the funnel?  
3. What products, brands, and categories drive most revenue?  
4. Which products get views but **fail to convert**?  
5. What customer segments exist based on Recency/Frequency/Monetary value, and how should marketing treat them differently?

---

## Methods (SQL-first)
- Loaded CSV into **DuckDB** inside Google Colab  
- Built **session-level funnels** from raw event streams  
- Computed conversion KPIs + cart abandonment  
- Ranked products/brands/categories by purchases and revenue  
- Identified **high-view / low-purchase** products as experimentation targets  
- Built **RFM segmentation** and summarized segment value

---

## Key Results

### Funnel Performance
| Step | Sessions | Rate |
|---|---:|---:|
| Viewed a product | 488,361 | — |
| Added to cart | 41,271 | **8.45%** view → cart |
| Purchased | 24,344 | **58.99%** cart → purchase |
| Overall | — | **4.98%** view → purchase |

**Interpretation:**  
The **main leak is View → Cart**. Once users add to cart, they convert strongly. This points to friction or hesitation **on product pages / merchandising**, not checkout.

---

### Time to Purchase
- **Median time-to-purchase:** **4 minutes**  
- **Average time-to-purchase:** **532 minutes (~9 hours)**  

**Interpretation:**  
There are **two shopper modes**:
1. **Fast-intent buyers** who purchase almost immediately  
2. A smaller group who browse, leave, and return later (long-tail behavior)

This supports a two-track marketing approach: **onsite persuasion + remarketing.**

---

### Cart Abandonment
- **Cart sessions:** 41,271  
- **Abandoned carts:** 20,509  
- **Abandonment rate:** **49.69%**

**Interpretation:**  
About half of high-intent carts don’t complete checkout — a meaningful pool of **recoverable revenue**.

---

### Revenue Drivers
**Top category by far:**  
- `computers.components.videocards`  
  - **6,888 purchases**
  - **$2.6M revenue**

**Top revenue brands:**  
1. **MSI** — 1,788 purchases, **$643k revenue**  
2. **Gigabyte** — 1,741 purchases, **$556k revenue**  
3. **Palit** — 1,077 purchases, **$484k revenue**  
4. **Asus** — 1,261 purchases, **$330k revenue**  
5. **Sapphire** — 917 purchases, **$306k revenue**

**Interpretation:**  
Demand is **GPU-led** and revenue is concentrated in a small set of brands. These should anchor both marketing spend and onsite merchandising.

---

### High-Interest / Low-Conversion Products
I identified products with meaningful view volume (100–300+ views) but **zero purchases**.  

**Interpretation:**  
These are prime A/B test targets — users are interested enough to click, but something prevents carting/purchasing. Possible causes:
- pricing shock without context
- unclear specs/compatibility
- low trust (few reviews, weak warranty/shipping info)
- mismatch between expectation and product page

---

### Customer Segmentation (RFM)
| Segment | Users | Avg Orders | Avg Spend |
|---|---:|---:|---:|
| **Churn Risk** | 16,557 | 1.73 | $213.53 |
| **New / Promising** | 4,510 | 1.51 | $275.40 |
| **VIP / Loyal** | 237 | 8.27 | $1,468.33 |

**Interpretation:**  
Value is highly skewed. A tiny VIP group buys **~8× more often** and spends **5–7× more** than everyone else. Retention and loyalty could dramatically increase revenue.

---

## Recommendations

### 1) Fix the View → Cart Leak (Highest ROI)
- Run product-page experiments on high-view / low-conversion SKUs:
  - stronger “Add to cart” placement or sticky CTA
  - price framing (compare to alternatives, “best value” tag)
  - clearer specs + compatibility guidance
  - trust boosters (reviews, warranty, shipping/returns above the fold)

**Creative twist:**  
Add a **“Build your PC” compatibility badge** for GPUs/CPUs/motherboards (even a simple rules-based label). It reduces anxiety and could lift cart rate for technical items.

---

### 2) Recover Abandoned Carts
- Email/SMS reminders within **1–3 hours**
- Retargeting ads within **24–48 hours**
- Incentives only for price-elastic products (avoid training users to wait for discounts)

**Creative twist:**  
Use “You’re 1 step away from finishing your build” messaging for carted components — it speaks to identity, not just price.

---

### 3) Double-Down on GPU Category Dominance
- Treat video cards as the homepage + paid “hero”
- Create SEO buying guides:  
  “Best GPUs for 1080p / 1440p / streaming / AI workloads”
- Bundle GPU + motherboard + PSU for higher AOV

**Creative twist:**  
Launch a rotating **“GPU Drop Calendar”** (weekly featured models). Even if inventory is stable, the perception of scarcity can boost urgency.

---

### 4) Protect Branded Demand
- Maintain strong branded search/shopping coverage for top brands  
- Create “shop by brand” category hubs  
- Highlight brand-specific perks (warranty length, performance reputation)

---

### 5) Segment-Based Lifecycle Marketing
- **VIP / Loyal:**  
  loyalty perks, early access to new GPUs, bundles, extended warranty upsells  
- **New / Promising:**  
  nurture sequences + “next best product” recs (e.g., accessories after first purchase)  
- **Churn Risk:**  
  win-back campaigns after 30+ inactive days; retarget with category they last viewed

**Creative twist:**  
For churn-risk users, test a **“price-watch / notify me” flow** instead of a straight discount. It keeps them engaged without margin loss.

---

## Tools
- SQL via **DuckDB**
- Google Colab
- pandas (light use for displaying results)
- matplotlib for simple visuals

---

## Repo Structure
