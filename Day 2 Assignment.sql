 use ECOMMERCE_ASSIGNMENT_DB

 Select * from Product where Price > 
 (select avg(Price) from Product)

 select * from Product where StockQuantity <
 (select avg(StockQuantity) from Product)

 select * from Customer where CustomerId in 
 ( select CustomerId from Orders )

 select * from Customer where CustomerId not in 
 (select CustomerId from Orders)

 select * from Product Where ProductId in 
 (select ProductId from OrderItem)

select * from Product Where ProductId not in 
 (select ProductId from OrderItem)

 select * from Seller where SellerId in 
 (select SellerId from Product)

 select * from Seller where SellerId not in 
 (select SellerId from Product)

 select * from Orders where CustomerId in 
 (select CustomerId from Customer where city = 'Chennai')

 select * from Product where sellerId in 
 (select SellerId from Seller where City='Banglore')

 select * from Customer where customerId in 
 (select CustomerId from Orders)

 select * from Customer where customerId not in 
 (select CustomerId from Orders)

 select * from Product where ProductId in 
 (select ProductId from Orderitem)

 select * from Product where ProductId not in 
 (select ProductId from Orderitem)

 select * from Seller where SellerId in 
 (select SellerId from Product)

  select * from Seller where SellerId not in 
 (select SellerId from Product)

 select * from Orders where OrderId in 
 (select orderId from OrderItem where productId in 
 (select ProductId from Product where Category = 'Mobile'))

 select * from Orders where OrderId not in 
 (select orderId from OrderItem where productId in 
 (select ProductId from Product where Category = 'Laptop'))

 select * from Product where price = 
 (select MAX(Price) from Product)

 select * from Product where price = 
 (select Min(Price) from Product)

 select * from Product where Price >  
 (select avg(Price) from Product)

 select * from Product where Price < 
 (select avg(Price) from Product)

SELECT s.SellerId, s.SellerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Seller s JOIN Product p
ON s.SellerId = p.SellerId
JOIN OrderItem oi ON p.ProductId = oi.ProductId
GROUP BY s.SellerId,s.SellerName
HAVING SUM(oi.Quantity * oi.UnitPrice) > 50000;

select
    p.productid,
    p.productname,
    sum(oi.quantity) as totalsold
from product p
join orderitem oi
on p.productid = oi.productid
group by p.productid, p.productname
having sum(oi.quantity) >
(
    select avg(totalqty)
    from
    ( select sum(quantity) as totalqty  from orderitem
        group by productid
    ) a
);


select top 1  p.productid, p.productname,
sum(oi.quantity * oi.unitprice) as salesamount
from product p
join orderitem oi
on p.productid = oi.productid
group by p.productid, p.productname
order by salesamount desc;

select top 1
    p.productid,
    p.productname,
    sum(oi.quantity * oi.unitprice) as salesamount
from product p
join orderitem oi
on p.productid = oi.productid
group by p.productid, p.productname
order by salesamount desc;

select top 1
    s.sellerid,
    s.sellername,
    sum(oi.quantity * oi.unitprice) as totalsales
from seller s
join product p
on s.sellerid = p.sellerid
join orderitem oi
on p.productid = oi.productid
group by s.sellerid, s.sellername
order by totalsales desc;

select *
from product p1
where price >
(
    select avg(price)
    from product p2
    where p1.category = p2.category
)

select * from product p1 where price <
(
    select avg(price)
    from product p2
    where p1.category = p2.category
)

select * from seller where sellerid in
(
    select sellerid
    from product
    group by sellerid
    having count(*) > 2
)

select * from customer where customerid in
(
    select customerid
    from orders
    group by customerid
    having count(*) > 1
)

select o.orderid,
       sum(oi.quantity * oi.unitprice) as orderamount
from orders o
join orderitem oi
on o.orderid = oi.orderid
group by o.orderid
having sum(oi.quantity * oi.unitprice) >
(
    select avg(ordertotal)
    from
    (
        select sum(quantity * unitprice) as ordertotal
        from orderitem
        group by orderid
    ) a
)

select * from product p1 where stockquantity >
(
    select avg(stockquantity)
    from product p2
    where p1.category = p2.category
)

select * from seller s where sellerid in
(
    select sellerid
    from product
    group by sellerid
    having avg(price) >
    (
        select avg(price)
        from product
    )
)

select * from customer c
where exists
(select * from orders o
where c.customerid=o.customerid);

select * from customer c
where not exists
(select * from orders o
where c.customerid=o.customerid);

select * from product p
where exists
(select * from orderitem oi
where p.productid=oi.productid);

select * from product p
where not exists
(select * from orderitem oi
where p.productid=oi.productid);

