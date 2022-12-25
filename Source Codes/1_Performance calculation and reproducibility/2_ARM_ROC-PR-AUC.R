## MEMO ###################################################################
# 0. Library preparation
###########################################################################
library(DBI)
library(RMySQL)
library(readr)
library(tidyverse)
library(arules) 
library(pROC)
library(PRROC)


## MEMO ###################################################################
# 1. Connection to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'JMDC_Claims', user = 'root')
JMDC_ARM_SQLdata_15y <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata_15y <- dbGetQuery(dbconnector, 'SELECT * FROM JMDC_ARM_SQLdata_15y')
class(JMDC_ARM_SQLdata_15y)


## MEMO ###################################################################
# 2. Preprocessing
###########################################################################
JMDC_ARM_SQLdata_15y <- cbind(substring(JMDC_ARM_SQLdata_15y$加入者ID, 2, 10),
                              JMDC_ARM_SQLdata_15y[, 3],
                              JMDC_ARM_SQLdata_15y[, 4],
                              JMDC_ARM_SQLdata_15y[, 2])
colnames(JMDC_ARM_SQLdata_15y) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata_15y <- data.frame(JMDC_ARM_SQLdata_15y)
JMDC_ARM_SQLdata_15y$加入者ID <- as.numeric(JMDC_ARM_SQLdata_15y$加入者ID)
JMDC_ARM_SQLdata_15y$eventID <- as.numeric(JMDC_ARM_SQLdata_15y$eventID)
sapply(JMDC_ARM_SQLdata_15y, class)

# Remove duplicate 加入者ID
ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata_15y[, 1]))

# Add column name
colnames(ID_Table) <- cbind('加入者ID')

# Format the data
ID_Table <- data.frame(ID_Table)

# Separate records by ID
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID); 

# Create the function
decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                    }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata_15y)

# Transaction-Data
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(ARM_TransactionData_15y, file = 'JMDC_ARM_15y.csv', format = 'basket')

# Remove tables
rm(JMDC_ARM_SQLdata_15y); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)


## MEMO ###################################################################
# 3. Association rule mining
###########################################################################
# Read transaction
ARM_TransactionData_15y <- read.transactions('JMDC_ARM_15y.csv', format = 'basket')
JMDC_ARM_rules_15y <- apriori(ARM_TransactionData_15y, 
                              parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))
inspect(JMDC_ARM_rules_15y)

# lift, conviction, chiSquared
JMDC_ARM_15y_inspectdata <- cbind(
                                  as(JMDC_ARM_rules_15y, "data.frame"), 
                                  conviction = interestMeasure(JMDC_ARM_rules_15y, "conviction", trans), 
                                  chiSquared = interestMeasure(JMDC_ARM_rules_15y, "chiSquared", trans),
                                  "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_15y, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), # ここにはchisquaredをいれる
                                  "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_15y, "fishersExactTest", trans))
                                  )

JMDC_ARM_15y_inspectdata["rules"] <- lapply(JMDC_ARM_15y_inspectdata["rules"], 
                                            gsub, 
                                            pattern = "{", 
                                            replacement = "", fixed=TRUE)

JMDC_ARM_15y_inspectdata["rules"] <- lapply(JMDC_ARM_15y_inspectdata["rules"], 
                                            gsub, 
                                            pattern = "}", 
                                            replacement = "", fixed=TRUE)

JMDC_ARM_15y_inspectdata <- JMDC_ARM_15y_inspectdata %>% 
                            separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_15y_inspectdata, class)


