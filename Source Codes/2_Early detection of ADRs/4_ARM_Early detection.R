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
# 1.1 Connection to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'JMDC_Claims', user = 'root')
TTO_JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
TTO_JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM JMDC_ARM_SQLdatamonth')
class(TTO_JMDC_ARM_SQLdata)


## MEMO ###################################################################
# 1.2 Preprocessing
###########################################################################
TTO_JMDC_ARM_SQLdata <- cbind(substring(TTO_JMDC_ARM_SQLdata$加入者ID, 2, 10),
                              TTO_JMDC_ARM_SQLdata[, 3],
                              TTO_JMDC_ARM_SQLdata[, 4],
                              TTO_JMDC_ARM_SQLdata[, 2])
colnames(TTO_JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
TTO_JMDC_ARM_SQLdata <- data.frame(TTO_JMDC_ARM_SQLdata)
TTO_JMDC_ARM_SQLdata$加入者ID <- as.numeric(TTO_JMDC_ARM_SQLdata$加入者ID)
TTO_JMDC_ARM_SQLdata$eventID <- as.numeric(TTO_JMDC_ARM_SQLdata$eventID)
sapply(TTO_JMDC_ARM_SQLdata, class)

# Remove duplicate 加入者ID
ID_Table <- distinct(data.frame(TTO_JMDC_ARM_SQLdata[, 1]))

# Add column name
colnames(ID_Table) <- cbind('加入者ID')

# Format the data
ID_Table <- data.frame(ID_Table)

# Separate records by ID
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

# Create the function
decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, TTO_JMDC_ARM_SQLdata)

# Transaction-Data
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(TTO_ARM_TransactionData, file = 'TTO_JMDC_ARM_1month.csv', format = 'basket')

# Remove tables
rm(list = ls())


## MEMO ###################################################################
# 2.1 Connection to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'JMDC_Claims', user = 'root')
TTO_JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
TTO_JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM JMDC_ARM_SQLdata_3months')
class(TTO_JMDC_ARM_SQLdata)


## MEMO ###################################################################
# 2.2 Preprocessing
###########################################################################
TTO_JMDC_ARM_SQLdata <- cbind(substring(TTO_JMDC_ARM_SQLdata$加入者ID, 2, 10),
                              TTO_JMDC_ARM_SQLdata[, 3],
                              TTO_JMDC_ARM_SQLdata[, 4],
                              TTO_JMDC_ARM_SQLdata[, 2])
