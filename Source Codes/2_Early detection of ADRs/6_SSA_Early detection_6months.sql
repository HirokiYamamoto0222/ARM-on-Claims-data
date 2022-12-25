## MEMO ########################
-- Sequence Symmetry Analysis
## Early detection of ADRs
## 6 months
################################
-- 0 Database
use JMDC_Claims


###############################################
-- 1 Preparation for result table
DROP TABLE IF EXISTS SSA_Analysis_6months;
CREATE TABLE SSA_Analysis_6months(
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


-- Table name "JMDC_ARM_SQLdata_6months" is pre-created in "3_ARM_Early detection_6month.sql"

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
						    	JMDC_ARM_SQLdata_6months
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
						    	JMDC_ARM_SQLdata_6months 
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


SELECT 6 INTO @Term;

		
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

INSERT INTO NSR_MonthTable SELECT 201801; INSERT INTO NSR_MonthTable SELECT 201802;
INSERT INTO NSR_MonthTable SELECT 201803; INSERT INTO NSR_MonthTable SELECT 201804;
INSERT INTO NSR_MonthTable SELECT 201805; INSERT INTO NSR_MonthTable SELECT 201806;


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

INSERT INTO preEventTotal 
SELECT 
	201804, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin >= PERIOD_ADD(201804, -@Term) 
AND 
	Emin < 201804
;

INSERT INTO preEventTotal 
SELECT 
	201805, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin >= PERIOD_ADD(201805, -@Term) 
AND 
	Emin < 201805
;

INSERT INTO preEventTotal 
SELECT 
	201806, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin >= PERIOD_ADD(201806, -@Term) 
AND 
	Emin < 201806
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

INSERT INTO postEventTotal 
SELECT 
	201804, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin <= PERIOD_ADD(201804, @Term) 
AND 
	Emin > 201804
;

INSERT INTO postEventTotal 
SELECT 
	201805, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin <= PERIOD_ADD(201805, @Term) 
AND 
	Emin > 201805
;

INSERT INTO postEventTotal 
SELECT 
	201806, 
	CASE WHEN SUM(Count) IS NULL THEN 0 ELSE SUM(Count) END AS COUNT
FROM 
	Incident_outcome 
WHERE 
	Emin <= PERIOD_ADD(201806, @Term) 
AND 
	Emin > 201806
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
    @insertvalue = CONCAT('INSERT INTO SSA_Analysis_6months VALUES 
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
CALL ESSA_PROCEDURE('タゾバクタムナトリウム・ピペラシリンナトリウム', 'A04', 3, 1);
CALL ESSA_PROCEDURE('イピリムマブ（遺伝子組換え）', 'A09', 3, 1);
CALL ESSA_PROCEDURE('シタラビン', 'A41', 3, 1);
CALL ESSA_PROCEDURE('リツキシマブ（遺伝子組換え）', 'B16', 3, 1);
CALL ESSA_PROCEDURE('ミコフェノール酸　モフェチル', 'B25', 3, 1);
CALL ESSA_PROCEDURE('タクロリムス水和物', 'D59', 3, 1);
CALL ESSA_PROCEDURE('ペメトレキセドナトリウム水和物', 'D61', 3, 1);
CALL ESSA_PROCEDURE('パルボシクリブ', 'D61', 3, 1);
CALL ESSA_PROCEDURE('リバビリン', 'D69', 3, 1);
CALL ESSA_PROCEDURE('スルファメトキサゾール・トリメトプリム', 'D70', 3, 1);
CALL ESSA_PROCEDURE('オキサリプラチン', 'D70', 3, 1);
CALL ESSA_PROCEDURE('アロプリノール', 'D72', 3, 1);
CALL ESSA_PROCEDURE('ニボルマブ（遺伝子組換え）', 'E03', 3, 1);
CALL ESSA_PROCEDURE('アミオダロン塩酸塩', 'E05', 3, 1);
CALL ESSA_PROCEDURE('インスリン　グラルギン（遺伝子組換え）', 'E16', 3, 1);
CALL ESSA_PROCEDURE('オランザピン', 'E78', 3, 1);
CALL ESSA_PROCEDURE('フロセミド', 'E86', 3, 1);
CALL ESSA_PROCEDURE('メトホルミン塩酸塩', 'E87', 3, 1);
CALL ESSA_PROCEDURE('インダパミド', 'E87', 3, 1);
CALL ESSA_PROCEDURE('フロセミド', 'E87', 3, 1);
CALL ESSA_PROCEDURE('ラミブジン', 'E88', 3, 1);
CALL ESSA_PROCEDURE('ベンダムスチン塩酸塩', 'E88', 3, 1);
CALL ESSA_PROCEDURE('バラシクロビル塩酸塩', 'F05', 3, 1);
CALL ESSA_PROCEDURE('ミルタザピン', 'F19', 3, 1);
CALL ESSA_PROCEDURE('バレニクリン酒石酸塩', 'F32', 3, 1);
CALL ESSA_PROCEDURE('パロキセチン塩酸塩', 'F38', 3, 1);
CALL ESSA_PROCEDURE('人免疫グロブリン', 'G03', 3, 1);
CALL ESSA_PROCEDURE('アテゾリズマブ（遺伝子組換え）', 'G04', 3, 1);
CALL ESSA_PROCEDURE('ハロペリドール', 'G21', 3, 1);
CALL ESSA_PROCEDURE('アリピプラゾール', 'G21', 3, 1);
CALL ESSA_PROCEDURE('アリピプラゾール', 'G24', 3, 1);
CALL ESSA_PROCEDURE('リスペリドン', 'G24', 3, 1);
CALL ESSA_PROCEDURE('ボルテゾミブ', 'G62', 3, 1);
CALL ESSA_PROCEDURE('Ａ型ボツリヌス毒素', 'H02', 3, 1);
CALL ESSA_PROCEDURE('ラモトリギン', 'H10', 3, 1);
CALL ESSA_PROCEDURE('アフリベルセプト（遺伝子組換え）', 'H26', 3, 1);
CALL ESSA_PROCEDURE('ヒドロキシクロロキン硫酸塩', 'H35', 3, 1);
CALL ESSA_PROCEDURE('トリアムシノロンアセトニド', 'H40', 3, 1);
CALL ESSA_PROCEDURE('アフリベルセプト（遺伝子組換え）', 'H44', 3, 1);
CALL ESSA_PROCEDURE('エタンブトール塩酸塩', 'H46', 3, 1);
CALL ESSA_PROCEDURE('ゲンタマイシン硫酸塩', 'H91', 3, 1);
CALL ESSA_PROCEDURE('レンバチニブメシル酸塩', 'I10', 3, 1);
CALL ESSA_PROCEDURE('アナグレリド塩酸塩水和物', 'I20', 3, 1);
CALL ESSA_PROCEDURE('セレコキシブ', 'I21', 3, 1);
CALL ESSA_PROCEDURE('レナリドミド水和物', 'I26', 3, 1);
CALL ESSA_PROCEDURE('ダサチニブ水和物', 'I27', 3, 1);
CALL ESSA_PROCEDURE('トラスツズマブ（遺伝子組換え）', 'I42', 3, 1);
CALL ESSA_PROCEDURE('ニロチニブ塩酸塩水和物', 'I45', 3, 1);
CALL ESSA_PROCEDURE('シロスタゾール', 'I48', 3, 1);
CALL ESSA_PROCEDURE('ドネペジル塩酸塩', 'I49', 3, 1);
CALL ESSA_PROCEDURE('エスシタロプラムシュウ酸塩', 'I49', 3, 1);
CALL ESSA_PROCEDURE('ボセンタン', 'I50', 3, 1);
CALL ESSA_PROCEDURE('リバーロキサバン', 'I61', 3, 1);
CALL ESSA_PROCEDURE('ラニビズマブ（遺伝子組換え）', 'I63', 3, 1);
CALL ESSA_PROCEDURE('ドロスピレノン・エチニルエストラジオール　ベータデクス', 'I80', 3, 1);
CALL ESSA_PROCEDURE('レナリドミド水和物', 'J18', 3, 1);
CALL ESSA_PROCEDURE('エナラプリルマレイン酸塩', 'J38', 3, 1);
CALL ESSA_PROCEDURE('ニボルマブ（遺伝子組換え）', 'J82', 3, 1);
CALL ESSA_PROCEDURE('アミオダロン塩酸塩', 'J84', 3, 1);
CALL ESSA_PROCEDURE('ジアゼパム', 'J96', 3, 1);
CALL ESSA_PROCEDURE('プロポフォール', 'J98', 3, 1);
CALL ESSA_PROCEDURE('デノスマブ（遺伝子組換え）', 'K10', 3, 1);
CALL ESSA_PROCEDURE('エベロリムス', 'K12', 3, 1);
CALL ESSA_PROCEDURE('アレンドロン酸ナトリウム水和物', 'K21', 3, 1);
CALL ESSA_PROCEDURE('アスピリン', 'K25', 3, 1);
CALL ESSA_PROCEDURE('イリノテカン塩酸塩水和物', 'K52', 3, 1);
CALL ESSA_PROCEDURE('アダリムマブ（遺伝子組換え）', 'K56', 3, 1);
CALL ESSA_PROCEDURE('ベバシズマブ（遺伝子組換え）', 'K63', 3, 1);
CALL ESSA_PROCEDURE('アモキシシリン水和物・クラブラン酸カリウム', 'K71', 3, 1);
CALL ESSA_PROCEDURE('イソニアジド', 'K76', 3, 1);
CALL ESSA_PROCEDURE('セフトリアキソンナトリウム水和物', 'K80', 3, 1);
CALL ESSA_PROCEDURE('オクトレオチド酢酸塩', 'K81', 3, 1);
CALL ESSA_PROCEDURE('イソニアジド', 'K83', 3, 1);
CALL ESSA_PROCEDURE('シタグリプチンリン酸塩水和物', 'K85', 3, 1);
CALL ESSA_PROCEDURE('リバーロキサバン', 'K92', 3, 1);
CALL ESSA_PROCEDURE('ラモトリギン', 'L51', 3, 1);
CALL ESSA_PROCEDURE('プロピルチオウラシル', 'M31', 3, 1);
CALL ESSA_PROCEDURE('アダリムマブ（遺伝子組換え）', 'M32', 3, 1);
CALL ESSA_PROCEDURE('シンバスタチン', 'M62', 3, 1);
CALL ESSA_PROCEDURE('レボフロキサシン', 'M77', 3, 1);
CALL ESSA_PROCEDURE('プレドニゾロン', 'M81', 3, 1);
CALL ESSA_PROCEDURE('バンコマイシン塩酸塩', 'N12', 3, 1);
CALL ESSA_PROCEDURE('バンコマイシン塩酸塩', 'N17', 3, 1);
CALL ESSA_PROCEDURE('ベバシズマブ（遺伝子組換え）', 'N39', 3, 1);
CALL ESSA_PROCEDURE('バレニクリン酒石酸塩', 'R11', 3, 1);
CALL ESSA_PROCEDURE('アモキシシリン', 'R21', 3, 1);
CALL ESSA_PROCEDURE('クラリスロマイシン', 'R43', 3, 1);
CALL ESSA_PROCEDURE('オセルタミビルリン酸塩', 'R44', 3, 1);
CALL ESSA_PROCEDURE('イミペネム水和物・シラスタチンナトリウム', 'R56', 3, 1);
CALL ESSA_PROCEDURE('ダサチニブ水和物', 'R60', 3, 1);
CALL ESSA_PROCEDURE('クエチアピンフマル酸塩', 'R73', 3, 1);
CALL ESSA_PROCEDURE('ロクロニウム臭化物', 'T78', 3, 1);

# Negative control
CALL ESSA_PROCEDURE('アミオダロン塩酸塩', 'A04', 3, 0);
CALL ESSA_PROCEDURE('オランザピン', 'A04', 3, 0);
CALL ESSA_PROCEDURE('ジアゼパム', 'A41', 3, 0);
CALL ESSA_PROCEDURE('ドネペジル塩酸塩', 'A41', 3, 0);
CALL ESSA_PROCEDURE('アリピプラゾール', 'B16', 3, 0);
CALL ESSA_PROCEDURE('フロセミド', 'B16', 3, 0);
CALL ESSA_PROCEDURE('シロスタゾール', 'B25', 3, 0);
CALL ESSA_PROCEDURE('パロキセチン塩酸塩', 'B25', 3, 0);
CALL ESSA_PROCEDURE('バレニクリン酒石酸塩', 'D59', 3, 0);
CALL ESSA_PROCEDURE('バレニクリン酒石酸塩', 'D61', 3, 0);
CALL ESSA_PROCEDURE('アフリベルセプト（遺伝子組換え）', 'D69', 3, 0);
CALL ESSA_PROCEDURE('Ａ型ボツリヌス毒素', 'D70', 3, 0);
CALL ESSA_PROCEDURE('インスリン　グラルギン（遺伝子組換え）', 'D70', 3, 0);
CALL ESSA_PROCEDURE('ラニビズマブ（遺伝子組換え）', 'D70', 3, 0);
CALL ESSA_PROCEDURE('イリノテカン塩酸塩水和物', 'E03', 3, 0);
CALL ESSA_PROCEDURE('レボフロキサシン', 'E03', 3, 0);
CALL ESSA_PROCEDURE('オキサリプラチン', 'E05', 3, 0);
CALL ESSA_PROCEDURE('セレコキシブ', 'E05', 3, 0);
CALL ESSA_PROCEDURE('パルボシクリブ', 'E16', 3, 0);
CALL ESSA_PROCEDURE('ペメトレキセドナトリウム水和物', 'E16', 3, 0);
CALL ESSA_PROCEDURE('セフトリアキソンナトリウム水和物', 'E78', 3, 0);
CALL ESSA_PROCEDURE('アフリベルセプト（遺伝子組換え）', 'E87', 3, 0);
CALL ESSA_PROCEDURE('シタグリプチンリン酸塩水和物', 'E88', 3, 0);
CALL ESSA_PROCEDURE('クエチアピンフマル酸塩', 'E88', 3, 0);
CALL ESSA_PROCEDURE('リバビリン', 'E88', 3, 0);
CALL ESSA_PROCEDURE('ラモトリギン', 'E88', 3, 0);
CALL ESSA_PROCEDURE('シンバスタチン', 'F19', 3, 0);
CALL ESSA_PROCEDURE('ベンダムスチン塩酸塩', 'F19', 3, 0);
CALL ESSA_PROCEDURE('リバーロキサバン', 'F32', 3, 0);
CALL ESSA_PROCEDURE('アレンドロン酸ナトリウム水和物', 'F38', 3, 0);
CALL ESSA_PROCEDURE('アスピリン', 'F38', 3, 0);
CALL ESSA_PROCEDURE('オキサリプラチン', 'G03', 3, 0);
CALL ESSA_PROCEDURE('インスリン　グラルギン（遺伝子組換え）', 'G04', 3, 0);
CALL ESSA_PROCEDURE('アダリムマブ（遺伝子組換え）', 'G21', 3, 0);
CALL ESSA_PROCEDURE('ボルテゾミブ', 'G21', 3, 0);
CALL ESSA_PROCEDURE('リバーロキサバン', 'G24', 3, 0);
CALL ESSA_PROCEDURE('リツキシマブ（遺伝子組換え）', 'G24', 3, 0);
CALL ESSA_PROCEDURE('バンコマイシン塩酸塩', 'G24', 3, 0);
CALL ESSA_PROCEDURE('エナラプリルマレイン酸塩', 'G62', 3, 0);
CALL ESSA_PROCEDURE('ボセンタン', 'G62', 3, 0);
CALL ESSA_PROCEDURE('レナリドミド水和物', 'H02', 3, 0);
CALL ESSA_PROCEDURE('インスリン　グラルギン（遺伝子組換え）', 'H10', 3, 0);
CALL ESSA_PROCEDURE('スルファメトキサゾール・トリメトプリム', 'H26', 3, 0);
CALL ESSA_PROCEDURE('エベロリムス', 'H26', 3, 0);
CALL ESSA_PROCEDURE('タゾバクタムナトリウム・ピペラシリンナトリウム', 'H35', 3, 0);
CALL ESSA_PROCEDURE('イリノテカン塩酸塩水和物', 'H40', 3, 0);
CALL ESSA_PROCEDURE('ミコフェノール酸　モフェチル', 'H40', 3, 0);
CALL ESSA_PROCEDURE('アロプリノール', 'H44', 3, 0);
CALL ESSA_PROCEDURE('メトホルミン塩酸塩', 'H46', 3, 0);
CALL ESSA_PROCEDURE('メトホルミン塩酸塩', 'H91', 3, 0);
CALL ESSA_PROCEDURE('プロピルチオウラシル', 'I20', 3, 0);
CALL ESSA_PROCEDURE('イソニアジド', 'I21', 3, 0);
CALL ESSA_PROCEDURE('バラシクロビル塩酸塩', 'I26', 3, 0);
CALL ESSA_PROCEDURE('レボフロキサシン', 'I27', 3, 0);
CALL ESSA_PROCEDURE('イミペネム水和物・シラスタチンナトリウム', 'I42', 3, 0);
CALL ESSA_PROCEDURE('エタンブトール塩酸塩', 'I48', 3, 0);
CALL ESSA_PROCEDURE('ハロペリドール', 'I61', 3, 0);
CALL ESSA_PROCEDURE('オセルタミビルリン酸塩', 'I63', 3, 0);
CALL ESSA_PROCEDURE('レボフロキサシン', 'I80', 3, 0);
CALL ESSA_PROCEDURE('インダパミド', 'J18', 3, 0);
CALL ESSA_PROCEDURE('ドロスピレノン・エチニルエストラジオール　ベータデクス', 'J84', 3, 0);
CALL ESSA_PROCEDURE('ドロスピレノン・エチニルエストラジオール　ベータデクス', 'J96', 3, 0);
CALL ESSA_PROCEDURE('アリピプラゾール', 'K10', 3, 0);
CALL ESSA_PROCEDURE('ボセンタン', 'K12', 3, 0);
CALL ESSA_PROCEDURE('デノスマブ（遺伝子組換え）', 'K56', 3, 0);
CALL ESSA_PROCEDURE('ラミブジン', 'K56', 3, 0);
CALL ESSA_PROCEDURE('リスペリドン', 'K63', 3, 0);
CALL ESSA_PROCEDURE('クラリスロマイシン', 'K80', 3, 0);
CALL ESSA_PROCEDURE('リバーロキサバン', 'K80', 3, 0);
CALL ESSA_PROCEDURE('トリアムシノロンアセトニド', 'K83', 3, 0);
CALL ESSA_PROCEDURE('ヒドロキシクロロキン硫酸塩', 'K92', 3, 0);
CALL ESSA_PROCEDURE('Ａ型ボツリヌス毒素', 'K92', 3, 0);
CALL ESSA_PROCEDURE('ドネペジル塩酸塩', 'M31', 3, 0);
CALL ESSA_PROCEDURE('ミルタザピン', 'M32', 3, 0);
CALL ESSA_PROCEDURE('ゲンタマイシン硫酸塩', 'M32', 3, 0);
CALL ESSA_PROCEDURE('ラニビズマブ（遺伝子組換え）', 'M62', 3, 0);
CALL ESSA_PROCEDURE('ドロスピレノン・エチニルエストラジオール　ベータデクス', 'M62', 3, 0);
CALL ESSA_PROCEDURE('トラスツズマブ（遺伝子組換え）', 'M77', 3, 0);
CALL ESSA_PROCEDURE('アナグレリド塩酸塩水和物', 'M77', 3, 0);
CALL ESSA_PROCEDURE('シタラビン', 'M81', 3, 0);
CALL ESSA_PROCEDURE('アリピプラゾール', 'N12', 3, 0);
CALL ESSA_PROCEDURE('エスシタロプラムシュウ酸塩', 'N17', 3, 0);
CALL ESSA_PROCEDURE('ジアゼパム', 'N39', 3, 0);
CALL ESSA_PROCEDURE('トリアムシノロンアセトニド', 'R43', 3, 0);
CALL ESSA_PROCEDURE('オクトレオチド酢酸塩', 'R44', 3, 0);
CALL ESSA_PROCEDURE('アフリベルセプト（遺伝子組換え）', 'R44', 3, 0);
CALL ESSA_PROCEDURE('アナグレリド塩酸塩水和物', 'R56', 3, 0);
CALL ESSA_PROCEDURE('アモキシシリン', 'R73', 3, 0);