## MEMO ########################
# Positive controls
################################
Result_GS_positive_15y <- subset(JMDC_ARM_15y_inspectdata, 
                                   cause == 'タゾバクタムナトリウム・ピペラシリンナトリウム' & effect == 'A04'|
                                   cause == 'イピリムマブ（遺伝子組換え）' & effect == 'A09'|
                                   cause == 'シタラビン' & effect == 'A41'|
                                   cause == 'リツキシマブ（遺伝子組換え）' & effect == 'B16'|
                                   cause == 'ミコフェノール酸　モフェチル' & effect == 'B25'|
                                   cause == 'タクロリムス水和物' & effect == 'D59'|
                                   cause == 'ペメトレキセドナトリウム水和物' & effect == 'D61'|
                                   cause == 'パルボシクリブ' & effect == 'D61'|
                                   cause == 'リバビリン' & effect == 'D69'|
                                   cause == 'スルファメトキサゾール・トリメトプリム' & effect == 'D70'|
                                   cause == 'オキサリプラチン' & effect == 'D70'|
                                   cause == 'アロプリノール' & effect == 'D72'|
                                   cause == 'ニボルマブ（遺伝子組換え）' & effect == 'E03'|
                                   cause == 'アミオダロン塩酸塩' & effect == 'E05'|
                                   cause == 'インスリン　グラルギン（遺伝子組換え）' & effect == 'E16'|
                                   cause == 'オランザピン' & effect == 'E78'|
                                   cause == 'フロセミド' & effect == 'E86'|
                                   cause == 'メトホルミン塩酸塩' & effect == 'E87'|
                                   cause == 'インダパミド' & effect == 'E87'|
                                   cause == 'フロセミド' & effect == 'E87'|
                                   cause == 'ラミブジン' & effect == 'E88'|
                                   cause == 'ベンダムスチン塩酸塩' & effect == 'E88'|
                                   cause == 'バラシクロビル塩酸塩' & effect == 'F05'|
                                   cause == 'ミルタザピン' & effect == 'F19'|
                                   cause == 'バレニクリン酒石酸塩' & effect == 'F32'|
                                   cause == 'パロキセチン塩酸塩' & effect == 'F38'|
                                   cause == '人免疫グロブリン' & effect == 'G03'|
                                   cause == 'アテゾリズマブ（遺伝子組換え）' & effect == 'G04'|
                                   cause == 'ハロペリドール' & effect == 'G21'|
                                   cause == 'アリピプラゾール' & effect == 'G21'|
                                   cause == 'アリピプラゾール' & effect == 'G24'|
                                   cause == 'リスペリドン' & effect == 'G24'|
                                   cause == 'ボルテゾミブ' & effect == 'G62'|
                                   cause == 'Ａ型ボツリヌス毒素' & effect == 'H02'|
                                   cause == 'ラモトリギン' & effect == 'H10'|
                                   cause == 'アフリベルセプト（遺伝子組換え）' & effect == 'H26'|
                                   cause == 'ヒドロキシクロロキン硫酸塩' & effect == 'H35'|
                                   cause == 'トリアムシノロンアセトニド' & effect == 'H40'|
                                   cause == 'アフリベルセプト（遺伝子組換え）' & effect == 'H44'|
                                   cause == 'エタンブトール塩酸塩' & effect == 'H46'|
                                   cause == 'ゲンタマイシン硫酸塩' & effect == 'H91'|
                                   cause == 'レンバチニブメシル酸塩' & effect == 'I10'|
                                   cause == 'アナグレリド塩酸塩水和物' & effect == 'I20'|
                                   cause == 'セレコキシブ' & effect == 'I21'|
                                   cause == 'レナリドミド水和物' & effect == 'I26'|
                                   cause == 'ダサチニブ水和物' & effect == 'I27'|
                                   cause == 'トラスツズマブ（遺伝子組換え）' & effect == 'I42'|
                                   cause == 'ニロチニブ塩酸塩水和物' & effect == 'I45'|
                                   cause == 'シロスタゾール' & effect == 'I48'|
                                   cause == 'ドネペジル塩酸塩' & effect == 'I49'|
                                   cause == 'エスシタロプラムシュウ酸塩' & effect == 'I49'|
                                   cause == 'ボセンタン' & effect == 'I50'|
                                   cause == 'リバーロキサバン' & effect == 'I61'|
                                   cause == 'ラニビズマブ（遺伝子組換え）' & effect == 'I63'|
                                   cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス' & effect == 'I80'|
                                   cause == 'レナリドミド水和物' & effect == 'J18'|
                                   cause == 'エナラプリルマレイン酸塩' & effect == 'J38'|
                                   cause == 'ニボルマブ（遺伝子組換え）' & effect == 'J82'|
                                   cause == 'アミオダロン塩酸塩' & effect == 'J84'|
                                   cause == 'ジアゼパム' & effect == 'J96'|
                                   cause == 'プロポフォール' & effect == 'J98'|
                                   cause == 'デノスマブ（遺伝子組換え）' & effect == 'K10'|
                                   cause == 'エベロリムス' & effect == 'K12'|
                                   cause == 'アレンドロン酸ナトリウム水和物' & effect == 'K21'|
                                   cause == 'アスピリン' & effect == 'K25'|
                                   cause == 'イリノテカン塩酸塩水和物' & effect == 'K52'|
                                   cause == 'アダリムマブ（遺伝子組換え）' & effect == 'K56'|
                                   cause == 'ベバシズマブ（遺伝子組換え）' & effect == 'K63'|
                                   cause == 'アモキシシリン水和物・クラブラン酸カリウム' & effect == 'K71'|
                                   cause == 'イソニアジド' & effect == 'K76'|
                                   cause == 'セフトリアキソンナトリウム水和物' & effect == 'K80'|
                                   cause == 'オクトレオチド酢酸塩' & effect == 'K81'|
                                   cause == 'イソニアジド' & effect == 'K83'|
                                   cause == 'シタグリプチンリン酸塩水和物' & effect == 'K85'|
                                   cause == 'リバーロキサバン' & effect == 'K92'|
                                   cause == 'ラモトリギン' & effect == 'L51'|
                                   cause == 'プロピルチオウラシル' & effect == 'M31'|
                                   cause == 'アダリムマブ（遺伝子組換え）' & effect == 'M32'|
                                   cause == 'シンバスタチン' & effect == 'M62'|
                                   cause == 'レボフロキサシン' & effect == 'M77'|
                                   cause == 'プレドニゾロン' & effect == 'M81'|
                                   cause == 'バンコマイシン塩酸塩' & effect == 'N12'|
                                   cause == 'バンコマイシン塩酸塩' & effect == 'N17'|
                                   cause == 'ベバシズマブ（遺伝子組換え）' & effect == 'N39'|
                                   cause == 'バレニクリン酒石酸塩' & effect == 'R11'|
                                   cause == 'アモキシシリン' & effect == 'R21'|
                                   cause == 'クラリスロマイシン' & effect == 'R43'|
                                   cause == 'オセルタミビルリン酸塩' & effect == 'R44'|
                                   cause == 'イミペネム水和物・シラスタチンナトリウム' & effect == 'R56'|
                                   cause == 'ダサチニブ水和物' & effect == 'R60'|
                                   cause == 'クエチアピンフマル酸塩' & effect == 'R73'|
                                   cause == 'ロクロニウム臭化物' & effect == 'T78'
)