colnames(TTO_JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
TTO_JMDC_ARM_SQLdata <- data.frame(TTO_JMDC_ARM_SQLdata)
TTO_JMDC_ARM_SQLdata$加入者ID <- as.numeric(TTO_JMDC_ARM_SQLdata$加入者ID)
TTO_JMDC_ARM_SQLdata$eventID <- as.numeric(TTO_JMDC_ARM_SQLdata$eventID)
sapply(TTO_JMDC_ARM_SQLdata, class)

ID_Table <- distinct(data.frame(TTO_JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, TTO_JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(TTO_ARM_TransactionData, file = 'TTO_JMDC_ARM_1month.csv', format = 'basket')

# Remove tables
rm(list = ls())


## MEMO ###################################################################
# 3.1 Connection to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'JMDC_Claims', user = 'root')
TTO_JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
TTO_JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM JMDC_ARM_SQLdata_6months')
class(TTO_JMDC_ARM_SQLdata)


## MEMO ###################################################################
# 3.2 Preprocessing
###########################################################################
TTO_JMDC_ARM_SQLdata <- cbind(substring(TTO_JMDC_ARM_SQLdata$加入者ID, 2, 10),
                              TTO_JMDC_ARM_SQLdata[, 3],
                              TTO_JMDC_ARM_SQLdata[, 4],
                              TTO_JMDC_ARM_SQLdata[, 2])
colnames(TTO_JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
TTO_JMDC_ARM_SQLdata <- data.frame(TTO_JMDC_ARM_SQLdata)
TTO_JMDC_ARM_SQLdata$加入者ID <- as.numeric(TTO_JMDC_ARM_SQLdata$加入者ID)
TTO_JMDC_ARM_SQLdata$eventID <- as.numeric(TTO_JMDC_ARM_SQLdata$eventID)
sapply(TTO_JMDC_ARM_SQLdata, class)

ID_Table <- distinct(data.frame(TTO_JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, TTO_JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(TTO_ARM_TransactionData, file = 'TTO_JMDC_ARM_1month.csv', format = 'basket')

# Remove tables
rm(list = ls())


## MEMO ###################################################################
# 4. Association rule mining
###########################################################################
# Read transaction
TTO_ARM_TransactionData_1month <- read.transactions('TTO_JMDC_ARM_1month.csv', format = 'basket')
TTO_ARM_TransactionData_3months <- read.transactions('TTO_JMDC_ARM_3months.csv', format = 'basket')
TTO_ARM_TransactionData_6months <- read.transactions('TTO_JMDC_ARM_6months.csv', format = 'basket')


############## 
# 1month
TTO_JMDC_ARM_rules_1month <- apriori(TTO_ARM_TransactionData_1month, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
TTO_JMDC_ARM_inspectdata_1month <- cbind(
                                         as(TTO_JMDC_ARM_rules_1month, "data.frame"), 
                                         conviction = interestMeasure(TTO_JMDC_ARM_rules_1month, "conviction", trans), 
                                         chiSquared = interestMeasure(TTO_JMDC_ARM_rules_1month, "chiSquared", trans),
                                         "-log10(χ2_pValue)" = -pchisq((interestMeasure(TTO_JMDC_ARM_rules_1month, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                         "-log10(fishersExactTest)" = -log10(interestMeasure(TTO_JMDC_ARM_rules_1month, "fishersExactTest", trans))
                                         )

TTO_JMDC_ARM_inspectdata_1month["rules"] <- lapply(TTO_JMDC_ARM_inspectdata_1month["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

TTO_JMDC_ARM_inspectdata_1month["rules"] <- lapply(TTO_JMDC_ARM_inspectdata_1month["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

TTO_JMDC_ARM_inspectdata_1month <- TTO_JMDC_ARM_inspectdata_1month %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")


############## 
# 3months
TTO_JMDC_ARM_rules_3months <- apriori(TTO_ARM_TransactionData_3months, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
TTO_JMDC_ARM_inspectdata_3months <- cbind(
                                         as(TTO_JMDC_ARM_rules_3months, "data.frame"), 
                                         conviction = interestMeasure(TTO_JMDC_ARM_rules_3months, "conviction", trans), 
                                         chiSquared = interestMeasure(TTO_JMDC_ARM_rules_3months, "chiSquared", trans),
                                         "-log10(χ2_pValue)" = -pchisq((interestMeasure(TTO_JMDC_ARM_rules_3months, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                         "-log10(fishersExactTest)" = -log10(interestMeasure(TTO_JMDC_ARM_rules_3months, "fishersExactTest", trans))
                                         )

TTO_JMDC_ARM_inspectdata_3months["rules"] <- lapply(TTO_JMDC_ARM_inspectdata_3months["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

TTO_JMDC_ARM_inspectdata_3months["rules"] <- lapply(TTO_JMDC_ARM_inspectdata_3months["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

TTO_JMDC_ARM_inspectdata_3months <- TTO_JMDC_ARM_inspectdata_3months %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

############## 
# 6months
TTO_JMDC_ARM_rules_6months <- apriori(TTO_ARM_TransactionData_6months, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
TTO_JMDC_ARM_inspectdata_6months <- cbind(
                                         as(TTO_JMDC_ARM_rules_6months, "data.frame"), 
                                         conviction = interestMeasure(TTO_JMDC_ARM_rules_6months, "conviction", trans), 
                                         chiSquared = interestMeasure(TTO_JMDC_ARM_rules_6months, "chiSquared", trans),
                                         "-log10(χ2_pValue)" = -pchisq((interestMeasure(TTO_JMDC_ARM_rules_6months, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                         "-log10(fishersExactTest)" = -log10(interestMeasure(TTO_JMDC_ARM_rules_6months, "fishersExactTest", trans))
                                        )


TTO_JMDC_ARM_inspectdata_6months["rules"] <- lapply(TTO_JMDC_ARM_inspectdata_6months["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

TTO_JMDC_ARM_inspectdata_6months["rules"] <- lapply(TTO_JMDC_ARM_inspectdata_6months["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

TTO_JMDC_ARM_inspectdata_6months <- TTO_JMDC_ARM_inspectdata_6months %>% 
                                    separate(rules, c("cause", "effect"), sep=" => ")


###########################################################################
# 5. Positive controls
###########################################################################
############## 
# 1month
TTO_GS_positive_1month <- subset(TTO_JMDC_ARM_inspectdata_1month, 
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

# The Fisher's exact test(less than 10 values)
Result_GS_positive_pre1 <- data.frame(
                           cbind(subset(TTO_GS_positive_1month, count < 10)[, 1:2], 
                           subset(TTO_GS_positive_1month, count < 10)[, 6:7],
                           subset(TTO_GS_positive_1month, count < 10)[, 8],
                           subset(TTO_GS_positive_1month, count < 10)[, 11])
)
colnames(Result_GS_positive_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_positive_pre2 <- data.frame(
                           cbind(subset(TTO_GS_positive_1month, count >= 10)[, 1:2], 
                           subset(TTO_GS_positive_1month, count >= 10)[, 6:7], 
                           subset(TTO_GS_positive_1month, count >= 10)[, 8], 
                           subset(TTO_GS_positive_1month, count >= 10)[, 10])
)
colnames(Result_GS_positive_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_GS_positive_1month_re <- rbind(Result_GS_positive_pre1, Result_GS_positive_pre2)

# Align digits
TTO_GS_positive_1month_re <- cbind(TTO_GS_positive_1month_re[, 1:2], 
                                      round(TTO_GS_positive_1month_re[, 3], 6), 
                                      TTO_GS_positive_1month_re[, 4],
                                      round(TTO_GS_positive_1month_re[, 5], 6),
                                      TTO_GS_positive_1month_re[, 6])
colnames(TTO_GS_positive_1month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

csvname <- paste('TTO_GS_positive_1month.csv', sep = ",")
write.csv(TTO_GS_positive_1month_re, csvname, row.names = FALSE)


############## 
# 3months
TTO_GS_positive_3month <- subset(TTO_JMDC_ARM_inspectdata_3months, 
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

# The Fisher's exact test(less than 10 values)
Result_GS_positive_pre1 <- data.frame(
                           cbind(subset(TTO_GS_positive_3month, count < 10)[, 1:2], 
                           subset(TTO_GS_positive_3month, count < 10)[, 6:7],
                           subset(TTO_GS_positive_3month, count < 10)[, 8],
                           subset(TTO_GS_positive_3month, count < 10)[, 11])
)
colnames(Result_GS_positive_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_positive_pre2 <- data.frame(
                           cbind(subset(TTO_GS_positive_3month, count >= 10)[, 1:2], 
                           subset(TTO_GS_positive_3month, count >= 10)[, 6:7], 
                           subset(TTO_GS_positive_3month, count >= 10)[, 8], 
                           subset(TTO_GS_positive_3month, count >= 10)[, 10])
)
colnames(Result_GS_positive_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_GS_positive_3month_re <- rbind(Result_GS_positive_pre1, Result_GS_positive_pre2)

# Align digits
TTO_GS_positive_3month_re <- cbind(TTO_GS_positive_3month_re[, 1:2], 
                                      round(TTO_GS_positive_3month_re[, 3], 6), 
                                      TTO_GS_positive_3month_re[, 4],
                                      round(TTO_GS_positive_3month_re[, 5], 6),
                                      TTO_GS_positive_3month_re[, 6])
colnames(TTO_GS_positive_3month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')


csvname <- paste('TTO_GS_positive_3month.csv', sep = ",")
write.csv(TTO_GS_positive_3month_re, csvname, row.names = FALSE)


############## 
# 6months
TTO_GS_positive_6month <- subset(TTO_JMDC_ARM_inspectdata_6months, 
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

# The Fisher's exact test(less than 10 values)
Result_GS_positive_pre1 <- data.frame(
                           cbind(subset(TTO_GS_positive_6month, count < 10)[, 1:2], 
                           subset(TTO_GS_positive_6month, count < 10)[, 6:7],
                           subset(TTO_GS_positive_6month, count < 10)[, 8],
                           subset(TTO_GS_positive_6month, count < 10)[, 11])
)
colnames(Result_GS_positive_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_positive_pre2 <- data.frame(
                           cbind(subset(TTO_GS_positive_6month, count >= 10)[, 1:2], 
                           subset(TTO_GS_positive_6month, count >= 10)[, 6:7], 
                           subset(TTO_GS_positive_6month, count >= 10)[, 8], 
                           subset(TTO_GS_positive_6month, count >= 10)[, 10])
)
colnames(Result_GS_positive_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_GS_positive_6month_re <- rbind(Result_GS_positive_pre1, Result_GS_positive_pre2)

# Align digits
TTO_GS_positive_6month_re <- cbind(TTO_GS_positive_6month_re[, 1:2], 
                                      round(TTO_GS_positive_6month_re[, 3], 6), 
                                      TTO_GS_positive_6month_re[, 4],
                                      round(TTO_GS_positive_6month_re[, 5], 6),
                                      TTO_GS_positive_6month_re[, 6])
colnames(TTO_GS_positive_6month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

csvname <- paste('TTO_GS_positive_6month.csv', sep = ",")
write.csv(TTO_GS_positive_6month_re, csvname, row.names = FALSE)


###########################################################################
# 6. Negative controls
###########################################################################
############## 
# 1month
TTO_GS_negative_1month <- subset(TTO_JMDC_ARM_inspectdata_1month, 
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
# The Fisher's exact test(less than 10 values)
Result_GS_negative_pre1 <- data.frame(
                           cbind(subset(TTO_GS_negative_1month, count < 10)[, 1:2], 
                           subset(TTO_GS_negative_1month, count < 10)[, 6:7],
                           subset(TTO_GS_negative_1month, count < 10)[, 11],
                           subset(TTO_GS_negative_1month, count < 10)[, 14])
)
colnames(Result_GS_negative_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_negative_pre2 <- data.frame(
                           cbind(subset(TTO_GS_negative_1month, count >= 10)[, 1:2], 
                           subset(TTO_GS_negative_1month, count >= 10)[, 6:7], 
                           subset(TTO_GS_negative_1month, count >= 10)[, 11], 
                           subset(TTO_GS_negative_1month, count >= 10)[, 13])
)
colnames(Result_GS_negative_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_GS_negative_1month_re <- rbind(Result_GS_negative_pre1, Result_GS_negative_pre2)


# Align digits
TTO_GS_negative_1month_re <- cbind(TTO_GS_negative_1month_re[, 1:2], 
                                      round(TTO_GS_negative_1month_re[, 3], 6), 
                                      TTO_GS_negative_1month_re[, 4],
                                      round(TTO_GS_negative_1month_re[, 5], 6),
                                      round(TTO_GS_negative_1month_re[, 6], 6)
)
colnames(TTO_GS_negative_1month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')
nrow(subset(TTO_GS_negative_1month_re, lift > 1 & conviction > 1 & pValue < 0.05))

csvname <- paste('TTO_GS_negative_1month.csv', sep = ",")
write.csv(TTO_GS_negative_1month_re, csvname, row.names = FALSE)


############## 
# 3months
TTO_GS_negative_3months <- subset(TTO_JMDC_ARM_inspectdata_3months, 
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
# The Fisher's exact test(less than 10 values)
Result_GS_negative_pre1 <- data.frame(
                           cbind(subset(TTO_GS_negative_3months, count < 10)[, 1:2], 
                           subset(TTO_GS_negative_3months, count < 10)[, 6:7],
                           subset(TTO_GS_negative_3months, count < 10)[, 11],
                            subset(TTO_GS_negative_3months, count < 10)[, 14])
)
colnames(Result_GS_negative_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_negative_pre2 <- data.frame(
                           cbind(subset(TTO_GS_negative_3months, count >= 10)[, 1:2], 
                           subset(TTO_GS_negative_3months, count >= 10)[, 6:7], 
                           subset(TTO_GS_negative_3months, count >= 10)[, 11], 
                           subset(TTO_GS_negative_3months, count >= 10)[, 13])
)
colnames(Result_GS_negative_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_GS_negative_3months_re <- rbind(Result_GS_negative_pre1, Result_GS_negative_pre2)


# Align digits
TTO_GS_negative_3months_re <- cbind(TTO_GS_negative_3months_re[, 1:2], 
                                      round(TTO_GS_negative_3months_re[, 3], 6), 
                                      TTO_GS_negative_3months_re[, 4],
                                      round(TTO_GS_negative_3months_re[, 5], 6),
                                      round(TTO_GS_negative_3months_re[, 6], 6)
)
colnames(TTO_GS_negative_3months_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

csvname <- paste('TTO_GS_negative_3months.csv', sep = ",")
write.csv(TTO_GS_negative_3months_re, csvname, row.names = FALSE)


############## 
# 6months
TTO_GS_negative_6months <- subset(TTO_JMDC_ARM_inspectdata_6months, 
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
# The Fisher's exact test(less than 10 values)
Result_GS_negative_pre1 <- data.frame(
                           cbind(subset(TTO_GS_negative_6months, count < 10)[, 1:2], 
                           subset(TTO_GS_negative_6months, count < 10)[, 6:7],
                           subset(TTO_GS_negative_6months, count < 10)[, 11],
                           subset(TTO_GS_negative_6months, count < 10)[, 14])
)
colnames(Result_GS_negative_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_negative_pre2 <- data.frame(
                           cbind(subset(TTO_GS_negative_6months, count >= 10)[, 1:2], 
                           subset(TTO_GS_negative_6months, count >= 10)[, 6:7], 
                           subset(TTO_GS_negative_6months, count >= 10)[, 11], 
                           subset(TTO_GS_negative_6months, count >= 10)[, 13])
)
colnames(Result_GS_negative_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_GS_negative_6months_re <- rbind(Result_GS_negative_pre1, Result_GS_negative_pre2)


# Align digits
TTO_GS_negative_6months_re <- cbind(TTO_GS_negative_6months_re[, 1:2], 
                                      round(TTO_GS_negative_6months_re[, 3], 6), 
                                      TTO_GS_negative_6months_re[, 4],
                                      round(TTO_GS_negative_6months_re[, 5], 6),
                                      round(TTO_GS_negative_6months_re[, 6], 6)
)
colnames(TTO_GS_negative_6months_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

csvname <- paste('TTO_GS_negative_6months.csv', sep = ",")
write.csv(TTO_GS_negative_6months_re, csvname, row.names = FALSE)

