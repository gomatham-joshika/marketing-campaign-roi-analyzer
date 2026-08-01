-- 1. Overall performance summary
SELECT
    COUNT(*) AS total_campaigns,
    ROUND(SUM(Acquisition_Cost), 2) AS total_spend,
    ROUND(SUM(Revenue_Generated), 2) AS total_revenue,
    ROUND(SUM(Revenue_Generated) / SUM(Acquisition_Cost), 2) AS overall_roi,
    ROUND(AVG(Conversion_Rate_Pct), 2) AS avg_conversion_rate_pct,
    ROUND(AVG(CTR_Pct), 2) AS avg_ctr_pct
FROM campaigns;

-- 2. ROI by channel
SELECT Channel_Used, COUNT(*) AS campaign_count,
    ROUND(SUM(Acquisition_Cost), 2) AS total_spend,
    ROUND(SUM(Revenue_Generated), 2) AS total_revenue,
    ROUND(AVG(ROI), 2) AS avg_roi
FROM campaigns GROUP BY Channel_Used ORDER BY avg_roi DESC;

-- 3. ROI by campaign type
SELECT Campaign_Type, COUNT(*) AS campaign_count, ROUND(AVG(ROI), 2) AS avg_roi
FROM campaigns GROUP BY Campaign_Type ORDER BY avg_roi DESC;

-- 4. Top 10 campaigns by ROI
SELECT Campaign_ID, Company, Campaign_Type, Channel_Used,
    Acquisition_Cost, ROI, Revenue_Generated, Net_Profit
FROM campaigns ORDER BY ROI DESC LIMIT 10;

-- 5. Monthly spend/revenue trend
SELECT Year, Month, Month_Name,
    ROUND(SUM(Acquisition_Cost), 2) AS total_spend,
    ROUND(SUM(Revenue_Generated), 2) AS total_revenue,
    ROUND(AVG(ROI), 2) AS avg_roi
FROM campaigns GROUP BY Year, Month, Month_Name ORDER BY Year, Month;

-- 6. Customer segment performance
SELECT Customer_Segment, COUNT(*) AS campaign_count,
    ROUND(AVG(ROI), 2) AS avg_roi,
    ROUND(AVG(Engagement_Score), 2) AS avg_engagement,
    ROUND(SUM(Revenue_Generated), 2) AS total_revenue
FROM campaigns GROUP BY Customer_Segment ORDER BY avg_roi DESC;

-- 7. ROI bucket distribution
SELECT ROI_Bucket, COUNT(*) AS campaign_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM campaigns), 2) AS pct_of_total,
    ROUND(SUM(Acquisition_Cost), 2) AS total_spend
FROM campaigns GROUP BY ROI_Bucket ORDER BY campaign_count DESC;