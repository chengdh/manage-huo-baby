use lmis;
set names utf8;
SELECT *
INTO OUTFILE 'd:\\crm_customer.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM crm_customer
WHERE d_customertype_id='4028808c0ba242c6010ba255bd3a0007';
SELECT *
INTO OUTFILE 'd:\\info_org.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM info_org;