select * from seller s
where exists
(select * from product p
where s.sellerid=p.sellerid);

select * from seller s
where not exists
(select * from product p
where s.sellerid=p.sellerid);

select * from customer c
where exists
(select * from orders o
join orderitem oi on o.orderid=oi.orderid
join product p on oi.productid=p.productid
where c.customerid=o.customerid
and p.category='Mobile');

select * from customer c
where not exists
(select * from orders o
join orderitem oi on o.orderid=oi.orderid
join product p on oi.productid=p.productid
where c.customerid=o.customerid
and p.category='Laptop');

--stored procedure

CREATE PROC SP_DISPLAYCUSTOMERS
AS
BEGIN
SELECT * FROM CUSTOMER;
END;

CREATE PROC SP_DISPLAYPRODUCTS
AS
BEGIN
SELECT * FROM PRODUCT;
END;

CREATE PROC SP_DISPLAYSELLERS
AS
BEGIN
SELECT * FROM SELLER;
END;
EXEC SP_DISPLAYSELLERS;

CREATE PROC SP_DISPLAYORDERS
AS
BEGIN
SELECT * FROM ORDERS;
END;

CREATE PROC SP_DISPLAYORDERITEMS
AS
BEGIN
SELECT * FROM ORDERITEM;
END;

CREATE PROC SP_CUSTOMERBYID
@CUSTOMERID INT
AS
BEGIN
SELECT * FROM CUSTOMER
WHERE CUSTOMERID=@CUSTOMERID;
END;

CREATE PROC SP_PRODUCTBYID
@PRODUCTID INT
AS
BEGIN
SELECT * FROM PRODUCT
WHERE PRODUCTID=@PRODUCTID;
END;

CREATE PROC SP_SELLERBYID
@SELLERID INT
AS
BEGIN
SELECT * FROM SELLER
WHERE SELLERID=@SELLERID;
END;

CREATE PROC SP_ORDERBYID
@ORDERID INT
AS
BEGIN
SELECT * FROM ORDERS
WHERE ORDERID=@ORDERID;
END;


CREATE PROC SP_CUSTOMERSBYCITY
@CITY VARCHAR(50)
AS
BEGIN
SELECT * FROM CUSTOMER
WHERE CITY=@CITY;
END;

CREATE PROC SP_PRODUCTSBYCATEGORY
@CATEGORY VARCHAR(50)
AS
BEGIN
SELECT * FROM PRODUCT
WHERE CATEGORY=@CATEGORY;
END;

CREATE PROC SP_PRODUCTSBYSELLER
@SELLERID INT
AS
BEGIN
SELECT * FROM PRODUCT
WHERE SELLERID=@SELLERID;
END;

CREATE PROC SP_ORDERSBYCUSTOMER
@CUSTOMERID INT
AS
BEGIN
SELECT * FROM ORDERS
WHERE CUSTOMERID=@CUSTOMERID;
END;

CREATE PROC SP_ORDERITEMSBYORDER
@ORDERID INT
AS
BEGIN
SELECT * FROM ORDERITEM
WHERE ORDERID=@ORDERID;
END

CREATE PROC SP_PRODUCTSBYPRICE
@PRICE DECIMAL(10,2)
AS
BEGIN
SELECT * FROM PRODUCT
WHERE PRICE>@PRICE;
END

CREATE PROC SP_INSERTCUSTOMER
@CUSTOMERID INT,
@CUSTOMERNAME VARCHAR(100),
@EMAIL VARCHAR(100),
@MOBILENO VARCHAR(15),
@CITY VARCHAR(50),
@ADDRESS VARCHAR(200),
@ISACTIVE BIT,
@CREATEDDATE DATE
AS
BEGIN
INSERT INTO CUSTOMER
VALUES(@CUSTOMERID,@CUSTOMERNAME,@EMAIL,@MOBILENO,@CITY,@ADDRESS,@ISACTIVE,@CREATEDDATE);
END

CREATE PROC SP_INSERTSELLER
@SELLERID INT,
@SELLERNAME VARCHAR(100),
@EMAIL VARCHAR(100),
@MOBILENO VARCHAR(15),
@CITY VARCHAR(50),
@RATING DECIMAL(3,1),
@ISACTIVE BIT
AS
BEGIN
INSERT INTO SELLER
VALUES(@SELLERID,@SELLERNAME,@EMAIL,@MOBILENO,@CITY,@RATING,@ISACTIVE);
END

