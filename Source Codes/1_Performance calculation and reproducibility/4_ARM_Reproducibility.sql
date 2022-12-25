## MEMO ########################
## Reproducibility
## Tablemaking
################################
-- 0. Database
use JMDC_Claims


################################
## Dataset: 2008
-- 1.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_08;
CREATE TABLE 母数_08 
SELECT 
	加入者ID, 観察開始年月, 観察終了年月
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 200801 AND 200812
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_08 ADD INDEX index01(加入者ID);


-- 1.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_08_pre;
CREATE TABLE 医薬品_08_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_08)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_08_pre ADD INDEX index01(加入者ID);


-- 1.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_08;
CREATE TABLE 医薬品_08
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_08_pre 
	INNER JOIN 母数_08 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_08 ADD INDEX index01(加入者ID);


################################	
-- 1.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_08_pre;
CREATE TABLE 傷病_08_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_08)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_08_pre ADD INDEX index01(加入者ID);

						 
-- 1.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_08;
CREATE TABLE 傷病_08 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_08_pre
	INNER JOIN 母数_08 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_08 ADD INDEX index01(加入者ID);


################################
-- 1.4 Analysistablemaking
DROP TABLE IF EXISTS 2008_JMDC_ARM_SQLdata;
CREATE TABLE 2008_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 200801) AS eventID 
FROM 
	医薬品_08
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 200801) AS eventID 
FROM 
	傷病_08
;
ALTER TABLE 2008_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 1.5. Drop tables
DROP TABLE 母数_08;
DROP TABLE 医薬品_08;
DROP TABLE 医薬品_08_pre;
DROP TABLE 傷病_08;
DROP TABLE 傷病_08_pre;


################################
################################
## Dataset: 2009
-- 2.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_09;
CREATE TABLE 母数_09 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 200901 AND 200912
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_09 ADD INDEX index01(加入者ID);


-- 2.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_09_pre;
CREATE TABLE 医薬品_09_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_09)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_09_pre ADD INDEX index01(加入者ID);


-- 2.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_09;
CREATE TABLE 医薬品_09
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_09_pre 
	INNER JOIN 母数_09 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_09 ADD INDEX index01(加入者ID);


################################
-- 2.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_09_pre;
CREATE TABLE 傷病_09_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_09)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_09_pre ADD INDEX index01(加入者ID);
						
							 
-- 2.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_09;
CREATE TABLE 傷病_09 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_09_pre
	INNER JOIN 母数_09 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_09 ADD INDEX index01(加入者ID);


################################
-- 2.4 Analysistablemaking
DROP TABLE IF EXISTS 2009_JMDC_ARM_SQLdata;
CREATE TABLE 2009_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 200901) AS eventID 
FROM 
	医薬品_09
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 200901) AS eventID 
FROM 
	傷病_09
;
ALTER TABLE 2009_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 2.5 Drop tables
DROP TABLE 母数_09;
DROP TABLE 医薬品_09;
DROP TABLE 医薬品_09_pre;
DROP TABLE 傷病_09;
DROP TABLE 傷病_09_pre;


################################
################################
## Dataset: 2010
-- 3.1. Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_10;
CREATE TABLE 母数_10 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201001 AND 201012
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_10 ADD INDEX index01(加入者ID);


-- 3.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_10_pre;
CREATE TABLE 医薬品_10_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_10)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_10_pre ADD INDEX index01(加入者ID);


-- 3.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_10;
CREATE TABLE 医薬品_10
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_10_pre 
	INNER JOIN 母数_10 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_10 ADD INDEX index01(加入者ID);


################################
-- 3.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_10_pre;
CREATE TABLE 傷病_10_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_10)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_10_pre ADD INDEX index01(加入者ID);
						
							 
-- 3.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_10;
CREATE TABLE 傷病_10 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_10_pre
	INNER JOIN 母数_10 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_10 ADD INDEX index01(加入者ID);


################################
-- 3.4 Analysistablemaking
DROP TABLE IF EXISTS 2010_JMDC_ARM_SQLdata;
CREATE TABLE 2010_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201001) AS eventID 
FROM 
	医薬品_10
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201001) AS eventID 
FROM 
	傷病_10
;
ALTER TABLE 2010_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 3.5 Drop tables
DROP TABLE 母数_10;
DROP TABLE 医薬品_10;
DROP TABLE 医薬品_10_pre;
DROP TABLE 傷病_10;
DROP TABLE 傷病_10_pre;


################################
################################
## Dataset: 2011
-- 4.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_11;
CREATE TABLE 母数_11 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201101 AND 201112
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_11 ADD INDEX index01(加入者ID);


-- 4.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_11_pre;
CREATE TABLE 医薬品_11_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_11)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_11_pre ADD INDEX index01(加入者ID);


-- 4.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_11;
CREATE TABLE 医薬品_11
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_11_pre 
	INNER JOIN 母数_11 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_11 ADD INDEX index01(加入者ID);