## MEMO ########################
# Negative controls
################################
Result_GS_negative_15y <- subset(JMDC_ARM_15y_inspectdata, 
                                   cause == 'アミオダロン塩酸塩' & effect == 'A04'|
                                   cause == 'オランザピン' & effect == 'A04'|
                                   cause == 'ジアゼパム' & effect == 'A41'|
                                   cause == 'ドネペジル塩酸塩' & effect == 'A41'|
                                   cause == 'アリピプラゾール' & effect == 'B16'|
                                   cause == 'フロセミド' & effect == 'B16'|
                                   cause == 'シロスタゾール' & effect == 'B25'|
                                   cause == 'パロキセチン塩酸塩' & effect == 'B25'|
                                   cause == 'バレニクリン酒石酸塩' & effect == 'D59'|
                                   cause == 'バレニクリン酒石酸塩' & effect == 'D61'|
                                   cause == 'アフリベルセプト（遺伝子組換え）' & effect == 'D69'|
                                   cause == 'Ａ型ボツリヌス毒素' & effect == 'D70'|
                                   cause == 'インスリン　グラルギン（遺伝子組換え）' & effect == 'D70'|
                                   cause == 'ラニビズマブ（遺伝子組換え）' & effect == 'D70'|
                                   cause == 'イリノテカン塩酸塩水和物' & effect == 'E03'|
                                   cause == 'レボフロキサシン' & effect == 'E03'|
                                   cause == 'オキサリプラチン' & effect == 'E05'|
                                   cause == 'セレコキシブ' & effect == 'E05'|
                                   cause == 'パルボシクリブ' & effect == 'E16'|
                                   cause == 'ペメトレキセドナトリウム水和物' & effect == 'E16'|
                                   cause == 'セフトリアキソンナトリウム水和物' & effect == 'E78'|
                                   cause == 'アフリベルセプト（遺伝子組換え）' & effect == 'E87'|
                                   cause == 'シタグリプチンリン酸塩水和物' & effect == 'E88'|
                                   cause == 'クエチアピンフマル酸塩' & effect == 'E88'|
                                   cause == 'リバビリン' & effect == 'E88'|
                                   cause == 'ラモトリギン' & effect == 'E88'|
                                   cause == 'シンバスタチン' & effect == 'F19'|
                                   cause == 'ベンダムスチン塩酸塩' & effect == 'F19'|
                                   cause == 'リバーロキサバン' & effect == 'F32'|
                                   cause == 'アレンドロン酸ナトリウム水和物' & effect == 'F38'|
                                   cause == 'アスピリン' & effect == 'F38'|
                                   cause == 'オキサリプラチン' & effect == 'G03'|
                                   cause == 'インスリン　グラルギン（遺伝子組換え）' & effect == 'G04'|
                                   cause == 'アダリムマブ（遺伝子組換え）' & effect == 'G21'|
                                   cause == 'ボルテゾミブ' & effect == 'G21'|
                                   cause == 'リバーロキサバン' & effect == 'G24'|
                                   cause == 'リツキシマブ（遺伝子組換え）' & effect == 'G24'|
                                   cause == 'バンコマイシン塩酸塩' & effect == 'G24'|
                                   cause == 'エナラプリルマレイン酸塩' & effect == 'G62'|
                                   cause == 'ボセンタン' & effect == 'G62'|
                                   cause == 'レナリドミド水和物' & effect == 'H02'|
                                   cause == 'インスリン　グラルギン（遺伝子組換え）' & effect == 'H10'|
                                   cause == 'スルファメトキサゾール・トリメトプリム' & effect == 'H26'|
                                   cause == 'エベロリムス' & effect == 'H26'|
                                   cause == 'タゾバクタムナトリウム・ピペラシリンナトリウム' & effect == 'H35'|
                                   cause == 'イリノテカン塩酸塩水和物' & effect == 'H40'|
                                   cause == 'ミコフェノール酸　モフェチル' & effect == 'H40'|
                                   cause == 'アロプリノール' & effect == 'H44'|
                                   cause == 'メトホルミン塩酸塩' & effect == 'H46'|
                                   cause == 'メトホルミン塩酸塩' & effect == 'H91'|
                                   cause == 'プロピルチオウラシル' & effect == 'I20'|
                                   cause == 'イソニアジド' & effect == 'I21'|
                                   cause == 'バラシクロビル塩酸塩' & effect == 'I26'|
                                   cause == 'レボフロキサシン' & effect == 'I27'|
                                   cause == 'イミペネム水和物・シラスタチンナトリウム' & effect == 'I42'|
                                   cause == 'エタンブトール塩酸塩' & effect == 'I48'|
                                   cause == 'ハロペリドール' & effect == 'I61'|
                                   cause == 'オセルタミビルリン酸塩' & effect == 'I63'|
                                   cause == 'レボフロキサシン' & effect == 'I80'|
                                   cause == 'インダパミド' & effect == 'J18'|
                                   cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス' & effect == 'J84'|
                                   cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス' & effect == 'J96'|
                                   cause == 'アリピプラゾール' & effect == 'K10'|
                                   cause == 'ボセンタン' & effect == 'K12'|
                                   cause == 'デノスマブ（遺伝子組換え）' & effect == 'K56'|
                                   cause == 'ラミブジン' & effect == 'K56'|
                                   cause == 'リスペリドン' & effect == 'K63'|
                                   cause == 'クラリスロマイシン' & effect == 'K80'|
                                   cause == 'リバーロキサバン' & effect == 'K80'|
                                   cause == 'トリアムシノロンアセトニド' & effect == 'K83'|
                                   cause == 'ヒドロキシクロロキン硫酸塩' & effect == 'K92'|
                                   cause == 'Ａ型ボツリヌス毒素' & effect == 'K92'|
                                   cause == 'ドネペジル塩酸塩' & effect == 'M31'|
                                   cause == 'ミルタザピン' & effect == 'M32'|
                                   cause == 'ゲンタマイシン硫酸塩' & effect == 'M32'|
                                   cause == 'ラニビズマブ（遺伝子組換え）' & effect == 'M62'|
                                   cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス' & effect == 'M62'|
                                   cause == 'トラスツズマブ（遺伝子組換え）' & effect == 'M77'|
                                   cause == 'アナグレリド塩酸塩水和物' & effect == 'M77'|
                                   cause == 'シタラビン' & effect == 'M81'|
                                   cause == 'アリピプラゾール' & effect == 'N12'|
                                   cause == 'エスシタロプラムシュウ酸塩' & effect == 'N17'|
                                   cause == 'ジアゼパム' & effect == 'N39'|
                                   cause == 'トリアムシノロンアセトニド' & effect == 'R43'|
                                   cause == 'オクトレオチド酢酸塩' & effect == 'R44'|
                                   cause == 'アフリベルセプト（遺伝子組換え）' & effect == 'R44'|
                                   cause == 'アナグレリド塩酸塩水和物' & effect == 'R56'|
                                   cause == 'アモキシシリン' & effect == 'R73'
)

