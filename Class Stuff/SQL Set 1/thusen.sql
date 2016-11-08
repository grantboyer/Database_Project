-- Number 1  *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST, (CREDIT_LIMIT - BALANCE) as AVAILABLE_CREDIT
From PRODUCTDEALS_CUSTOMER C
Where C.CREDIT_LIMIT >= '1500'
Order By AVAILABLE_CREDIT DESC, LAST ASC;

-- OUTPUT
-- 256	Samuels	Ann	1478.5
-- 522	Nelson	Mary	1401.25
-- 405	William	Al	1097.25
-- 412	Adams	Sally	182.5


-- Number 2 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST, C.BALANCE, C.SLSREP_NUMBER
From PRODUCTDEALS_CUSTOMER C
Where C.SLSREP_NUMBER <> '12' and C.BALANCE > ANY(Select BALANCE From PRODUCTDEALS_CUSTOMER Where SLSREP_NUMBER = '12');

-- OUTPUT
-- 412	Adams	Sally	1817.5	03
-- 622	Martin	Dan	1045.75	03
-- 124	Adams	Sally	818.75	03
-- 315	Daniels	Tom	770.75	06
-- 567	Dinh	Tran	402.4	06
-- 587	Galvez	Mara	114.6	06


-- Number 3 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C
Where NOT EXISTS(Select * From PRODUCTDEALS_TRANS T Where T.CUSTOMER_NUMBER = C.CUSTOMER_NUMBER 
and trunc(T.TRANS_DATE) = to_date('09-05-2002', 'MM-DD-YYYY'));

--OUTPUT - Not in same order as soltions on assignment, but same order as solution
--         that was ran in class by Imad
--256	Samuels	Ann
--311	Charles	Don
--315	Daniels	Tom
--405	William	Al
--412	Adams	Sally
--567	Dinh	Tran
--587	Galvez	Mara
--622	Martin	Dan


-- Number 4 *** DONE ***
Select C1.CUSTOMER_NUMBER, C2. CUSTOMER_NUMBER
From PRODUCTDEALS_CUSTOMER C1, PRODUCTDEALS_CUSTOMER C2
Where C1.FIRST = C2.FIRST and C1.LAST = C2.LAST and C1.CUSTOMER_NUMBER < C2.CUSTOMER_NUMBER;

-- OUTPUT - In order to not have multiples in output, need to use < rather than <>
--124	412


-- Number 5 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C 
Where C.SLSREP_NUMBER = '12'
UNION
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C 
Where NOT EXISTS(Select * From PRODUCTDEALS_TRANS T Where T.CUSTOMER_NUMBER = C.CUSTOMER_NUMBER);

-- OUTPUT
--311	Charles	Don
--405	William	Al
--412	Adams	Sally
--522	Nelson	Mary
--567	Dinh	Tran
--587	Galvez	Mara
--622	Martin	Dan


-- Number 6 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C
Where C.CREDIT_LIMIT = (Select MAX(CREDIT_LIMIT) From PRODUCTDEALS_CUSTOMER Where SLSREP_NUMBER = '06') and C.SLSREP_NUMBER = '06';

-- OUTPUT
--256	Samuels	Ann


-- Number 7 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST, C.BALANCE, C.SLSREP_NUMBER
From PRODUCTDEALS_CUSTOMER C
Where C.BALANCE > ALL(Select BALANCE From PRODUCTDEALS_CUSTOMER Where SLSREP_NUMBER = '12');

-- OUTPUT
--622	Martin	Dan	1045.75	03
--412	Adams	Sally	1817.5	03


-- Number 8 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C
Where NOT EXISTS
  (Select * 
   From PRODUCTDEALS_PART P 
   Where UNIT_PRICE < '20' and
    NOT EXISTS
      (Select * 
       From PRODUCTDEALS_TRANS T, PRODUCTDEALS_TRANSPART TP 
       Where T.CUSTOMER_NUMBER = C.CUSTOMER_NUMBER and TP.PART_NUMBER = P.PART_NUMBER
       and T.TRANS_NUMBER = TP.TRANS_NUMBER));

-- OUTPUT
--522	Nelson	Mary


