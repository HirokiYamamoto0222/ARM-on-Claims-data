## MEMO ########################
-- Sequence Symmetry Analysis
## Conventional benchmark
## 3 months
################################
-- 0. Database
use JMDC_Claims


###############################################
-- 1 Preparation for result table
DROP TABLE IF EXISTS SSA_Analysis_3months_CB;
CREATE TABLE SSA_Analysis_3months_CB(
    Ingredient VARCHAR(255),
    ICD10class VARCHAR(255),
    Runinperiod INT(11) DEFAULT NULL,
    Term INT(11) DEFAULT NULL,
    `A→E` INT(11) DEFAULT NULL,
    `E→A` INT(11) DEFAULT NULL,
    `A=E` INT(11) DEFAULT NULL,
    `CSR` DECIMAL(8, 5) DEFAULT NULL,
    `CSR 95%CI Lower` DECIMAL(8, 5) DEFAULT NULL,
    `CSR 95%CI Upper` DECIMAL(8, 5) DEFAULT NULL,
    `NSR` DECIMAL(8, 5) DEFAULT NULL,
    `ASR` DECIMAL(8, 5) DEFAULT NULL,
    `ASR 95%CI Lower` DECIMAL(8, 5) DEFAULT NULL,
    `ASR 95%CI Upper` DECIMAL(8, 5) DEFAULT NULL, 
    Ground_Truth INT(11) DEFAULT NULL
)
;


-- Table name "JMDC_ARM_SQLdata_3months" is pre-created in "2_ARM_Early detection_3month.sql"

