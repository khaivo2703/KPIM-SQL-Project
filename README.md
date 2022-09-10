# KPIM-SQL-Project
About:
- Data includes 

Key Skills:
- Complex joins - This competency includes using INNER, LEFT, RIGHT, and FULL joins on multiple tables and using joins for many-to-many relationships.
- Unions - This competency includes using unions to display multiple sets of information in the same report.
- Subqueries - This competency includes using data based on information returned from a different query. The ability to reduce selection set through the effective ordering of subqueries.

Questions/Prompts:
1. What is the code for province "Thái Bình" in the database?
2. What "province" stands for code "HTH"?
3. What's the postion of "Hà Nội" in the list of province / city of "Đồng bằng sông Hồng"?
4. How many "Provinces" have name starts with "Quảng"?
5. What is "Percentage of provinces" in area "Đồng bằng sông Hồng" and "Đồng bằng sông Cửu Long" compare to "total provinces" in Vietnam (Rounded to 2 decimal places)?
6. How many "provinces" in the "Middle Area"?
7. Which "province" has the "highest number of stores" in the whole country?
8. How many "wards" in Hà Nội with "more than 10 stores"?
9. Which "province" has the "highest ratio of number of stores to number of wards"?
10. Choose 3 stores neareast to store "VMHNI60"?
11. Get a "list of cities and provinces" in the "North". There is information about domain name, domain code, area name, area code, after id, name, code of province/city. The data table is arranged in alphabetical order by domain name, region name and city name.
12. On the occasion of the establishment of the first branch in Hoan Kiem district - Hanoi, the company plans to organize a gratitude event for loyal customers. All customers with "total accumulated purchase value" (including VAT) from October 1, 2020 to 
October 20, 2020 at stores in Hoan Kiem district "over 10 million VND" will receive a purchase voucher 1 million dong. Knowing that stores in Hoan Kiem district have district_id=1. Get a "list of customers who are eligible" to participate in the above promotion. 
The required information includes: customer code, full name, customer name, total purchase value. Sort by descending total purchase value and customer name in Alphabetical order.
13. Every week, the lucky spin program will find 5 lucky orders and "refund 50%" for order "not more than 1 million VND". Retrieve order information, information of lucky customers and the amount of money the customer is refunded. The required information includes: order code, store code, store name, time of purchase, customer code, full name, customer name, order value, customer refund amount again.
14. Summarize "sales" and "average number of products purchased" each time a customer buys the product “Cháo Yến Mạch, Chà Là Và Hồ Đào | Herritage Mill, Úc (320 G)” in 2020. Know that the product's sku code is 91.
15. Get a list of the "top 20 best-selling instant noodles products" in 2019 and 2020. Consider products in the instant food group (sub_category_id=19) and the product name "has the word "Mì" or the word "Mỳ"". Information returned includes year, product code, product name, country of origin, brand, selling price, quantity sold, sales rating by year. The returned list is sorted by year and by product rating.
16. The store “Cụm 6, Xã Sen Chiểu, Huyện Phúc Thọ, Hà Nội” had customers complaining about the service quality and service attitude of the staff on the afternoon of June 13, 2020. Query information about employees working the afternoon shift on June 13, 2020 at the store.
17. Analyze what time frame customers often come to buy in to coordinate enough staff to serve customers' shopping needs. Query the "average number of customers" who come to buy at each store per day according to "each time frame of the day". Sales data is limited to the last 6 months of 2020. Let assume a staff to serve 8 customers / 1 hour, calculate "at the peak time", how many "employees" each store needs.
18. Currently, the chain is trading in 4 types of tea products: trà khô, trà túi lọc, trà hòa tan, trà chai. Tea products have sub_category_id=27. Based on the product field can be classified as follows: 
- product contains word “trà khô” -> product_type=1
- product contains word “trà túi lọc” -> product_type=2
- product contains word “trà hòa tan” -> product_type=3
- product contains word “trà chai” -> product_type=4
Calculate the ratio of sales of trà hòa tan to total sales of tea products in 2018, 2019, 2020.
19. Based on sales in 2020, "classify products into 3 groups A, B, C (ABC Analysis)". Sort products by sales descending. Product group A is the products that account for 70% of total revenue, product group B is the products that account for 20% of total revenue, and product group C is the products that account for the remaining 10% of revenue. Query a "list of products categorized by ABC group". Sort by line code and product group code, sales descending.
20. Get the "TOP 3 stores by sales" in Hanoi to award the store of the month of October 2020. Know that stores in Hanoi have "city_id=24".
