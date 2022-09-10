-- KPIM SQL Project --

-- Question 1
SELECT * 
FROM city
WHERE name = N'Thái Bình' -- TBH

-- Question 2
SELECT * 
FROM city
WHERE code = 'HTH' -- Hà Tĩnh

-- Question 3
SELECT c.name,r.name 
FROM city c, sub_region r
WHERE c.sub_region_id = r.id and r.name = N'Đồng bằng sông Hồng'-- 3

-- Question 4
SELECT * 
FROM city
WHERE name LIKE N'Quảng%' -- 5

-- Question 5
SELECT count(*) as number_provine_DBSH_DBSCL
FROM city c, sub_region r
WHERE c.sub_region_id = r.id and (r.name = N'Đồng bằng sông Hồng' or r.name = N'Đồng bằng sông Cửu Long') --24

SELECT count(*) as number_provine_DBSH
FROM city c, sub_region r
WHERE c.sub_region_id = r.id -- 63

SELECT cast (24 as float) / cast( 63 as float) --38%

-- Question 6
SELECT c.name,s.name,r.name 
FROM city c, sub_region s, region r
WHERE c.sub_region_id = s.id and s.region_id=r.id and r.name = N'Miền Trung'--  19

-- Question 7
SELECT d.id, d.name, count(*) number_stores
FROM store s , district d
WHERE s.district_id=d.id
GROUP BY d.id,d.name
ORDER BY number_stores desc --Hoang mai HN

-- Question 8
SELECT ward_id, count(*)  
FROM store
GROUP BY ward_id
HAVING count(*) >10 --7

-- Question 9
SELECT a.district_id,d.name, a.store/b.ward as ratio
FROM
	(SELECT district_id, CAST(COUNT(*) AS FLOAT) as store  
	FROM store
	GROUP BY district_id) a,

	(SELECT district_id, CAST(COUNT(*) AS FLOAT) as ward
	FROM ward
	GROUP BY district_id) b, 
	district d
WHERE a.district_id=b.district_id and a.district_id=d.id
ORDER BY ratio DESC

--Question 10
SELECT *
FROM store
WHERE code='VMHNI60';

DECLARE @PI FLOAT = PI()
DECLARE	@Latitude1 FLOAT
DECLARE @Longitude1 FLOAT
DECLARE @Latitude2 FLOAT
DECLARE @Longitude2 FLOAT
DECLARE @store_code VARCHAR(20)
DECLARE @distance FLOAT
DECLARE	@distance_table TABLE(store_code varchar(20), distance float) 

SELECT @Latitude1=latitude, @Longitude1 =longitude 
FROM store
WHERE code='VMHNI60';

SELECT @Latitude2=latitude, @Longitude2 =longitude 
FROM store
WHERE id =2

	DECLARE STORE CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
			SELECT code
			FROM store
			--WHERE code <>'VMHNI60'
			WHERE code IN ('VMHNI466','VMHNI540','VMHNI735','VMHNI320','VMHNI120','VMHNI92')
	OPEN STORE
	FETCH NEXT FROM STORE INTO @store_code

	WHILE @@FETCH_STATUS = 0
	BEGIN	
		DECLARE @lat1Radianos FLOAT = @Latitude1 * @PI / 180
		DECLARE @lng1Radianos FLOAT = @Longitude1 * @PI / 180
		DECLARE @lat2Radianos FLOAT = @Latitude2 * @PI / 180
		DECLARE @lng2Radianos FLOAT = @Longitude2 * @PI / 180	
		SELECT @Latitude2=latitude, @Longitude2 =longitude 
		FROM store
		WHERE code=@store_code; 
			SELECT @distance= (ACOS(COS(@lat1Radianos) * COS(@lng1Radianos) * COS(@lat2Radianos) * COS(@lng2Radianos) + COS(@lat1Radianos) * SIN(@lng1Radianos) * COS(@lat2Radianos) * SIN(@lng2Radianos) + SIN(@lat1Radianos) * SIN(@lat2Radianos)) * 6371) * 1.15
			INSERT INTO @distance_table(store_code,distance)
			VALUES(@store_code,@distance)
				
	FETCH NEXT FROM STORE INTO @store_code		
	END; 
	CLOSE STORE
	DEALLOCATE STORE;
SELECT * FROM @distance_table ORDER BY distance
-------
SELECT TOP(3) s.id, s.code, s.name, s.address, 
dbo.fnc_calc_haversine_distance(s63.latitude, s63.longitude, s.latitude, s.longitude) as distance, s63.latitude, s63.longitude, s.latitude, s.longitude 
FROM dbo.store s, (SELECT id, latitude, longitude FROM dbo.store WHERE code='VMHNI60') s63 
WHERE s.code <> 'VMHNI60' ORDER BY distance