###############################################
-- 2 Procedure
DROP PROCEDURE IF EXISTS ESSA_PROCEDURE;
DELIMITER //
CREATE PROCEDURE ESSA_PROCEDURE(Ingredient VARCHAR(255), ICD10class VARCHAR(255), Runinperiod INT(11), Ground_Truth INT(11))
BEGIN
	
	
-- 2.1 Create drug table
DROP TABLE IF EXISTS Drug_A;
SET
    @tablecreate1 = CONCAT('CREATE TABLE Drug_A 
    						SELECT 
    							加入者ID, Evday AS Amin
						    FROM 
						    	JMDC_ARM_SQLdata_3months
						    WHERE 
						    	Item IN ("', Ingredient, '") 
						    ;');
PREPARE tablecreate1 FROM @tablecreate1;
EXECUTE tablecreate1;
ALTER TABLE Drug_A ADD INDEX index01(加入者ID);


-- 2.2 Create event table
DROP TABLE IF EXISTS Event_E;
SET @tablecreate2 = CONCAT('CREATE TABLE Event_E 
							SELECT 
								加入者ID, Evday AS Emin 
						    FROM 
						    	JMDC_ARM_SQLdata_3months 
							WHERE 
								Item IN ("',ICD10class,'") 
							;');
PREPARE tablecreate2 FROM @tablecreate2;
EXECUTE tablecreate2;
ALTER TABLE Event_E ADD INDEX index01(加入者ID); 


#########################################
-- 3. Sequence Symmetry Analysis
-- 3.1 Table making
DROP TABLE IF EXISTS A_JMDC_ESSA;
CREATE TABLE A_JMDC_ESSA
SELECT
    t1.加入者ID,
    Amin,
    Emin
FROM
    Drug_A AS t1
    INNER JOIN Event_E AS t2 USING(加入者ID)
;
ALTER TABLE A_JMDC_ESSA ADD INDEX index01(Amin, Emin, 加入者ID);


-- 3.2 Calculation of the number of ID initiating drug
DROP TABLE IF EXISTS Incident_exposure;
SET @nsrtable = CONCAT('
	CREATE TABLE Incident_exposure
	SELECT 
		Amin, COUNT(DISTINCT 加入者ID) AS Count
	FROM
		Drug_A
	GROUP BY
		Amin
	;');
PREPARE nsrtable FROM @nsrtable;
EXECUTE nsrtable;


-- 3.3 Calculation of the number of ID registered for the event
DROP TABLE IF EXISTS Incident_outcome;
SET @nsrtable = CONCAT('
	CREATE TABLE Incident_outcome
	SELECT 
		Emin, COUNT(DISTINCT 加入者ID) AS Count
	FROM
		Event_E
	GROUP BY
		Emin
	;');
PREPARE nsrtable FROM @nsrtable;
EXECUTE nsrtable;


SELECT 3 INTO @Term;
		
		
-- 3.4 The number of 'drug → event'
SET @analysis1 = CONCAT('SELECT 
							COUNT(加入者ID) INTO @a 
						 FROM 
						 	A_JMDC_ESSA 
						 WHERE 
							Emin > Amin
						 AND 
						 	PERIOD_DIFF(Emin, Amin) <= @Term
						 ;');
PREPARE analysis1 FROM @analysis1;
EXECUTE analysis1;


-- 3.5 The number of 'event → drug'
SET @analysis2 = CONCAT('SELECT 
							COUNT(加入者ID) INTO @b 
						 FROM 
						 	A_JMDC_ESSA 
						 WHERE 
						 	Emin < Amin
						 AND 
						 	PERIOD_DIFF(Amin, Emin) <= @Term
						 ;');
PREPARE analysis2 FROM @analysis2;
EXECUTE analysis2;


-- 3.6 The number of 'drug = event'
SET @analysis3 = CONCAT('SELECT 
							COUNT(加入者ID) INTO @c FROM A_JMDC_ESSA 
						 WHERE 
						 	Emin = Amin
						 ;');
PREPARE analysis3 FROM @analysis3;
EXECUTE analysis3;


-- 3.7 Caluculation of NSR
DROP TABLE IF EXISTS NSR_MonthTable;
CREATE TABLE NSR_MonthTable(
       Months INT(11) default NULL
) 
;

INSERT INTO NSR_MonthTable SELECT 201801; 
INSERT INTO NSR_MonthTable SELECT 201802;
INSERT INTO NSR_MonthTable SELECT 201803; 


DROP TABLE IF EXISTS preEventTotal;
CREATE TABLE IF NOT EXISTS preEventTotal(
       Months INT(11) DEFAULT NULL,
       preTotal INT(11) DEFAULT NULL
)
;

-- 
INSERT INTO preEventTotal 
SELECT 
	201801, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin >= PERIOD_ADD(201801, -@Term) 
AND 
	Emin < 201801
;

INSERT INTO preEventTotal 
SELECT 
	201802, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin >= PERIOD_ADD(201802, -@Term) 
AND 
	Emin < 201802
;

INSERT INTO preEventTotal 
SELECT 
	201803, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin >= PERIOD_ADD(201803, -@Term) 
AND 
	Emin < 201803
;


DROP TABLE IF EXISTS postEventTotal;
CREATE TABLE IF NOT EXISTS postEventTotal(
       Months INT(11) DEFAULT NULL,
       postTotal INT(11) DEFAULT NULL
)
;

-- 
INSERT INTO postEventTotal 
SELECT 
	201801, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin <= PERIOD_ADD(201801, @Term) 
AND 
	Emin > 201801
;

INSERT INTO postEventTotal 
SELECT 
	201802, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin <= PERIOD_ADD(201802, @Term) 
AND 
	Emin > 201802
;

INSERT INTO postEventTotal 
SELECT 
	201803, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin <= PERIOD_ADD(201803, @Term) 
AND 
	Emin > 201803
;


-- 
DROP TABLE IF EXISTS NSR_MonthTable_Result_pre;
CREATE TABLE NSR_MonthTable_Result_pre
SELECT 
	t1.Months, 
	t2.Count AS AminCount, 
	t3.Count AS EminCount, 
	t4.preTotal, 
	t5.postTotal
FROM 
	NSR_MonthTable AS t1
    LEFT OUTER JOIN Incident_exposure t2 ON t1.Months = t2.Amin
	LEFT OUTER JOIN Incident_outcome t3 ON t1.Months = t3.Emin
	LEFT OUTER JOIN preEventTotal t4 ON t1.Months = t4.Months
	LEFT OUTER JOIN postEventTotal t5 ON t1.Months = t5.Months
;


-- 
DROP TABLE IF EXISTS NSR_MonthTable_Result;
CREATE TABLE NSR_MonthTable_Result
SELECT 
	*, 
	AminCount * postTotal AS molecule, 
	AminCount * (preTotal + postTotal) AS denominator
FROM 
	NSR_MonthTable_Result_pre
;


-- NSR
SELECT SUM(分子) / SUM(分母) INTO @x FROM NSR_MonthTable_Result;
SELECT @x / (1 - @x) INTO @NSR;


-- CSR
SELECT @a / @b INTO @CSR;

# CSR_lower
SELECT exp(log(@CSR) - 1.96 * sqrt(1/@a + 1/@b)) INTO @CSR_lower;

# CSR_upper
SELECT exp(log(@CSR) + 1.96 * sqrt(1/@a + 1/@b)) INTO @CSR_upper;


-- ASR
SELECT @CSR/@NSR INTO @ASR;
SELECT @CSR_lower/@NSR INTO @ASR_lower;
SELECT @CSR_upper/@NSR INTO @ASR_upper;


-- 3.7 Insert
SET
    @insertvalue = CONCAT('INSERT INTO SSA_Analysis_3months_CB VALUES 
						  ("', ingredient, '", "', ICD10class, '", ', Runinperiod, ', 
						  @Term, @a, @b, @c, @CSR, @CSR_lower, @CSR_upper, 
						  @NSR, @ASR, @ASR_lower, @ASR_upper, ', Ground_Truth, ');')
;
PREPARE insertvalue from @insertvalue;
EXECUTE insertvalue;


################################
-- 4. Drop tables
DROP TABLE IF EXISTS Drug_A;
DROP TABLE IF EXISTS Drug_AO;
DROP TABLE IF EXISTS Event_E;
DROP TABLE IF EXISTS Event_EO;
DROP TABLE IF EXISTS A_JMDC_ESSA;
DROP TABLE IF EXISTS Incident_exposure;
DROP TABLE IF EXISTS Incident_outcome;
DROP TABLE IF EXISTS preEventTotal;
DROP TABLE IF EXISTS postEventTotal;
DROP TABLE IF EXISTS NSR_MonthTable;
DROP TABLE IF EXISTS NSR_MonthTable_Result_pre;
DROP TABLE IF EXISTS NSR_MonthTable_Result;


END //
DELIMITER ;


#########################################
-- 5. Call procedure
# Positive control
CALL ESSA_PROCEDURE('アシクロビル', 'N17', 3, 1);
CALL ESSA_PROCEDURE('アムロジピンベシル酸塩', 'I21', 3, 1);
CALL ESSA_PROCEDURE('アロプリノール', 'K71', 3, 1);
CALL ESSA_PROCEDURE('イブプロフェン', 'N17', 3, 1);
CALL ESSA_PROCEDURE('イブプロフェン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('イブプロフェン', 'K92', 3, 1);
CALL ESSA_PROCEDURE('インドメタシン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('インドメタシン', 'I21', 3, 1);
CALL ESSA_PROCEDURE('インドメタシン', 'K92', 3, 1);
CALL ESSA_PROCEDURE('エスシタロプラムシュウ酸塩', 'K92', 3, 1);
CALL ESSA_PROCEDURE('エストラジオール', 'I21', 3, 1);
CALL ESSA_PROCEDURE('エトドラク', 'K71', 3, 1);
CALL ESSA_PROCEDURE('エトドラク', 'I21', 3, 1);
CALL ESSA_PROCEDURE('エトドラク', 'K92', 3, 1);
CALL ESSA_PROCEDURE('エポエチン　アルファ（遺伝子組換え）', 'I21', 3, 1);
CALL ESSA_PROCEDURE('エリスロマイシン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('オキサプロジン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('オキサプロジン', 'I21', 3, 1);
CALL ESSA_PROCEDURE('オキサプロジン', 'K92', 3, 1);
CALL ESSA_PROCEDURE('オフロキサシン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('オルメサルタン　メドキソミル', 'N17', 3, 1);
CALL ESSA_PROCEDURE('カルバマゼピン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('キナプリル塩酸塩', 'K71', 3, 1);
CALL ESSA_PROCEDURE('クリンダマイシン塩酸塩', 'K92', 3, 1);
CALL ESSA_PROCEDURE('クロピドグレル硫酸塩', 'K92', 3, 1);
CALL ESSA_PROCEDURE('シクロスポリン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ジピリダモール', 'I21', 3, 1);
CALL ESSA_PROCEDURE('シプロフロキサシン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ジルチアゼム塩酸塩', 'K71', 3, 1);
CALL ESSA_PROCEDURE('スマトリプタン', 'I21', 3, 1);
CALL ESSA_PROCEDURE('スリンダク', 'K71', 3, 1);
CALL ESSA_PROCEDURE('スリンダク', 'I21', 3, 1);
CALL ESSA_PROCEDURE('セルトラリン塩酸塩', 'K92', 3, 1);
CALL ESSA_PROCEDURE('セレコキシブ', 'K71', 3, 1);
CALL ESSA_PROCEDURE('タモキシフェンクエン酸塩', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ダルベポエチン　アルファ（遺伝子組換え）', 'I21', 3, 1);
CALL ESSA_PROCEDURE('テルビナフィン塩酸塩', 'K71', 3, 1);
CALL ESSA_PROCEDURE('トランドラプリル', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ナプロキセン', 'N17', 3, 1);
CALL ESSA_PROCEDURE('ナプロキセン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ナプロキセン', 'K92', 3, 1);
CALL ESSA_PROCEDURE('ニフェジピン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ニフェジピン', 'I21', 3, 1);
CALL ESSA_PROCEDURE('ノルトリプチリン塩酸塩', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ノルトリプチリン塩酸塩', 'I21', 3, 1);
CALL ESSA_PROCEDURE('バルプロ酸ナトリウム', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ピオグリタゾン塩酸塩', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ヒドロクロロチアジド', 'N17', 3, 1);
CALL ESSA_PROCEDURE('ピロキシカム', 'K71', 3, 1);
CALL ESSA_PROCEDURE('ピロキシカム', 'I21', 3, 1);
CALL ESSA_PROCEDURE('ピロキシカム', 'K92', 3, 1);
CALL ESSA_PROCEDURE('フルコナゾール', 'K71', 3, 1);
CALL ESSA_PROCEDURE('メトトレキサート', 'K71', 3, 1);
CALL ESSA_PROCEDURE('メロキシカム', 'N17', 3, 1);
CALL ESSA_PROCEDURE('メロキシカム', 'K92', 3, 1);
CALL ESSA_PROCEDURE('ラモトリギン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('リシノプリル', 'N17', 3, 1);
CALL ESSA_PROCEDURE('リシノプリル', 'K71', 3, 1);
CALL ESSA_PROCEDURE('レボフロキサシン', 'K71', 3, 1);
CALL ESSA_PROCEDURE('塩化カリウム', 'K92', 3, 1);
CALL ESSA_PROCEDURE('結合型エストロゲン', 'I21', 3, 1);


# Negative control
CALL ESSA_PROCEDURE('アデノシン三リン酸二ナトリウム水和物', 'K71', 3, 0);
CALL ESSA_PROCEDURE('アデノシン三リン酸二ナトリウム水和物', 'K92', 3, 0);
CALL ESSA_PROCEDURE('エポエチン　アルファ（遺伝子組換え）', 'K92', 3, 0);
CALL ESSA_PROCEDURE('オキシブチニン塩酸塩', 'K71', 3, 0);
CALL ESSA_PROCEDURE('オキシブチニン塩酸塩', 'I21', 3, 0);
CALL ESSA_PROCEDURE('オキシブチニン塩酸塩', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ガチフロキサシン水和物', 'K71', 3, 0);
CALL ESSA_PROCEDURE('ガチフロキサシン水和物', 'I21', 3, 0);
CALL ESSA_PROCEDURE('グリセオフルビン', 'K71', 3, 0);
CALL ESSA_PROCEDURE('クリンダマイシン塩酸塩', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ジサイクロミン塩酸塩', 'K71', 3, 0);
CALL ESSA_PROCEDURE('ジサイクロミン塩酸塩', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ジサイクロミン塩酸塩', 'K92', 3, 0);
CALL ESSA_PROCEDURE('シタグリプチンリン酸塩水和物', 'K71', 3, 0);
CALL ESSA_PROCEDURE('シタグリプチンリン酸塩水和物', 'I21', 3, 0);
CALL ESSA_PROCEDURE('シタグリプチンリン酸塩水和物', 'K92', 3, 0);
CALL ESSA_PROCEDURE('スクラルファート水和物', 'K71', 3, 0);
CALL ESSA_PROCEDURE('スクラルファート水和物', 'I21', 3, 0);
CALL ESSA_PROCEDURE('スクラルファート水和物', 'K92', 3, 0);
CALL ESSA_PROCEDURE('テルビナフィン塩酸塩', 'I21', 3, 0);
CALL ESSA_PROCEDURE('テルビナフィン塩酸塩', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ピオグリタゾン塩酸塩', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ブチルスコポラミン臭化物', 'K71', 3, 0);
CALL ESSA_PROCEDURE('ブチルスコポラミン臭化物', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ブチルスコポラミン臭化物', 'K92', 3, 0);
CALL ESSA_PROCEDURE('プロクロルペラジンマレイン酸塩', 'I21', 3, 0);
CALL ESSA_PROCEDURE('プロクロルペラジンマレイン酸塩', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ベンジルペニシリンベンザチン水和物', 'K71', 3, 0);
CALL ESSA_PROCEDURE('ベンジルペニシリンベンザチン水和物', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ベンジルペニシリンベンザチン水和物', 'K92', 3, 0);
CALL ESSA_PROCEDURE('メトカルバモール', 'I21', 3, 0);
CALL ESSA_PROCEDURE('メトカルバモール', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ラクツロース', 'K71', 3, 0);
CALL ESSA_PROCEDURE('ラクツロース', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ラクツロース', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ラメルテオン', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ロラタジン', 'N17', 3, 0);
CALL ESSA_PROCEDURE('ロラタジン', 'I21', 3, 0);
CALL ESSA_PROCEDURE('ロラタジン', 'K92', 3, 0);


