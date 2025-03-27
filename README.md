# Kimia Farma Big Data Analytics Project Based Internship Program's Final Task

## Challenge
Sebagai seorang Big Data Analytics Intern di Kimia Farma, tugas Anda akan mencakup serangkaian tantangan yang memerlukan pemahaman mendalam tentang data dan kemampuan analisis. Salah satu proyek utama Anda adalah mengevaluasi kinerja bisnis Kimia Farma dari tahun 2020 hingga 2023.

Tools used: BigQuery, Google Looker Studio

<details>
  <summary> Berikut ini adalah Query yang saya gunakan </summary>
    ```
    CREATE TABLE kf_data.kf_tabel_analisa AS
    SELECT

    -- Data transaksi
    ft.transaction_id,
    ft.date,

    -- Data cabang
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,

    -- Data customer
    ft.customer_name,

    -- Data produk
    ft.product_id,
    p.product_name,
    
    -- Harga sebelum diskon (dari tabel produk)
    p.price AS actual_price,
    
    -- Persentase diskon dari transaksi
    ft.discount_percentage,
    
    -- Perhitungan persentase laba berdasarkan harga produk
    CASE
        WHEN p.price <= 50000 THEN 0.10
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    
    -- Perhitungan harga setelah diskon (nett_sales)
    p.price * (1 - ft.discount_percentage / 100) AS nett_sales,
    
    -- Perhitungan keuntungan bersih (nett_profit)
    (p.price * (1 - ft.discount_percentage / 100)) * 
        CASE
        WHEN p.price <= 50000 THEN 0.10
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        ELSE 0.30
        END AS nett_profit,
    
    -- Rating transaksi dari tabel transaksi
    ft.rating AS rating_transaksi

    FROM
    `kf_data.kf_final_transaction` ft

    -- Menggabungkan dengan tabel produk untuk mendapatkan nama produk dan harga asli
    JOIN
    `kf_data.kf_product` p
    ON
    ft.product_id = p.product_id

    -- Menggabungkan dengan tabel kantor cabang untuk mendapatkan rating cabang
    JOIN
    `kf_data.kf_kantor_cabang` kc
    ON
    ft.branch_id = kc.branch_id;


    -- Menampilkan hasil query di atas
    SELECT * FROM kf_data.kf_tabel_analisa;
    ```
</details>