################################
-- 4.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_11_pre;
CREATE TABLE 傷病_11_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_11)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_11_pre ADD INDEX index01(加入者ID);
						
							 
-- 4.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_11;
CREATE TABLE 傷病_11 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_11_pre
	INNER JOIN 母数_11 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_11 ADD INDEX index01(加入者ID);


################################
-- 4.4 Analysistablemaking
DROP TABLE IF EXISTS 2011_JMDC_ARM_SQLdata;
CREATE TABLE 2011_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201101) AS eventID 
FROM 
	医薬品_11
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201101) AS eventID 
FROM 
	傷病_11
;
ALTER TABLE 2011_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 4.5 Drop tables
DROP TABLE 母数_11;
DROP TABLE 医薬品_11;
DROP TABLE 医薬品_11_pre;
DROP TABLE 傷病_11;
DROP TABLE 傷病_11_pre;


################################
################################
## Dataset: 2012
-- 5.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_12;
CREATE TABLE 母数_12 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201201 AND 201212
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_12 ADD INDEX index01(加入者ID);


################################
-- 5.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_12_pre;
CREATE TABLE 医薬品_12_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_12)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_12_pre ADD INDEX index01(加入者ID);


-- 5.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_12;
CREATE TABLE 医薬品_12
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_12_pre 
	INNER JOIN 母数_12 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_12 ADD INDEX index01(加入者ID);


################################
-- 5.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_12_pre;
CREATE TABLE 傷病_12_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_12)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_12_pre ADD INDEX index01(加入者ID);
						
							 
-- 5.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_12;
CREATE TABLE 傷病_12 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_12_pre
	INNER JOIN 母数_12 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_12 ADD INDEX index01(加入者ID);


################################
-- 5.4 Analysistablemaking
DROP TABLE IF EXISTS 2012_JMDC_ARM_SQLdata;
CREATE TABLE 2012_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201201) AS eventID 
FROM 
	医薬品_12
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201201) AS eventID 
FROM 
	傷病_12
;
ALTER TABLE 2012_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 5.5 Drop tables
DROP TABLE 母数_12;
DROP TABLE 医薬品_12;
DROP TABLE 医薬品_12_pre;
DROP TABLE 傷病_12;
DROP TABLE 傷病_12_pre;


################################
################################
## Dataset: 2013
-- 6.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_13;
CREATE TABLE 母数_13 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201301 AND 201312
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_13 ADD INDEX index01(加入者ID);


################################
-- 6.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_13_pre;
CREATE TABLE 医薬品_13_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_13)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_13_pre ADD INDEX index01(加入者ID);


-- 6.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_13;
CREATE TABLE 医薬品_13
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_13_pre 
	INNER JOIN 母数_13 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_13 ADD INDEX index01(加入者ID);


################################
-- 6.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_13_pre;
CREATE TABLE 傷病_13_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_13)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_13_pre ADD INDEX index01(加入者ID);
						
							 
-- 6.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_13;
CREATE TABLE 傷病_13 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_13_pre
	INNER JOIN 母数_13 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_13 ADD INDEX index01(加入者ID);


################################
-- 6.4 Analysistablemaking
DROP TABLE IF EXISTS 2013_JMDC_ARM_SQLdata;
CREATE TABLE 2013_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201301) AS eventID 
FROM 
	医薬品_13
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201301) AS eventID 
FROM 
	傷病_13
;
ALTER TABLE 2013_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 6.5 Drop tables
DROP TABLE 母数_13;
DROP TABLE 医薬品_13;
DROP TABLE 医薬品_13_pre;
DROP TABLE 傷病_13;
DROP TABLE 傷病_13_pre;


################################
################################
## Dataset: 2014
-- 7.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_14;
CREATE TABLE 母数_14 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201401 AND 201412
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_14 ADD INDEX index01(加入者ID);


################################
-- 7.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_14_pre;
CREATE TABLE 医薬品_14_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_14)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_14_pre ADD INDEX index01(加入者ID);


-- 7.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_14;
CREATE TABLE 医薬品_14
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_14_pre 
	INNER JOIN 母数_14 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_14 ADD INDEX index01(加入者ID);


################################
-- 7.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_14_pre;
CREATE TABLE 傷病_14_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_14)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_14_pre ADD INDEX index01(加入者ID);
						
							 
-- 7.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_14;
CREATE TABLE 傷病_14 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_14_pre
	INNER JOIN 母数_14 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_14 ADD INDEX index01(加入者ID);


################################
-- 7.4 Analysistablemaking
DROP TABLE IF EXISTS 2014_JMDC_ARM_SQLdata;
CREATE TABLE 2014_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201401) AS eventID 
FROM 
	医薬品_14
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201401) AS eventID 
FROM 
	傷病_14