CREATE PROC SP_INSERTPRODUCT
@PRODUCTID INT,
@PRODUCTNAME VARCHAR(100),
@CATEGORY VARCHAR(50),
@PRICE DECIMAL(10,2),
@STOCKQUANTITY INT,
@SELLERID INT,
@CREATEDDATE DATE
AS
BEGIN
INSERT INTO PRODUCT
VALUES(@PRODUCTID,@PRODUCTNAME,@CATEGORY,@PRICE,@STOCKQUANTITY,@SELLERID,@CREATEDDATE);
END

CREATE PROC SP_INSERTORDER
@ORDERID INT,
@CUSTOMERID INT,
@ORDERDATE DATE,
@ORDERSTATUS VARCHAR(50),
@PAYMENTMODE VARCHAR(50),
@DELIVERYCITY VARCHAR(50)
AS
BEGIN
INSERT INTO ORDERS
VALUES(@ORDERID,@CUSTOMERID,@ORDERDATE,@ORDERSTATUS,@PAYMENTMODE,@DELIVERYCITY);
END

CREATE PROC SP_INSERTORDERITEM
@ORDERITEMID INT,
@ORDERID INT,
@PRODUCTID INT,
@QUANTITY INT,
@UNITPRICE DECIMAL(10,2)
AS
BEGIN
INSERT INTO ORDERITEM
VALUES(@ORDERITEMID,@ORDERID,@PRODUCTID,@QUANTITY,@UNITPRICE);
END

CREATE PROC SP_UPDATECUSTOMERCITY
@CUSTOMERID INT,
@CITY VARCHAR(50)
AS
BEGIN
UPDATE CUSTOMER
SET CITY=@CITY
WHERE CUSTOMERID=@CUSTOMERID;
END;

CREATE PROC SP_UPDATECUSTOMERMOBILE
@CUSTOMERID INT,
@MOBILENO VARCHAR(15)
AS
BEGIN
UPDATE CUSTOMER
SET MOBILENO=@MOBILENO
WHERE CUSTOMERID=@CUSTOMERID;
END

CREATE PROC SP_UPDATEPRODUCTPRICE
@PRODUCTID INT,
@PRICE DECIMAL(10,2)
AS
BEGIN
UPDATE PRODUCT
SET PRICE=@PRICE
WHERE PRODUCTID=@PRODUCTID;
END

CREATE PROC SP_UPDATEPRODUCTSTOCK
@PRODUCTID INT,
@STOCKQUANTITY INT
AS
BEGIN
UPDATE PRODUCT
SET STOCKQUANTITY=@STOCKQUANTITY
WHERE PRODUCTID=@PRODUCTID;
END

CREATE PROC SP_UPDATEORDERSTATUS
@ORDERID INT,
@ORDERSTATUS VARCHAR(50)
AS
BEGIN
UPDATE ORDERS
SET ORDERSTATUS=@ORDERSTATUS
WHERE ORDERID=@ORDERID;
END

CREATE PROC SP_UPDATESELLERRATING
@SELLERID INT,
@RATING DECIMAL(3,1)
AS
BEGIN
UPDATE SELLER
SET RATING=@RATING
WHERE SELLERID=@SELLERID;
END

CREATE PROC SP_UPDATECUSTOMERSTATUS
@CUSTOMERID INT,
@ISACTIVE BIT
AS
BEGIN
UPDATE CUSTOMER
SET ISACTIVE=@ISACTIVE
WHERE CUSTOMERID=@CUSTOMERID;
END

CREATE PROC SP_UPDATESELLERSTATUS
@SELLERID INT,
@ISACTIVE BIT
AS
BEGIN
UPDATE SELLER
SET ISACTIVE=@ISACTIVE
WHERE SELLERID=@SELLERID;
END

CREATE PROC SP_DELETECUSTOMER
@CUSTOMERID INT
AS
BEGIN
DELETE FROM CUSTOMER
WHERE CUSTOMERID=@CUSTOMERID;
END

CREATE PROC SP_DELETESELLER
@SELLERID INT
AS
BEGIN
DELETE FROM SELLER
WHERE SELLERID=@SELLERID;
END

CREATE PROC SP_DELETEPRODUCT
@PRODUCTID INT
AS
BEGIN
DELETE FROM PRODUCT
WHERE PRODUCTID=@PRODUCTID;
END

CREATE PROC SP_DELETEORDER
@ORDERID INT
AS
BEGIN
DELETE FROM ORDERS
WHERE ORDERID=@ORDERID;
END

CREATE PROC SP_DELETEORDERITEM
@ORDERITEMID INT
AS
BEGIN
DELETE FROM ORDERITEM
WHERE ORDERITEMID=@ORDERITEMID;
END

CREATE PROC SP_CUSTOMERWISEORDERDETAILS
AS
BEGIN
SELECT C.CUSTOMERID,C.CUSTOMERNAME,O.ORDERID,O.ORDERDATE,O.ORDERSTATUS
FROM CUSTOMER C
JOIN ORDERS O
ON C.CUSTOMERID=O.CUSTOMERID;
END

