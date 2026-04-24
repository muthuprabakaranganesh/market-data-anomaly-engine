# Market Feed Anomaly Detection Engine

## The Business Problem
Financial institutions ingest millions of rows of high-frequency market data daily. A broken feed, a shifted decimal, or an unflagged macroeconomic panic can corrupt downstream analytics and risk models. Manual verification of this data is a massive operational bottleneck.

## The Solution
I engineered an automated T-SQL pipeline designed to replace manual QA workflows. This engine scans high-frequency (15-minute interval) intraday data for the India VIX (Volatility Index) and automatically isolates extreme variance events.

## Technical Architecture
* **Database:** SQL Server (T-SQL)
* **Core Logic:** Utilized Common Table Expressions (CTEs) to stage the data and the `LAG()` Window Function to perform rolling, time-series variance calculations without aggregating or grouping the raw rows.
* **Tripwire Mechanism:** Implemented a hard filter to flag only anomalies exceeding a ±10% intraday variance threshold, utilizing `NULLIF` to prevent division-by-zero database crashes during static price periods.

## Project Results
The engine successfully processed tens of thousands of raw 15-minute intervals and accurately isolated historically significant market panics without human intervention, including:
* **April 7, 2025 (09:15 AM):** +51.27% gap-up spike (Overnight macroeconomic panic)
* **March 13, 2020 (10:30 AM):** +33.01% intraday spike (COVID-19 liquidity halt)

By automating this logic, the pipeline reduces manual data hunting to zero, delivering a sterile "hit list" of corrupted or highly volatile rows directly to risk managers.