-- Number 9 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C
Where NOT EXISTS(
  (Select P.PART_NUMBER
   From PRODUCTDEALS_PART P 
   Where P.UNIT_PRICE < '20') MINUS
      (Select TP.PART_NUMBER 
       From PRODUCTDEALS_TRANS T, PRODUCTDEALS_TRANSPART TP
       Where T.CUSTOMER_NUMBER = C.CUSTOMER_NUMBER
       and T.TRANS_NUMBER = TP.TRANS_NUMBER));

-- OUTPUT
--522	Nelson	Mary


-- Number 10 *** DONE ***
Select TP.TRANS_NUMBER, SUM(NUMBER_ORDERED * QUOTED_PRICE) as GROSS_VALUE
From PRODUCTDEALS_TRANSPART TP
Group By TP.TRANS_NUMBER
Having SUM(TP.NUMBER_ORDERED*TP.QUOTED_PRICE) > 200;

-- OUTPUT
--12489	241.45
--12491	399.99
--12494	1119.96
--12504	651.98


-- Number 11
Select TP.PART_NUMBER, SUM(TP.NUMBER_ORDERED) as TOTAL_SOLD
From PRODUCTDEALS_TRANSPART TP, PRODUCTDEALS_TRANS T
Where TP.TRANS_NUMBER = T.TRANS_NUMBER and
  trunc(T.TRANS_DATE) BETWEEN to_date('09-01-2002', 'MM-DD-YYYY') and 
                              to_date('09-30-2002', 'MM-DD-YYYY')
Group By TP.PART_NUMBER;  

-- OUTPUT
--CX11	2
--BA74	4
--BT04	2
--CB03	4
--AX12	11
--BZ66	1
--AZ52	2
--CZ81	2


-- Number 12 *** DONE ***
Select C.CREDIT_LIMIT, COUNT(*)
From PRODUCTDEALS_CUSTOMER C
Where C.SLSREP_NUMBER = '06'
Group By C.CREDIT_LIMIT
Having count(*) > 1;

-- OUTPUT
--750	2


-- Number 13 *** DONE ***
Select C.CUSTOMER_NUMBER, C.LAST, C.FIRST
From PRODUCTDEALS_CUSTOMER C
Where C.SLSREP_NUMBER = '06' and C.CREDIT_LIMIT = (Select MAX(CREDIT_LIMIT) From PRODUCTDEALS_CUSTOMER Where SLSREP_NUMBER = '06');

-- OUTPUT
--256	Samuels	Ann


-- Number 14 *** DONE ***
Select P.PART_NUMBER, P.PART_DESCRIPTION, TP.TRANS_NUMBER
From PRODUCTDEALS_PART P LEFT OUTER JOIN PRODUCTDEALS_TRANSPART TP
ON P.PART_NUMBER = TP.PART_NUMBER
Order By P.PART_NUMBER;

-- OUTPUT
--AX12	Iron        	12489
--AZ52	Dartboard   	12498
--BA74	Basketball  	12498
--BH22	Cornpopper  	
--BT04	Gas Grill   	12491
--BT04	Gas Grill   	12500
--BZ66	Washer      	12491
--CA14	Griddle     	
--CB03	Bike        	12494
--CX11	Blender     	12495
--CZ81	Treadmill   	12504


-- Number 15 *** DONE ***

-- Gets current PART table
Select * From PRODUCTDEALS_PART;
-- Actual update statement
Update PRODUCTDEALS_PART P
Set UNITS_ON_HAND = (2 * UNITS_ON_HAND)
Where (Select SUM(NUMBER_ORDERED) 
       From PRODUCTDEALS_TRANSPART TP
       Where TP.PART_NUMBER = P.PART_NUMBER) > 10;

-- additional command to get the output
Select * From PRODUCTDEALS_PART; 

-- OUTPUT
--AX12	Iron        	208	24.95
--AZ52	Dartboard   	20	12.95
--BA74	Basketball  	40	29.95
--BH22	Cornpopper  	95	25.95
--BT04	Gas Grill   	11	149.99
--BZ66	Washer      	52	399.99
--CA14	Griddle     	78	39.99
--CB03	Bike        	44	399.99
--CX11	Blender     	112	22.95
--CZ81	Treadmill   	68	349.95