# Remove tables
rm(ARM_TransactionData_15y); rm(JMDC_ARM_rules_15y); rm(JMDC_ARM_15y_inspectdata);


## MEMO #########################################################################
# 4. Gold standard
#################################################################################
Goldstandard <- read_csv('Goldstandard.csv', col_names=TRUE, na=c("","NA", "NULL"))
colnames(Goldstandard)<-cbind('Drugname', 'ICD10', 'Ground_Truth')


## MEMO #########################################################################
# 5. Align digits
#################################################################################
Result_GS_Summary_15y_pre <- rbind(Result_GS_positive_15y, Result_GS_negative_15y)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_15y_pre1 <- data.frame(
                              cbind(
                                    subset(Result_GS_Summary_15y_pre, count < 10)[, 1:2], 
                                    subset(Result_GS_Summary_15y_pre, count < 10)[, 6:7],
                                    subset(Result_GS_Summary_15y_pre, count < 10)[, 8],
                                    subset(Result_GS_Summary_15y_pre, count < 10)[, 11])
                                )
colnames(Result_GS_Summary_15y_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_15y_pre2 <- data.frame(
                              cbind(
                                    subset(Result_GS_Summary_15y_pre, count >= 10)[, 1:2], 
                                    subset(Result_GS_Summary_15y_pre, count >= 10)[, 6:7],
                                    subset(Result_GS_Summary_15y_pre, count >= 10)[, 8],
                                    subset(Result_GS_Summary_15y_pre, count >= 10)[, 10])
                                    )
colnames(Result_GS_Summary_15y_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_15y <- rbind(Result_GS_Summary_15y_pre1, Result_GS_Summary_15y_pre2)

# Align digits
Result_GS_Summary_15y <- cbind(
                                Result_GS_Summary_15y[, 1:2], 
                                round(Result_GS_Summary_15y[, 3], 6), 
                                Result_GS_Summary_15y[, 4],
                                round(Result_GS_Summary_15y[, 5], 6),
                                Result_GS_Summary_15y[, 6]
                                )
colnames(Result_GS_Summary_15y) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_15y <- Goldstandard %>% 
                         left_join(Result_GS_Summary_15y, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                         select(
                                Drugname, ICD10, Ground_Truth, 
                                lift, count, conviction, pValue
                              )

# Export the result
csvname <- paste('Result_GS_Summary_15y.csv', sep=",")
write.csv(Result_GS_Summary_15y, csvname, row.names=FALSE)  

# Remove tables
rm(Goldstandard);
rm(Result_GS_Summary_15y_pre); rm(Result_GS_Summary_15y_pre1); rm(Result_GS_Summary_15y_pre2); 
rm(Result_GS_positive_15y); rm(Result_GS_negative_15y); 


## MEMO #########################################################################
# 6. ARM-ROCCurve
#################################################################################
# Import the files
Result_GS_Summary_15y <- read_csv('Result_GS_Summary_15y.csv', col_names = TRUE, na=c("","NA", "NULL"))

# Calculate AUC values
ROC_ARMdata_15y <- cbind(Result_GS_Summary_15y[, 4], Result_GS_Summary_15y [, 3]) 
ROC_ARMdata_15y[is.na(ROC_ARMdata_15y)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_15y)<-cbind('ARM', 'Golsta')
ROC_ARM_15y <- roc(formula = Golsta ~ ARM, ROC_ARMdata_15y)
ROC_ARM_15y

# Visualize
setwd('~/Desktop')
pdf('ARM_ROCAUC_15y.pdf')
plot(ROC_ARM_15y, lty=1, lwd = 5, legacy.axes = TRUE, col = 1) 
legend(x = 0.8, y = 0.05, bty = "n", lwd = 3, lty = 1:3, legend = c("15year"), col = 1, cex = 0.7)
legend(x = 0.7, y = 0.05, bty = "n", lty = 0 , legend =c(round(ROC_ARM_15y$auc, digits = 2)), col = 1, cex = 0.7)
dev.off()

# Remove tables
rm(ROC_ARM_15y); rm(ROC_ARMdata_15y);


## MEMO #########################################
# 7. ARM-PRCurve
#################################################
pos_15y <- ROC_ARMdata_15y$ARM[ROC_ARMdata_15y$Golsta == 1]; neg_15y <- ROC_ARMdata_15y$ARM[ROC_ARMdata_15y$Golsta == 0]
ARM_PRAUC_15y <- pr.curve(scores.class0 = pos_15y, scores.class1 = neg_15y, curve = T)

# Visualize
setwd('~/Desktop')
pdf('JMDC_ARM_PRAUC_15y.pdf')
plot(ARM_PRAUC_15y, xlab = "Recall", ylab = "Precision", col = 1, cex = 1, lty = 1, lwd = 5)
legend(x = 0.7, y = 0.25, bty = "n", lwd = 2, lty = 1, legend = c("15year"), col = 1, cex = 0.7)
legend(x = 0.8, y = 0.25, bty = "n", lty = 0, legend =c(round(ARM_PRAUC_15y$auc.integral, digits = 2)), col = 5, cex = 0.7)
dev.off()

# Remove tables
rm(pos_15y); rm(neg_15y); rm(ARM_PRAUC_15y)

