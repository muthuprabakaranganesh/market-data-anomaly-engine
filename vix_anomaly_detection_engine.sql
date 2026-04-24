
WITH VixData AS (
    SELECT 
        [date],
        [close] AS current_price,
        LAG([close], 1) OVER (ORDER BY [date] ASC) AS previous_price
    FROM 
        IndiaVix 
)

SELECT 
    [date],
    current_price,
    previous_price,
    ROUND(((current_price - previous_price) / NULLIF(previous_price, 0)) * 100, 2) AS variance_percentage
FROM 
    VixData
WHERE 
    ((current_price - previous_price) / NULLIF(previous_price, 0)) * 100 >= 10.0
    OR 
    ((current_price - previous_price) / NULLIF(previous_price, 0)) * 100 <= -10.0
ORDER BY 
    variance_percentage DESC;