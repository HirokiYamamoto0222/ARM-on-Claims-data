## MEMO ########################
-- Association rule mining
## Early detection for ADR signal
## Tablemaking(6 months)
################################
-- 0. Database
use JMDC_Claims


################################
-- 1. Extract ID (tracked more than 3 months)
DROP TABLE IF EXISTS 母数_6month;
CREATE TABLE 母数_6month 
SELECT 
	加入者ID, 観察開始年月, 観察終了年月
FROM 
	母数
WHERE 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 3
;
ALTER TABLE 母数_6month ADD INDEX index01(加入者ID);


################################
-- 2.1 Extract ID, prescribed drugs and service month (first occurrence)
DROP TABLE IF EXISTS 医薬品_6month_pre;
CREATE TABLE 医薬品_6month_pre 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品
WHERE 
	診療年月 BETWEEN 201710 AND 201806
AND 
	剤型大分類名 IN ('内用薬', '注射薬')
AND 
	ATC大分類コード NOT IN ('K', 'V')
GROUP BY
	加入者ID, 成分名
;
ALTER TABLE 医薬品_6month_pre ADD INDEX index01(加入者ID);


-- 2.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 医薬品_6month;
CREATE TABLE 医薬品_6month
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_6month_pre 
	INNER JOIN 母数_6month USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 201710) >= 3
;
ALTER TABLE 医薬品_6month ADD INDEX index01(加入者ID);


################################
-- 3.1 Extract ID, symptoms and service month (first occurrence)
DROP TABLE IF EXISTS 傷病_6month_pre;
CREATE TABLE 傷病_6month_pre
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病
WHERE 
	診療年月 BETWEEN 201710 AND 201806
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_6month_pre ADD INDEX index01(加入者ID);
						
							 
-- 3.2 Set Run-in-period: 3 months
DROP TABLE IF EXISTS 傷病_6month;
CREATE TABLE 傷病_6month 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_6month_pre
	INNER JOIN 母数_6month USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 201710) >= 3
;
ALTER TABLE 傷病_6month ADD INDEX index01(加入者ID);


################################
-- 4. Analysistablemaking
DROP TABLE IF EXISTS JMDC_ARM_SQLdata_6months_pre;
CREATE TABLE JMDC_ARM_SQLdata_6months_pre 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 201712) AS eventID 
FROM 
	医薬品_6month
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 201712) AS eventID 
FROM 
	傷病_6month
;
ALTER TABLE JMDC_ARM_SQLdata_6months_pre ADD INDEX index01(加入者ID); 
ALTER TABLE JMDC_ARM_SQLdata_6months_pre ADD INDEX index02(Item);


-- Follow the 1month data patients
DROP TABLE IF EXISTS JMDC_ARM_SQLdata_6months;
CREATE TABLE JMDC_ARM_SQLdata_6months
SELECT
	*
FROM
	JMDC_ARM_SQLdata_6months_pre
WHERE 
	加入者ID IN (SELECT DISTINCT 加入者ID FROM JMDC_ARM_SQLdata_1month)
;
ALTER TABLE JMDC_ARM_SQLdata_6months ADD INDEX index01(加入者ID); 
ALTER TABLE JMDC_ARM_SQLdata_6months ADD INDEX index02(Item);


################################
-- 5. Drop tables
DROP TABLE 母数_6month;
DROP TABLE 医薬品_6month;
DROP TABLE 医薬品_6month_pre;
DROP TABLE 傷病_6month;
DROP TABLE 傷病_6month_pre;