--Question 11
SELECT r.code as region_code, r.name as region_name, s.code as sub_region_code, s.name as sub_region_name, c.id as city_id, c.code as city_code, c.name as city_name
FROM city c, region r,sub_region s
WHERE c.sub_region_id=s.id AND s.region_id=r.id AND r.code='MB'
ORDER BY region_name,sub_region_name,city_name;

--Question 12
SELECT c.id, c.code,c.full_name, c.first_name, SUM(ph.total_amount) as total_amount
FROM pos_sales_header ph
	JOIN customer c ON ph.customer_id=c.id
	JOIN store s ON ph.store_id=s.id
WHERE s.district_id=1 AND CAST(ph.transaction_date AS DATE) >= '2020-10-01' AND CAST(ph.transaction_date AS DATE) <= '2020-10-20'
GROUP BY c.id, c.code,c.full_name, c.first_name
HAVING SUM(ph.total_amount) >10000000
ORDER BY total_amount DESC

--Question 13
SELECT TOP 5 document_code, store_id, s.code as store_code, s.name as store_name,transaction_date,customer_id,
	c.full_name,c.first_name,total_amount, 
	CASE 
	WHEN total_amount/2 < 1000000 THEN total_amount/2
	WHEN total_amount/2 >= 1000000 THEN 1000000
	END AS promotion_amount 
FROM
	(SELECT ph.document_code,ph.transaction_date,ph.store_id, ph.customer_id, SUM(ph.total_amount) as total_amount
	FROM pos_sales_header ph
	WHERE CAST(ph.transaction_date AS DATE) >= '2020-08-31' AND CAST(ph.transaction_date AS DATE) <= '2020-09-06'
	GROUP BY ph.document_code,ph.transaction_date,ph.store_id, ph.customer_id) ph
	JOIN customer c ON ph.customer_id=c.id
	JOIN store s ON ph.store_id=s.id
ORDER BY NEWID();

--Question 14
SELECT product_sku_id, customer_id, SUM(line_amount) purchase_amount, SUM(quantity) quantity, COUNT(*) nb_purchases, AVG(quantity) avg_quantity_per_purchases
FROM pos_sales_line
WHERE product_sku_id=91 AND YEAR(transaction_date) = '2020'
GROUP BY  product_sku_id, customer_id
ORDER BY customer_id

--Question 15
SELECT  Year, product_sku_id,p.code,p.name,p.country,p.brand,p.price, quantity, 	rk	
FROM 		
		(SELECT YEAR(transaction_date) Year, product_sku_id,unit_price,SUM(quantity) as quantity, 
		DENSE_RANK() OVER( PARTITION BY YEAR(transaction_date) ORDER BY SUM(quantity) DESC) as rk
		FROM pos_sales_line pl
			JOIN product_sku p ON pl.product_sku_id = p.id
		WHERE p.name LIKE N'Mì%' OR p.name LIKE N'Mỳ%' and p.product_subcategory_id=19
		GROUP BY YEAR(transaction_date) , product_sku_id,unit_price) a
		JOIN product_sku p ON a.product_sku_id = p.id
WHERE  YEAR = '2020' and rk <=20 --or Year='2019'  
ORDER BY Year, rk;

--Question 16
SELECT es.day_work, es.store_id, s.name, es.shift_name, es.sales_person_id, sp.code, full_name,first_name,gender
FROM store s
	JOIN sales_person sp ON s.id =sp.store_id
	JOIN emp_shift_schedule es ON sp.id=es.sales_person_id
WHERE CONVERT(DATE, es.day_work)='2020-06-13' AND s.name LIKE N'%Cụm 6 Xã Sen Chiểu%' and es.shift_name=N'Chiều'

--Question 17
SELECT id,code,name, Hour, CAST( AVG(SUM_Customer) as FLOAT ) as avg_nb_customer	
FROM	
	(SELECT s.id, s.code,s.name,CAST(transaction_date as DATE) DAY, DATEPART(HOUR,transaction_date) as Hour, 
		CAST( COUNT(ph.customer_id) as FLOAT)  as SUM_Customer
	FROM pos_sales_header ph
	JOIN store s ON ph.store_id=s.id
	WHERE MONTH(transaction_date) IN ('7','8','9','10','11','12') and  YEAR(transaction_date) ='2020'
	GROUP BY s.id, s.code,s.name,CAST(transaction_date as DATE) , DATEPART(HOUR,transaction_date) 
	) a
