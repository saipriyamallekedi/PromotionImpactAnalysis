# PromotionImpactAnalysis
This GitHub repository contains a comprehensive analysis and insights into the promotional campaigns conducted by AtliQ Mart during Diwali 2023 and Sankranti 2024 across all 50 supermarkets in the southern region of India. The repository includes metadata, recommended insights, ad-hoc requests, and the dataset necessary for the analysis.

The dataset is organized into four CSV files:

dim_campaigns: Information on promotional campaigns.
          campaign_id: Unique identifier for each campaign.
          campaign_name: Descriptive name (e.g., Diwali, Sankranti).
          start_date: Campaign start date (DD-MM-YYYY).
          end_date: Campaign end date (DD-MM-YYYY).
          
dim_products: Details about products featured in campaigns.
           product_code: Unique code for product identification.
           product_name: Full product name, including brand and specifics.
           category: Classification into broader categories (e.g., Grocery & Staples, Home Care).
           
dim_stores: Information about store locations
           store_id: Unique identifier for each store.
           city: The city where the store is located, indicating the geographical market.

fact_events: Sales event data, capturing the impact of promotions.

          event_id: Unique identifier for each sales event.
          store_id: Refers to the store where the event occurred, linked to dim_stores.
          campaign_id: Indicates the campaign under which the event was recorded, linked to dim_campaigns.
          product_code: Code of the product involved in the sales event, linked to dim_products.
          base_price: The standard price of the product before any promotional discount.
          promo_type: The type of promotion applied (e.g., percentage discount, BOGOF, cashback).
          quantity_sold(before_promo): Number of units sold in the week preceding the campaign start, serving as a baseline.
          quantity_sold(after_promo): Quantity sold after the promotion was applied.

Note:
The database named retail_events_db encompasses all the tables mentioned above, facilitating SQL queries to derive insights and answer critical business questions.

Objective:
To provide a comprehensive analysis, design a user-friendly dashboard, and deliver actionable insights to Sales Director Bruce Haryali for informed decision-making in future promotional periods. The repository includes metadata, recommended insights, ad-hoc requests, and the necessary dataset for thorough analysis.
