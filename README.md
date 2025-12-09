# web-analytics-funnel
Beginner website analytics project
# Web Analytics Funnel & Landing Page Performance

## Objective
Analyze website user behavior to identify funnel drop-offs and evaluate landing page effectiveness.

## Dataset
Source: <link or description>  
Rows: X sessions / Y events  
Time range: YYYY-MM-DD to YYYY-MM-DD

## Key Questions
1. What is the overall conversion rate?
2. Which funnel step has the biggest drop-off?
3. Which landing pages drive the best conversions?
4. How do results differ by device and channel?

## Methods
- Data cleaning and sessionization
- Funnel step mapping
- KPI computation
- Segmentation by device/channel
- Visualization and insight generation

## Results (Top Insights)
- Overall conversion rate: X%
- Largest drop-off: Step A → Step B (–Y%)
- Best landing page: /page (CR = X%, low bounce)
- Weakest landing page: /page (high traffic, low CR)

## Recommendations
1. Improve Step A → B with <specific idea>.
2. Run A/B test on /page focused on <headline/CTA>.
3. Shift budget toward <channel> due to higher quality traffic.

## How to Run
pip install -r requirements.txt  
Open notebooks in order:
1. notebooks/01_cleaning.ipynb
2. notebooks/02_funnel_analysis.ipynb
3. notebooks/03_landing_page_analysis.ipynb
