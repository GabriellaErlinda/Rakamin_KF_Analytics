WITH provinsi_sales AS (
    SELECT
        provinsi,
        SUM(nett_sales) AS total_nett_sales,
        ROW_NUMBER() OVER (ORDER BY SUM(nett_sales) DESC) AS rank
    FROM
        kf_data.kf_tabel_analisa
    GROUP BY
        provinsi
)
SELECT
    provinsi,
    total_nett_sales,
    rank
FROM
    provinsi_sales
WHERE
    rank <= 10;