GROUP BY id,code,name, Hour
ORDER BY id,code,name, Hour;

--Question 18
WITH a AS(
SELECT YEAR(pl.transaction_date) Year, 
	CASE 
		WHEN ps.product LIKE N'Trà khô%' THEN N'Trà khô'
		WHEN ps.product LIKE N'Trà túi lọc%' THEN N'Trà túi lọc'
		WHEN ps.product LIKE N'Trà hòa tan%' THEN N'Trà hòa tan'
		WHEN ps.product LIKE N'Trà chai%' THEN N'Trà chai'
	END AS product_type_name,
	CASE 
		WHEN ps.product LIKE N'Trà khô%' THEN 1
		WHEN ps.product LIKE N'Trà túi lọc%' THEN 2
		WHEN ps.product LIKE N'Trà hòa tan%' THEN 3
		WHEN ps.product LIKE N'Trà chai%' THEN 4
	END AS product_type,
	SUM(pl.line_amount) as sales_amount 
FROM pos_sales_line pl 
JOIN product_sku ps ON pl.product_sku_id =ps.id
WHERE ps.product_subcategory_id =27 
GROUP BY YEAR(pl.transaction_date),ps.product 
)
, a1 AS (
SELECT Year,product_type, product_type_name, SUM(sales_amount) as sales_amount
FROM a 
GROUP BY Year,product_type, product_type_name
)
, b AS(
SELECT YEAR(pl.transaction_date) as Year, SUM(pl.line_amount) as sales_amount_ht
FROM pos_sales_line pl 
JOIN product_sku ps ON pl.product_sku_id =ps.id
WHERE ps.product_subcategory_id =27 
GROUP BY YEAR(pl.transaction_date)
)
SELECT a1.Year, a1.product_type, a1.product_type_name, b.sales_amount_ht, a1.sales_amount, 
	a1.sales_amount/b.sales_amount_ht as ratio
FROM a1 
JOIN b ON a1.Year=b.Year
WHERE a1.product_type_name LIKE N'Trà hòa tan'
ORDER BY  product_type ,Year;

SELECT id,name,product, product_subcategory_id
FROM product_sku
WHERE product LIKE N'trà%'

--Question 19
DECLARE @total_amount FLOAT = (SELECT SUM(line_amount) FROM pos_sales_line pl WHERE YEAR(transaction_date)='2020') ;
 
WITH a AS (
	SELECT YEAR(transaction_date) as Year, product_sku_id, CAST(SUM(line_amount) AS FLOAT) as total_line_amount,
		ROW_NUMBER() OVER(ORDER BY SUM(line_amount) DESC) as rn
	FROM pos_sales_line pl
	WHERE YEAR(transaction_date)='2020'
	GROUP BY YEAR(transaction_date), product_sku_id 
)  
,
b AS ( 
SELECT Year, product_sku_id, total_line_amount,  a.total_line_amount / @total_amount * 100 as Percentt, rn
FROM a )
,c AS (
SELECT Year, product_sku_id, total_line_amount, Percentt, SUM(Percentt) OVER( ORDER BY rn ) AS 'PercenttSUM',rn
FROM b
) 

SELECT c.Year ,pc.id as product_category_id , pc.name product_category_name,ps.id product_subcategory_id, 
	ps.name product_subcategory_name, c.product_sku_id,p.name product_sku_name, c.total_line_amount, 
	CASE 
		WHEN c.PercenttSUM <=70 THEN 'A'
		WHEN c.PercenttSUM <=90 THEN 'B'
		WHEN c.PercenttSUM <=100 THEN 'C'
	END AS type
FROM c 
	JOIN product_sku p ON c.product_sku_id =p.id
	JOIN product_subcategory ps ON p.product_subcategory_id = ps.id
	JOIN product_category pc ON p.product_category_id = pc.id
ORDER BY  product_category_id ASC,product_subcategory_id ASC ,total_line_amount DESC  

-- Question 20
SELECT a.store_id, s.code as store_code, s.name as store_name, a.Sale_amount_10_2020
FROM
	(SELECT TOP 3 store_id, SUM(total_amount) as Sale_amount_10_2020
	FROM pos_sales_header p
	WHERE YEAR(transaction_date) =2020 AND MONTH(transaction_date)=10
	GROUP BY store_id
	ORDER BY Sale_amount_10_2020 DESC) a
	JOIN storage s ON a.store_id=s.storage_id
ORDER BY Sale_amount_10_2020 DESC