;
ALTER TABLE 2014_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 7.5 Drop tables
DROP TABLE 母数_14;
DROP TABLE 医薬品_14;
DROP TABLE 医薬品_14_pre;
DROP TABLE 傷病_14;
DROP TABLE 傷病_14_pre;


################################
################################
## Dataset: 2015
-- 8.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_15;
CREATE TABLE 母数_15 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201501 AND 201512
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_15 ADD INDEX index01(加入者ID);


-- 8.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_15_pre;
CREATE TABLE 医薬品_15_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_15)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_15_pre ADD INDEX index01(加入者ID);


-- 8.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_15;
CREATE TABLE 医薬品_15
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_15_pre 
	INNER JOIN 母数_15 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_15 ADD INDEX index01(加入者ID);


################################
-- 8.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_15_pre;
CREATE TABLE 傷病_15_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_15)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_15_pre ADD INDEX index01(加入者ID);
						
							 
-- 8.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_15;
CREATE TABLE 傷病_15 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_15_pre
	INNER JOIN 母数_15 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_15 ADD INDEX index01(加入者ID);


################################
-- 8.4 Analysistablemaking
DROP TABLE IF EXISTS 2015_JMDC_ARM_SQLdata;
CREATE TABLE 2015_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201501) AS eventID 
FROM 
	医薬品_15
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201501) AS eventID 
FROM 
	傷病_15
;
ALTER TABLE 2015_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 8.5. Drop tables
DROP TABLE 母数_15;
DROP TABLE 医薬品_15;
DROP TABLE 医薬品_15_pre;
DROP TABLE 傷病_15;
DROP TABLE 傷病_15_pre;


################################
################################
## Dataset: 2016
-- 9.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_16;
CREATE TABLE 母数_16 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201601 AND 201612
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_16 ADD INDEX index01(加入者ID);


################################
-- 9.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_16_pre;
CREATE TABLE 医薬品_16_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_16)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_16_pre ADD INDEX index01(加入者ID);


-- 9.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_16;
CREATE TABLE 医薬品_16
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_16_pre 
	INNER JOIN 母数_16 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_16 ADD INDEX index01(加入者ID);


################################
-- 9.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_16_pre;
CREATE TABLE 傷病_16_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_16)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_16_pre ADD INDEX index01(加入者ID);
						
							 
-- 9.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_16;
CREATE TABLE 傷病_16 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_16_pre
	INNER JOIN 母数_16 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_16 ADD INDEX index01(加入者ID);


################################
-- 9.4 Analysistablemaking
DROP TABLE IF EXISTS 2016_JMDC_ARM_SQLdata;
CREATE TABLE 2016_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201601) AS eventID 
FROM 
	医薬品_16
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201601) AS eventID 
FROM 
	傷病_16
;
ALTER TABLE 2016_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 9.5 Drop tables
DROP TABLE 母数_16;
DROP TABLE 医薬品_16;
DROP TABLE 医薬品_16_pre;
DROP TABLE 傷病_16;
DROP TABLE 傷病_16_pre;


################################
################################
## Dataset: 2017
-- 10.1 Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_17;
CREATE TABLE 母数_17 
SELECT 
	加入者ID, 観察開始年月 AS 観察開始年月, 観察終了年月 AS Omax
FROM 
	母数
WHERE 
	観察開始年月 BETWEEN 201701 AND 201712
AND 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_17 ADD INDEX index01(加入者ID);


################################
-- 10.2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_17_pre;
CREATE TABLE 医薬品_17_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_17)
AND 
	剤型大分類名 IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_17_pre ADD INDEX index01(加入者ID);


-- 10.2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_17;
CREATE TABLE 医薬品_17
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_17_pre 
	INNER JOIN 母数_17 USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 3
;
ALTER TABLE 医薬品_17 ADD INDEX index01(加入者ID);


################################
-- 10.3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_17_pre;
CREATE TABLE 傷病_17_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_17)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_17_pre ADD INDEX index01(加入者ID);
						
							 
-- 10.3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_17;
CREATE TABLE 傷病_17 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_17_pre
	INNER JOIN 母数_17 USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 3
;
ALTER TABLE 傷病_17 ADD INDEX index01(加入者ID);


################################
-- 10.4 Analysistablemaking
DROP TABLE IF EXISTS 2017_JMDC_ARM_SQLdata;
CREATE TABLE 2017_JMDC_ARM_SQLdata 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201701) AS eventID 
FROM 
	医薬品_17
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201701) AS eventID 
FROM 
	傷病_17
;
ALTER TABLE 2017_JMDC_ARM_SQLdata ADD INDEX index01(加入者ID); 


################################
-- 10.5 Drop tables
DROP TABLE 母数_17;
DROP TABLE 医薬品_17;
DROP TABLE 医薬品_17_pre;
DROP TABLE 傷病_17;
DROP TABLE 傷病_17_pre;


