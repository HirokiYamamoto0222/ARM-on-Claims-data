## MEMO ########################
-- Association rule mining
## Performance calculation
## Tablemaking
################################
-- 0. Database
use JMDC_Claims


################################
-- 1. Extract ID (tracked more than 6 months)
DROP TABLE IF EXISTS 母数_sub;
CREATE TABLE 母数_sub 
SELECT 
	加入者ID, 観察開始年月, 観察終了年月
FROM 
	母数
WHERE 
	PERIOD_DIFF(観察終了年月, 観察開始年月) >= 6
;
ALTER TABLE 母数_sub ADD INDEX index01(加入者ID);


################################
-- 2.1. Extract ID, prescribed drugs and service month
DROP TABLE IF EXISTS 医薬品_pre1;
CREATE TABLE 医薬品_pre1 
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_sub)
AND 
	剤型大分類名  IN ('内用薬', '注射薬')		# "内用薬" means Oral, "注射薬" means Injection
AND
	頓服フラグ = '0'			    			# "頓服フラグ = 0" means Non–potion
AND 
	ATC大分類コード NOT IN ('K', 'V')
;
ALTER TABLE 医薬品_pre1 ADD INDEX index01(加入者ID, 成分名, 診療年月);


-- 2.2. Extract first occurrence
DROP TABLE IF EXISTS 医薬品_pre2;
CREATE TABLE 医薬品_pre2 
SELECT 
	加入者ID, 成分名, MIN(診療年月) AS 診療年月
FROM 
	医薬品_pre1
GROUP BY 
	加入者ID, 成分名
;
ALTER TABLE 医薬品_pre2 ADD INDEX index01(加入者ID, 診療年月);


-- 2.3. Set Run-in-period: 6 months
DROP TABLE IF EXISTS 医薬品_ARM;
CREATE TABLE 医薬品_ARM
SELECT 
	加入者ID, 成分名, 診療年月
FROM 
	医薬品_pre2 
	INNER JOIN 母数_sub USING(加入者ID)
WHERE 
	PERIOD_DIFF(診療年月, 観察開始年月) >= 6
;
ALTER TABLE 医薬品_ARM ADD INDEX index01(加入者ID);


################################
-- 3.1. Extract ID, symptoms and service month
DROP TABLE IF EXISTS 傷病_pre1;
CREATE TABLE 傷病_pre1
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病
WHERE 
	加入者ID IN (SELECT 加入者ID FROM 母数_sub)
AND 
	ICD10大分類コード NOT IN ('O00-O99', 'Q00-Q99', 'V01-Y98', 'Z00-Z99')
AND 
	疑いフラグ = 0	# "疑いフラグ = 0" means Non–suspect
;
ALTER TABLE 傷病_pre1 ADD INDEX index01(加入者ID, ICD10小分類コード, 診療年月);


-- 3.2. Extract first occurrence
DROP TABLE IF EXISTS 傷病_pre2;
CREATE TABLE 傷病_pre2
SELECT 
	加入者ID, ICD10小分類コード, MIN(診療年月) AS 診療年月
FROM 
	傷病_pre1
GROUP BY 
	加入者ID, ICD10小分類コード
;
ALTER TABLE 傷病_pre2 ADD INDEX index01(加入者ID, 診療年月);
						
							 
-- 3.3. Set Run-in-period: 6 months
DROP TABLE IF EXISTS 傷病_ARM;
CREATE TABLE 傷病_ARM 
SELECT 
	加入者ID, ICD10小分類コード, 診療年月
FROM 
	傷病_pre2
	INNER JOIN 母数_sub USING(加入者ID)
WHERE 
	PERIOD_DIFF (診療年月, 観察開始年月) >= 6
;
ALTER TABLE 傷病_ARM ADD INDEX index01(加入者ID);


################################
-- 4. Analysistablemaking
DROP TABLE IF EXISTS JMDC_ARM_SQLdata_15y;
CREATE TABLE JMDC_ARM_SQLdata_15y 
SELECT 
	加入者ID, 成分名 AS Item, 診療年月 AS Evday, 
    PERIOD_DIFF(診療年月, 200501) AS eventID 
FROM 
	医薬品_ARM
UNION 
SELECT 
	加入者ID, ICD10小分類コード AS Item, 診療年月 AS Evday, 
	PERIOD_DIFF(診療年月, 200501) AS eventID 
FROM 
	傷病_ARM
;
ALTER TABLE JMDC_ARM_SQLdata_15y ADD INDEX index01(加入者ID); 


################################
-- 5. Drop tables
DROP TABLE IF EXISTS 医薬品_pre1;
DROP TABLE IF EXISTS 医薬品_pre2;
DROP TABLE IF EXISTS 医薬品_ARM;
DROP TABLE IF EXISTS 傷病_pre1;
DROP TABLE IF EXISTS 傷病_pre2;
DROP TABLE IF EXISTS 傷病_ARM;