CREATE PROC SP_SELLERWISEPRODUCTDETAILS
AS
BEGIN
SELECT S.SELLERID,S.SELLERNAME,P.PRODUCTID,P.PRODUCTNAME,P.PRICE
FROM SELLER S
JOIN PRODUCT P
ON S.SELLERID=P.SELLERID;
END

CREATE PROC SP_ORDERWISEPRODUCTDETAILS
AS
BEGIN
SELECT O.ORDERID,P.PRODUCTID,P.PRODUCTNAME,OI.QUANTITY,OI.UNITPRICE
FROM ORDERS O
JOIN ORDERITEM OI
ON O.ORDERID=OI.ORDERID
JOIN PRODUCT P
ON OI.PRODUCTID=P.PRODUCTID;
END

CREATE PROC SP_CUSTOMERWISETOTALORDERAMOUNT
AS
BEGIN
SELECT C.CUSTOMERID,
C.CUSTOMERNAME,
SUM(OI.QUANTITY*OI.UNITPRICE) AS TOTALAMOUNT
FROM CUSTOMER C
JOIN ORDERS O
ON C.CUSTOMERID=O.CUSTOMERID
JOIN ORDERITEM OI
ON O.ORDERID=OI.ORDERID
GROUP BY C.CUSTOMERID,C.CUSTOMERNAME;
END

CREATE PROC SP_SELLERWISETOTALSALES
AS
BEGIN
SELECT S.SELLERID,
S.SELLERNAME,
SUM(OI.QUANTITY*OI.UNITPRICE) AS TOTALSALES
FROM SELLER S
JOIN PRODUCT P
ON S.SELLERID=P.SELLERID
JOIN ORDERITEM OI
ON P.PRODUCTID=OI.PRODUCTID
GROUP BY S.SELLERID,S.SELLERNAME;
END

CREATE PROC SP_PRODUCTWISETOTALSALESQUANTITY
AS
BEGIN
SELECT P.PRODUCTID,
P.PRODUCTNAME,
SUM(OI.QUANTITY) AS TOTALQUANTITYSOLD
FROM PRODUCT P
JOIN ORDERITEM OI
ON P.PRODUCTID=OI.PRODUCTID
GROUP BY P.PRODUCTID,P.PRODUCTNAME;
END

CREATE PROC SP_TOTALCUSTOMERS
@TOTALCUSTOMERS INT OUTPUT
AS
BEGIN
SELECT @TOTALCUSTOMERS=COUNT(*)
FROM CUSTOMER;
END

CREATE PROC SP_TOTALPRODUCTS
@TOTALPRODUCTS INT OUTPUT
AS
BEGIN
SELECT @TOTALPRODUCTS=COUNT(*)
FROM PRODUCT;
END

DECLARE @RESULT INT
EXEC SP_TOTALPRODUCTS @RESULT OUTPUT
SELECT @RESULT AS TOTALPRODUCTS

CREATE PROC SP_TOTALORDERS
@TOTALORDERS INT OUTPUT
AS
BEGIN
SELECT @TOTALORDERS=COUNT(*)
FROM ORDERS;
END

DECLARE @RESULT INT
EXEC SP_TOTALORDERS @RESULT OUTPUT
SELECT @RESULT AS TOTALORDERS

CREATE PROC SP_PRODUCTTOTALSALES
@PRODUCTID INT,
@TOTALSALES DECIMAL(18,2) OUTPUT
AS
BEGIN
SELECT @TOTALSALES=SUM(QUANTITY*UNITPRICE)
FROM ORDERITEM
WHERE PRODUCTID=@PRODUCTID;
END

DECLARE @RESULT DECIMAL(18,2)

EXEC SP_PRODUCTTOTALSALES
101,
@RESULT OUTPUT

SELECT @RESULT AS TOTALSALES;


CREATE PROC SP_CUSTOMERTOTALPURCHASE
@CUSTOMERID INT,
@TOTALPURCHASE DECIMAL(18,2) OUTPUT
AS
BEGIN
SELECT @TOTALPURCHASE=SUM(OI.QUANTITY*OI.UNITPRICE)
FROM ORDERS O
JOIN ORDERITEM OI
ON O.ORDERID=OI.ORDERID
WHERE O.CUSTOMERID=@CUSTOMERID;
END

DECLARE @RESULT DECIMAL(18,2)

EXEC SP_CUSTOMERTOTALPURCHASE
1,
@RESULT OUTPUT

SELECT @RESULT AS TOTALPURCHASE



