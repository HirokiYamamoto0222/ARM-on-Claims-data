## MEMO ########################
-- Association rule mining
## Safety label changes
## "Ethinyl estradiol drospirenone–Thrombophlebitis" pair
## Tablemaking
## prepare the dataset from November 2010 to November 2013
################################
-- 0. Database
use JMDC_Claims


################################
-- 1. Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_sub;
CREATE TABLE 母数_sub 
SELECT 
	加入者ID, 観察開始年月 AS Omin, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_sub ADD INDEX index01(加入者ID);


################################
-- 2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_sub_pre;
CREATE TABLE 医薬品_sub_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	診療年月 BETWEEN 201008 AND 201311
AND 
	剤型大分類名 IN ('内用薬', '注射薬')
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY
	加入者ID, 成分名
;
ALTER TABLE 医薬品_sub_pre ADD INDEX index01(加入者ID);


-- 2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_sub;
CREATE TABLE 医薬品_sub
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_sub_pre 
	INNER JOIN 母数_sub USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 201008) >= 3
;
ALTER TABLE 医薬品_sub ADD INDEX index01(加入者ID);


################################
-- 3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_sub_pre;
CREATE TABLE 傷病_sub_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	診療年月 BETWEEN 201008 AND 201311
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_sub_pre ADD INDEX index01(加入者ID);
						
							 
-- 3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_sub;
CREATE TABLE 傷病_sub 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_sub_pre
	INNER JOIN 母数_sub USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 201008) >= 3
;
ALTER TABLE 傷病_sub ADD INDEX index01(加入者ID);


################################
-- 4. Analysistablemaking
DROP TABLE IF EXISTS Progesterone_SQLdata;
CREATE TABLE Progesterone_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201010) AS eventID 
FROM 
	医薬品_sub
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201010) AS eventID 
FROM 
	傷病_sub
;
ALTER TABLE Progesterone_SQLdata ADD INDEX index01(加入者ID); 
ALTER TABLE Progesterone_SQLdata ADD INDEX index02(Item);


################################
-- 5. Drop tables
DROP TABLE 母数_sub;
DROP TABLE 医薬品_sub;
DROP TABLE 医薬品_sub_pre;
DROP TABLE 傷病_sub;
DROP TABLE 傷病_sub_pre;


