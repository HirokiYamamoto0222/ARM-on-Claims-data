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
# 1.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'JMDC_Claims', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2008_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO ###################################################################
# 1.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

# Remove duplicate ENROLID
ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))

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

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)

# Transaction-Data
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(ARM_TransactionData, file = '2008_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 1.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 2.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2009_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 2.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2009_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 2.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 3.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2010_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 3.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2010_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 3.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 4.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2011_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 4.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2011_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 4.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 5.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2012_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 5.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2012_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 5.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 6.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2013_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 6.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2013_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 6.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 7.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2014_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 7.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)


ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2014_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 7.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 8.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2015_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 8.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)


ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2015_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 8.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 9.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2016_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 9.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2016_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 9.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## MEMO####################################################################
# 10.1 Connect to MySQL
###########################################################################
md <- dbDriver('MySQL')
dbconnector <- dbConnect(md, dbname = 'Journal', user = 'root')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')
JMDC_ARM_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM 2017_JMDC_ARM_SQLdata')
class(JMDC_ARM_SQLdata)


## MEMO####################################################################
# 10.2 Preprocessing
###########################################################################
JMDC_ARM_SQLdata <- cbind(substring(JMDC_ARM_SQLdata$加入者ID, 2, 10),
                          JMDC_ARM_SQLdata[, 3],
                          JMDC_ARM_SQLdata[, 4],
                          JMDC_ARM_SQLdata[, 2])
colnames(JMDC_ARM_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
JMDC_ARM_SQLdata <- data.frame(JMDC_ARM_SQLdata)

ID_Table <- distinct(data.frame(JMDC_ARM_SQLdata[, 1]))
colnames(ID_Table) <- cbind('加入者ID')
ID_Table <- data.frame(ID_Table)
Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)

decanonicalize <- function(row, rdf){
                                      details <- rdf %>%
                                      dplyr::filter(加入者ID == row$加入者ID) %>%
                                      magrittr::extract2('Item') %>%
                                      as.vector()
                                      }

Transaction_list <- lapply(Split_ID_Table, decanonicalize, JMDC_ARM_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')
write(ARM_TransactionData, file = '2017_JMDC_ARM_Analysisdata.csv', format = 'basket')


## MEMO####################################################################
# 10.3 Remove tables and disconnect session
###########################################################################
rm(JMDC_ARM_SQLdata); rm(ID_Table); rm(Split_ID_Table); rm(Transaction_list); rm(ARM_TransactionData)
dbDisconnect(dbconnector)


## ##############################################################################
# MEMO
# 11. Association rule mining
#################################################################################
# Read transaction
ARM_TransactionData_2008 <- read.transactions('2008_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2009 <- read.transactions('2009_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2010 <- read.transactions('2010_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2011 <- read.transactions('2011_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2012 <- read.transactions('2012_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2013 <- read.transactions('2013_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2014 <- read.transactions('2014_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2015 <- read.transactions('2015_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2016 <- read.transactions('2016_JMDC_ARM_Analysisdata.csv', format = 'basket')
ARM_TransactionData_2017 <- read.transactions('2017_JMDC_ARM_Analysisdata.csv', format = 'basket')


############## 
# 2008year
JMDC_ARM_rules_2008 <- apriori(ARM_TransactionData_2008, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2008 <- cbind(
                                   as(JMDC_ARM_rules_2008, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2008, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2008, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2008, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2008, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2008["rules"] <- lapply(JMDC_ARM_inspectdata_2008["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2008["rules"] <- lapply(JMDC_ARM_inspectdata_2008["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2008 <- JMDC_ARM_inspectdata_2008 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2008, class)


## MEMO ########################
# Positive controls
# イピリムマブ, アナグレリド: no drug user in 2008 dataset
################################
Result_GS_positive_2008 <- subset(JMDC_ARM_inspectdata_2008, 
                                    cause == 'タゾバクタムナトリウム・ピペラシリンナトリウム' & effect == 'A04'|
                                    # cause == 'イピリムマブ（遺伝子組換え）' & effect == 'A09'|
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
                                    # cause == 'アナグレリド塩酸塩水和物' & effect == 'I20'|
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
# イピリムマブ, アナグレリド: no drug user in 2008 dataset
################################
Result_GS_negative_2008 <- subset(JMDC_ARM_inspectdata_2008, 
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
                                    # cause == 'アナグレリド塩酸塩水和物' & effect == 'M77'|
                                    cause == 'シタラビン' & effect == 'M81'|
                                    cause == 'アリピプラゾール' & effect == 'N12'|
                                    cause == 'エスシタロプラムシュウ酸塩' & effect == 'N17'|
                                    cause == 'ジアゼパム' & effect == 'N39'|
                                    cause == 'トリアムシノロンアセトニド' & effect == 'R43'|
                                    cause == 'オクトレオチド酢酸塩' & effect == 'R44'|
                                    cause == 'アフリベルセプト（遺伝子組換え）' & effect == 'R44'|
                                    # cause == 'アナグレリド塩酸塩水和物' & effect == 'R56'|
                                    cause == 'アモキシシリン' & effect == 'R73'
)

rm(ARM_TransactionData_2008); rm(JMDC_ARM_rules_2008); rm(JMDC_ARM_inspectdata_2008);


############## 
# 2009year
JMDC_ARM_rules_2009 <- apriori(ARM_TransactionData_2009, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2009 <- cbind(
                                   as(JMDC_ARM_rules_2009, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2009, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2009, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2009, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2009, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2009["rules"] <- lapply(JMDC_ARM_inspectdata_2009["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2009["rules"] <- lapply(JMDC_ARM_inspectdata_2009["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2009 <- JMDC_ARM_inspectdata_2009 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2009, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2009 <- subset(JMDC_ARM_inspectdata_2009, 
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
Result_GS_negative_2009 <- subset(JMDC_ARM_inspectdata_2009, 
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

rm(ARM_TransactionData_2009); rm(JMDC_ARM_rules_2009); rm(JMDC_ARM_inspectdata_2009);


############## 
# 2010year
JMDC_ARM_rules_2010 <- apriori(ARM_TransactionData_2010, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2010 <- cbind(
                                   as(JMDC_ARM_rules_2010, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2010, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2010, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2010, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2010, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2010["rules"] <- lapply(JMDC_ARM_inspectdata_2010["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2010["rules"] <- lapply(JMDC_ARM_inspectdata_2010["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2010 <- JMDC_ARM_inspectdata_2010 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2010, class)

## MEMO ########################
# Positive controls
# イピリムマブ: no drug user in 2010 dataset
################################
Result_GS_positive_2010 <- subset(JMDC_ARM_inspectdata_2010, 
                                    cause == 'タゾバクタムナトリウム・ピペラシリンナトリウム' & effect == 'A04'|
                                    # cause == 'イピリムマブ（遺伝子組換え）' & effect == 'A09'|
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
Result_GS_negative_2010 <- subset(JMDC_ARM_inspectdata_2010, 
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

rm(ARM_TransactionData_2010); rm(JMDC_ARM_rules_2010); rm(JMDC_ARM_inspectdata_2010);


############## 
# 2011year
JMDC_ARM_rules_2011 <- apriori(ARM_TransactionData_2011, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2011 <- cbind(
                                   as(JMDC_ARM_rules_2011, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2011, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2011, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2011, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2011, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2011["rules"] <- lapply(JMDC_ARM_inspectdata_2011["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2011["rules"] <- lapply(JMDC_ARM_inspectdata_2011["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2011 <- JMDC_ARM_inspectdata_2011 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2011, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2011 <- subset(JMDC_ARM_inspectdata_2011, 
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
Result_GS_negative_2011 <- subset(JMDC_ARM_inspectdata_2011, 
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

rm(ARM_TransactionData_2011); rm(JMDC_ARM_rules_2011); rm(JMDC_ARM_inspectdata_2011);


############## 
# 2012year
JMDC_ARM_rules_2012 <- apriori(ARM_TransactionData_2012, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2012 <- cbind(
                                   as(JMDC_ARM_rules_2012, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2012, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2012, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2012, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2012, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2012["rules"] <- lapply(JMDC_ARM_inspectdata_2012["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2012["rules"] <- lapply(JMDC_ARM_inspectdata_2012["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2012 <- JMDC_ARM_inspectdata_2012 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2012, class)

## MEMO ########################
# Positive controls
# イピリムマブ: no drug user in 2012 dataset
################################
Result_GS_positive_2012 <- subset(JMDC_ARM_inspectdata_2012, 
                                    cause == 'タゾバクタムナトリウム・ピペラシリンナトリウム' & effect == 'A04'|
                                    # cause == 'イピリムマブ（遺伝子組換え）' & effect == 'A09'|
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
Result_GS_negative_2012 <- subset(JMDC_ARM_inspectdata_2012, 
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

rm(ARM_TransactionData_2012); rm(JMDC_ARM_rules_2012); rm(JMDC_ARM_inspectdata_2012);


############## 
# 2013year
JMDC_ARM_rules_2013 <- apriori(ARM_TransactionData_2013, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2013 <- cbind(
                                   as(JMDC_ARM_rules_2013, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2013, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2013, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2013, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2013, "fishersExactTest", trans))
                                  )
JMDC_ARM_inspectdata_2013["rules"] <- lapply(JMDC_ARM_inspectdata_2013["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2013["rules"] <- lapply(JMDC_ARM_inspectdata_2013["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2013 <- JMDC_ARM_inspectdata_2013 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2013, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2013 <- subset(JMDC_ARM_inspectdata_2013, 
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
Result_GS_negative_2013 <- subset(JMDC_ARM_inspectdata_2013, 
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

rm(ARM_TransactionData_2013); rm(JMDC_ARM_rules_2013); rm(JMDC_ARM_inspectdata_2013);


############## 
# 2014year
JMDC_ARM_rules_2014 <- apriori(ARM_TransactionData_2014, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2014 <- cbind(
                                   as(JMDC_ARM_rules_2014, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2014, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2014, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2014, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2014, "fishersExactTest", trans))
                                  )
JMDC_ARM_inspectdata_2014["rules"] <- lapply(JMDC_ARM_inspectdata_2014["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2014["rules"] <- lapply(JMDC_ARM_inspectdata_2014["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2014 <- JMDC_ARM_inspectdata_2014 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2014, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2014 <- subset(JMDC_ARM_inspectdata_2014, 
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
Result_GS_negative_2014 <- subset(JMDC_ARM_inspectdata_2014, 
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

rm(ARM_TransactionData_2014); rm(JMDC_ARM_rules_2014); rm(JMDC_ARM_inspectdata_2014);


############## 
# 2015year
JMDC_ARM_rules_2015 <- apriori(ARM_TransactionData_2015, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2015 <- cbind(
                                   as(JMDC_ARM_rules_2015, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2015, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2015, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2015, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2015, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2015["rules"] <- lapply(JMDC_ARM_inspectdata_2015["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2015["rules"] <- lapply(JMDC_ARM_inspectdata_2015["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2015 <- JMDC_ARM_inspectdata_2015 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2015, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2015 <- subset(JMDC_ARM_inspectdata_2015, 
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
Result_GS_negative_2015 <- subset(JMDC_ARM_inspectdata_2015, 
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

rm(ARM_TransactionData_2015); rm(JMDC_ARM_rules_2015); rm(JMDC_ARM_inspectdata_2015);


############## 
# 2016year
JMDC_ARM_rules_2016 <- apriori(ARM_TransactionData_2016, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2016 <- cbind(
                                   as(JMDC_ARM_rules_2016, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2016, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2016, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2016, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2016, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2016["rules"] <- lapply(JMDC_ARM_inspectdata_2016["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2016["rules"] <- lapply(JMDC_ARM_inspectdata_2016["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2016 <- JMDC_ARM_inspectdata_2016 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2016, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2016 <- subset(JMDC_ARM_inspectdata_2016, 
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
Result_GS_negative_2016 <- subset(JMDC_ARM_inspectdata_2016, 
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

rm(ARM_TransactionData_2016); rm(JMDC_ARM_rules_2016); rm(JMDC_ARM_inspectdata_2016);


############## 
# 2017year
JMDC_ARM_rules_2017 <- apriori(ARM_TransactionData_2017, 
                               parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
JMDC_ARM_inspectdata_2017 <- cbind(
                                   as(JMDC_ARM_rules_2017, "data.frame"), 
                                   conviction = interestMeasure(JMDC_ARM_rules_2017, "conviction", trans), 
                                   chiSquared = interestMeasure(JMDC_ARM_rules_2017, "chiSquared", trans),
                                   "-log10(χ2_pValue)" = -pchisq((interestMeasure(JMDC_ARM_rules_2017, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                   "-log10(fishersExactTest)" = -log10(interestMeasure(JMDC_ARM_rules_2017, "fishersExactTest", trans))
                                  )

JMDC_ARM_inspectdata_2017["rules"] <- lapply(JMDC_ARM_inspectdata_2017["rules"], 
                                             gsub, 
                                             pattern = "{", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2017["rules"] <- lapply(JMDC_ARM_inspectdata_2017["rules"], 
                                             gsub, 
                                             pattern = "}", 
                                             replacement = "", fixed=TRUE)

JMDC_ARM_inspectdata_2017 <- JMDC_ARM_inspectdata_2017 %>% 
                             separate(rules, c("cause", "effect"), sep=" => ")

sapply(JMDC_ARM_inspectdata_2017, class)

## MEMO ########################
# Positive controls
################################
Result_GS_positive_2017 <- subset(JMDC_ARM_inspectdata_2017, 
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
Result_GS_negative_2017 <- subset(JMDC_ARM_inspectdata_2017, 
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

rm(ARM_TransactionData_2017); rm(JMDC_ARM_rules_2017); rm(JMDC_ARM_inspectdata_2017)


## MEMO #########################################################################
# 12. Gold standard
#################################################################################
Goldstandard <- read_csv('Goldstandard.csv', col_names=TRUE, na=c("","NA", "NULL"))
colnames(Goldstandard)<-cbind('Drugname', 'ICD10', 'Ground_Truth')


## MEMO #########################################################################
# 13. Align digits
#################################################################################
############## 
# 2008year
Result_GS_Summary_2008_pre <- rbind(Result_GS_positive_2008, Result_GS_negative_2008)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2008_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2008_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2008_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2008_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2008_pre, count < 10)[, 11])
                                         )
colnames(Result_GS_Summary_2008_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2008_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2008_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2008_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2008_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2008_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2008_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2008 <- rbind(Result_GS_Summary_2008_pre1, Result_GS_Summary_2008_pre2)

# Align digits
Result_GS_Summary_2008 <- cbind(
                                Result_GS_Summary_2008[, 1:2], 
                                round(Result_GS_Summary_2008[, 3], 6), 
                                Result_GS_Summary_2008[, 4],
                                round(Result_GS_Summary_2008[, 5], 6),
                                round(Result_GS_Summary_2008[, 6], 6)
                                )
colnames(Result_GS_Summary_2008) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2008 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2008, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                 )

# イピリムマブ, アナグレリド: no drug user in 2008 dataset
Result_GS_Summary_2008 <- Result_GS_Summary_2008 %>% 
                          filter(Drugname != 'アナグレリド塩酸塩水和物') %>% 
                          filter(Drugname != 'イピリムマブ（遺伝子組換え）') 

# Export the result
csvname <- paste('Result_GS_Summary_2008.csv', sep=",")
write.csv(Result_GS_Summary_2008, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2008_pre); rm(Result_GS_Summary_2008_pre1); rm(Result_GS_Summary_2008_pre2); 
rm(Result_GS_positive_2008); rm(Result_GS_negative_2008)


############## 
# 2009year
Result_GS_Summary_2009_pre <- rbind(Result_GS_positive_2009, Result_GS_negative_2009)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2009_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2009_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2009_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2009_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2009_pre, count < 10)[, 11])
                                          )
colnames(Result_GS_Summary_2009_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2009_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2009_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2009_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2009_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2009_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2009_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2009 <- rbind(Result_GS_Summary_2009_pre1, Result_GS_Summary_2009_pre2)

# Align digits
Result_GS_Summary_2009 <- cbind(
                                Result_GS_Summary_2009[, 1:2], 
                                round(Result_GS_Summary_2009[, 3], 6), 
                                Result_GS_Summary_2009[, 4],
                                round(Result_GS_Summary_2009[, 5], 6),
                                round(Result_GS_Summary_2009[, 6], 6)
                              )
colnames(Result_GS_Summary_2009) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2009 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2009, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                )

# Export the result
csvname <- paste('Result_GS_Summary_2009.csv', sep=",")
write.csv(Result_GS_Summary_2009, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2009_pre); rm(Result_GS_Summary_2009_pre1); rm(Result_GS_Summary_2009_pre2); 
rm(Result_GS_positive_2009); rm(Result_GS_negative_2009)


############## 
# 2010year
Result_GS_Summary_2010_pre <- rbind(Result_GS_positive_2010, Result_GS_negative_2010)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2010_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2010_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2010_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2010_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2010_pre, count < 10)[, 11])
)
colnames(Result_GS_Summary_2010_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2010_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2010_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2010_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2010_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2010_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2010_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2010 <- rbind(Result_GS_Summary_2010_pre1, Result_GS_Summary_2010_pre2)

# Align digits
Result_GS_Summary_2010 <- cbind(
                                Result_GS_Summary_2010[, 1:2], 
                                round(Result_GS_Summary_2010[, 3], 6), 
                                Result_GS_Summary_2010[, 4],
                                round(Result_GS_Summary_2010[, 5], 6),
                                round(Result_GS_Summary_2010[, 6], 6)
                                )
colnames(Result_GS_Summary_2010) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2010 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2010, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                )

# イピリムマブ: no drug user in 2010 dataset
Result_GS_Summary_2010 <- Result_GS_Summary_2010 %>% 
                          filter(Drugname != 'イピリムマブ（遺伝子組換え）') 

# Export the result
csvname <- paste('Result_GS_Summary_2010.csv', sep=",")
write.csv(Result_GS_Summary_2010, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2010_pre); rm(Result_GS_Summary_2010_pre1); rm(Result_GS_Summary_2010_pre2); 
rm(Result_GS_positive_2010); rm(Result_GS_negative_2010)


############## 
# 2011year
Result_GS_Summary_2011_pre <- rbind(Result_GS_positive_2011, Result_GS_negative_2011)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2011_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2011_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2011_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2011_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2011_pre, count < 10)[, 11])
                                          )
colnames(Result_GS_Summary_2011_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2011_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2011_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2011_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2011_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2011_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2011_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2011 <- rbind(Result_GS_Summary_2011_pre1, Result_GS_Summary_2011_pre2)

# Align digits
Result_GS_Summary_2011 <- cbind(
                                Result_GS_Summary_2011[, 1:2], 
                                round(Result_GS_Summary_2011[, 3], 6), 
                                Result_GS_Summary_2011[, 4],
                                round(Result_GS_Summary_2011[, 5], 6),
                                round(Result_GS_Summary_2011[, 6], 6)
                              )
colnames(Result_GS_Summary_2011) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2011 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2011, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                  )

# Export the result
csvname <- paste('Result_GS_Summary_2011.csv', sep=",")
write.csv(Result_GS_Summary_2011, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2011_pre); rm(Result_GS_Summary_2011_pre1); rm(Result_GS_Summary_2011_pre2); 
rm(Result_GS_positive_2011); rm(Result_GS_negative_2011)


############## 
# 2012year
Result_GS_Summary_2012_pre <- rbind(Result_GS_positive_2012, Result_GS_negative_2012)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2012_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2012_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2012_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2012_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2012_pre, count < 10)[, 11])
                                          )
colnames(Result_GS_Summary_2012_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2012_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2012_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2012_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2012_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2012_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2012_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2012 <- rbind(Result_GS_Summary_2012_pre1, Result_GS_Summary_2012_pre2)

# Align digits
Result_GS_Summary_2012 <- cbind(
                                Result_GS_Summary_2012[, 1:2], 
                                round(Result_GS_Summary_2012[, 3], 6), 
                                Result_GS_Summary_2012[, 4],
                                round(Result_GS_Summary_2012[, 5], 6),
                                round(Result_GS_Summary_2012[, 6], 6)
                                )
colnames(Result_GS_Summary_2012) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2012 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2012, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                )

# イピリムマブ: no drug user in 2012 dataset
Result_GS_Summary_2012 <- Result_GS_Summary_2012 %>% 
                          filter(Drugname != 'イピリムマブ（遺伝子組換え）')

# Export the result
csvname <- paste('Result_GS_Summary_2012.csv', sep=",")
write.csv(Result_GS_Summary_2012, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2012_pre); rm(Result_GS_Summary_2012_pre1); rm(Result_GS_Summary_2012_pre2); 
rm(Result_GS_positive_2012); rm(Result_GS_negative_2012)


############## 
# 2013year
Result_GS_Summary_2013_pre <- rbind(Result_GS_positive_2013, Result_GS_negative_2013)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2013_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2013_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2013_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2013_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2013_pre, count < 10)[, 11])
                                          )
colnames(Result_GS_Summary_2013_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2013_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2013_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2013_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2013_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2013_pre, count >= 10)[, 10])
                                        )
colnames(Result_GS_Summary_2013_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2013 <- rbind(Result_GS_Summary_2013_pre1, Result_GS_Summary_2013_pre2)

# Align digits
Result_GS_Summary_2013 <- cbind(
                                Result_GS_Summary_2013[, 1:2], 
                                round(Result_GS_Summary_2013[, 3], 6), 
                                Result_GS_Summary_2013[, 4],
                                round(Result_GS_Summary_2013[, 5], 6),
                                round(Result_GS_Summary_2013[, 6], 6)
                                )
colnames(Result_GS_Summary_2013) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2013 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2013, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                  )

# Export the result
csvname <- paste('Result_GS_Summary_2013.csv', sep=",")
write.csv(Result_GS_Summary_2013, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2013_pre); rm(Result_GS_Summary_2013_pre1); rm(Result_GS_Summary_2013_pre2); 
rm(Result_GS_positive_2013); rm(Result_GS_negative_2013)


############## 
# 2014year
Result_GS_Summary_2014_pre <- rbind(Result_GS_positive_2014, Result_GS_negative_2014)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2014_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2014_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2014_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2014_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2014_pre, count < 10)[, 11])
                                          )
colnames(Result_GS_Summary_2014_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2014_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2014_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2014_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2014_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2014_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2014_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2014 <- rbind(Result_GS_Summary_2014_pre1, Result_GS_Summary_2014_pre2)

# Align digits
Result_GS_Summary_2014 <- cbind(
                                Result_GS_Summary_2014[, 1:2], 
                                round(Result_GS_Summary_2014[, 3], 6), 
                                Result_GS_Summary_2014[, 4],
                                round(Result_GS_Summary_2014[, 5], 6),
                                round(Result_GS_Summary_2014[, 6], 6)
                                )
colnames(Result_GS_Summary_2014) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2014 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2014, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                )

# Export the result
csvname <- paste('Result_GS_Summary_2014.csv', sep=",")
write.csv(Result_GS_Summary_2014, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2014_pre); rm(Result_GS_Summary_2014_pre1); rm(Result_GS_Summary_2014_pre2); 
rm(Result_GS_positive_2014); rm(Result_GS_negative_2014)


############## 
# 2015year
Result_GS_Summary_2015_pre <- rbind(Result_GS_positive_2015, Result_GS_negative_2015)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2015_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2015_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2015_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2015_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2015_pre, count < 10)[, 11])
                                          )
colnames(Result_GS_Summary_2015_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2015_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2015_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2015_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2015_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2015_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2015_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2015 <- rbind(Result_GS_Summary_2015_pre1, Result_GS_Summary_2015_pre2)

# Align digits
Result_GS_Summary_2015 <- cbind(
                                Result_GS_Summary_2015[, 1:2], 
                                round(Result_GS_Summary_2015[, 3], 6), 
                                Result_GS_Summary_2015[, 4],
                                round(Result_GS_Summary_2015[, 5], 6),
                                round(Result_GS_Summary_2015[, 6], 6)
                                )
colnames(Result_GS_Summary_2015) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2015 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2015, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                  )

# Export the result
csvname <- paste('Result_GS_Summary_2015.csv', sep=",")
write.csv(Result_GS_Summary_2015, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2015_pre); rm(Result_GS_Summary_2015_pre1); rm(Result_GS_Summary_2015_pre2); 
rm(Result_GS_positive_2015); rm(Result_GS_negative_2015)


############## 
# 2016year
Result_GS_Summary_2016_pre <- rbind(Result_GS_positive_2016, Result_GS_negative_2016)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2016_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2016_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2016_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2016_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2016_pre, count < 10)[, 11])
                                        )
colnames(Result_GS_Summary_2016_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2016_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2016_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2016_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2016_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2016_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2016_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2016 <- rbind(Result_GS_Summary_2016_pre1, Result_GS_Summary_2016_pre2)

# Align digits
Result_GS_Summary_2016 <- cbind(
                                Result_GS_Summary_2016[, 1:2], 
                                round(Result_GS_Summary_2016[, 3], 6), 
                                Result_GS_Summary_2016[, 4],
                                round(Result_GS_Summary_2016[, 5], 6),
                                round(Result_GS_Summary_2016[, 6], 6)
                                )
colnames(Result_GS_Summary_2016) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2016 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2016, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                )

# Export the result
csvname <- paste('Result_GS_Summary_2016.csv', sep=",")
write.csv(Result_GS_Summary_2016, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2016_pre); rm(Result_GS_Summary_2016_pre1); rm(Result_GS_Summary_2016_pre2); 
rm(Result_GS_positive_2016); rm(Result_GS_negative_2016)


############## 
# 2017year
Result_GS_Summary_2017_pre <- rbind(Result_GS_positive_2017, Result_GS_negative_2017)

# The Fisher's exact test(less than 10 values)
Result_GS_Summary_2017_pre1 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2017_pre, count < 10)[, 1:2], 
                                          subset(Result_GS_Summary_2017_pre, count < 10)[, 6:7],
                                          subset(Result_GS_Summary_2017_pre, count < 10)[, 8],
                                          subset(Result_GS_Summary_2017_pre, count < 10)[, 11])
)
colnames(Result_GS_Summary_2017_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2017_pre2 <- data.frame(
                                          cbind(subset(Result_GS_Summary_2017_pre, count >= 10)[, 1:2], 
                                          subset(Result_GS_Summary_2017_pre, count >= 10)[, 6:7],
                                          subset(Result_GS_Summary_2017_pre, count >= 10)[, 8],
                                          subset(Result_GS_Summary_2017_pre, count >= 10)[, 10])
                                          )
colnames(Result_GS_Summary_2017_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_GS_Summary_2017 <- rbind(Result_GS_Summary_2017_pre1, Result_GS_Summary_2017_pre2)

# Align digits
Result_GS_Summary_2017 <- cbind(
                                Result_GS_Summary_2017[, 1:2], 
                                round(Result_GS_Summary_2017[, 3], 6), 
                                Result_GS_Summary_2017[, 4],
                                round(Result_GS_Summary_2017[, 5], 6),
                                round(Result_GS_Summary_2017[, 6], 6)
                                )
colnames(Result_GS_Summary_2017) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Goldstandard
Result_GS_Summary_2017 <- Goldstandard %>% 
                          left_join(Result_GS_Summary_2017, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                          select(
                                  Drugname, ICD10, Ground_Truth, 
                                  lift, count, conviction, pValue
                                )

# Export the result
csvname <- paste('Result_GS_Summary_2017.csv', sep=",")
write.csv(Result_GS_Summary_2017, csvname, row.names=FALSE)               

# Remove tables
rm(Result_GS_Summary_2017_pre); rm(Result_GS_Summary_2017_pre1); rm(Result_GS_Summary_2017_pre2); 
rm(Result_GS_positive_2017); rm(Result_GS_negative_2017)


## MEMO #########################################################################
# 14. ARM-ROCCurve
#################################################################################
# Import the files
Result_GS_Summary_2008 <- read_csv('Result_GS_Summary_2008.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2009 <- read_csv('Result_GS_Summary_2009.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2010 <- read_csv('Result_GS_Summary_2010.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2011 <- read_csv('Result_GS_Summary_2011.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2012 <- read_csv('Result_GS_Summary_2012.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2013 <- read_csv('Result_GS_Summary_2013.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2014 <- read_csv('Result_GS_Summary_2014.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2015 <- read_csv('Result_GS_Summary_2015.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2016 <- read_csv('Result_GS_Summary_2016.csv', col_names = TRUE, na=c("","NA", "NULL"))
Result_GS_Summary_2017 <- read_csv('Result_GS_Summary_2017.csv', col_names = TRUE, na=c("","NA", "NULL"))

# Calculate AUC values
############## 
# 2008year
ROC_ARMdata_2008 <- cbind(Result_GS_Summary_2008[, 4], Result_GS_Summary_2008 [, 3]) 
ROC_ARMdata_2008[is.na(ROC_ARMdata_2008)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2008) <- cbind('ARM', 'Golsta')
ROC_ARM_2008 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2008)
ROC_ARM_2008

############## 
# 2009year
ROC_ARMdata_2009 <- cbind(Result_GS_Summary_2009[, 4], Result_GS_Summary_2009 [, 3]) 
ROC_ARMdata_2009[is.na(ROC_ARMdata_2009)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2009) <- cbind('ARM', 'Golsta')
ROC_ARM_2009 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2009)
ROC_ARM_2009

############## 
# 2010year
ROC_ARMdata_2010 <- cbind(Result_GS_Summary_2010[, 4], Result_GS_Summary_2010 [, 3]) 
ROC_ARMdata_2010[is.na(ROC_ARMdata_2010)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2010) <- cbind('ARM', 'Golsta')
ROC_ARM_2010 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2010)
ROC_ARM_2010

############## 
# 2011year
ROC_ARMdata_2011 <- cbind(Result_GS_Summary_2011[, 4], Result_GS_Summary_2011 [, 3]) 
ROC_ARMdata_2011[is.na(ROC_ARMdata_2011)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2011) <- cbind('ARM', 'Golsta')
ROC_ARM_2011 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2011)
ROC_ARM_2011

############## 
# 2012year
ROC_ARMdata_2012 <- cbind(Result_GS_Summary_2012[, 4], Result_GS_Summary_2012 [, 3]) 
ROC_ARMdata_2012[is.na(ROC_ARMdata_2012)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2012) <- cbind('ARM', 'Golsta')
ROC_ARM_2012 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2012)
ROC_ARM_2012

############## 
# 2013year
ROC_ARMdata_2013 <- cbind(Result_GS_Summary_2013[, 4], Result_GS_Summary_2013 [, 3]) 
ROC_ARMdata_2013[is.na(ROC_ARMdata_2013)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2013) <- cbind('ARM', 'Golsta')
ROC_ARM_2013 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2013)
ROC_ARM_2013

############## 
# 2014year
ROC_ARMdata_2014 <- cbind(Result_GS_Summary_2014[, 4], Result_GS_Summary_2014 [, 3]) 
ROC_ARMdata_2014[is.na(ROC_ARMdata_2014)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2014) <- cbind('ARM', 'Golsta')
ROC_ARM_2014 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2014)
ROC_ARM_2014

############## 
# 2015year
ROC_ARMdata_2015 <- cbind(Result_GS_Summary_2015[, 4], Result_GS_Summary_2015 [, 3]) 
ROC_ARMdata_2015[is.na(ROC_ARMdata_2015)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2015) <- cbind('ARM', 'Golsta')
ROC_ARM_2015 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2015)
ROC_ARM_2015

############## 
# 2016year
ROC_ARMdata_2016 <- cbind(Result_GS_Summary_2016[, 4], Result_GS_Summary_2016 [, 3]) 
ROC_ARMdata_2016[is.na(ROC_ARMdata_2016)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2016) <- cbind('ARM', 'Golsta')
ROC_ARM_2016 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2016)
ROC_ARM_2016

############## 
# 2017year
ROC_ARMdata_2017 <- cbind(Result_GS_Summary_2017[, 4], Result_GS_Summary_2017 [, 3]) 
ROC_ARMdata_2017[is.na(ROC_ARMdata_2017)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_2017) <- cbind('ARM', 'Golsta')
ROC_ARM_2017 <- roc(formula = Golsta ~ ARM, ROC_ARMdata_2017)
ROC_ARM_2017


# Visualize
setwd('~/Desktop')
pdf('ARM_ROCAUC_Reproducibility.pdf')
plot(ROC_ARM_2008, lty=1, legacy.axes = TRUE, col = 3, ann = FALSE) 
legend(x = 0.4, y = 0.05, bty = "n", lwd = 2, lty = 1:3, legend = c("2008"), col = 3, cex = 0.7)
legend(x = 0.3, y = 0.05, bty = "n", lty = 0, legend =c(round(ROC_ARM_2008$auc, digits = 2)), col = 3, cex = 0.7)

par(new=T)

plot(ROC_ARM_2009, lty=1, legacy.axes = TRUE, col = 4, ann = FALSE) 
legend(x = 0.8, y = 0.1, bty = "n", lwd = 2, lty = 1:3, legend = c("2009"), col = 4, cex = 0.7)
legend(x = 0.7, y = 0.1, bty = "n", lty = 0, legend =c(round(ROC_ARM_2009$auc, digits = 2)), col = 4, cex = 0.7)

par(new=T)

plot(ROC_ARM_2010, lty=1, legacy.axes = TRUE, col = 5, ann = FALSE) 
legend(x = 0.6, y = 0.1, bty = "n", lwd = 2, lty = 1:3, legend = c("2010"), col = 5, cex = 0.7)
legend(x = 0.5, y = 0.1, bty = "n", lty = 0, legend =c(round(ROC_ARM_2010$auc, digits = 2)), col = 5, cex = 0.7)

par(new=T)

plot(ROC_ARM_2011, lty=1, legacy.axes = TRUE, col = 6, ann = FALSE) 
legend(x = 0.4, y = 0.1, bty = "n", lwd = 2, lty = 1:3, legend = c("2011"), col = 6, cex = 0.7)
legend(x = 0.3, y = 0.1, bty = "n", lty = 0, legend =c(round(ROC_ARM_2011$auc, digits = 2)), col = 6, cex = 0.7)

par(new=T)

plot(ROC_ARM_2012, lty=1, legacy.axes = TRUE, col = 7, ann = FALSE) 
legend(x = 0.8, y = 0.15, bty = "n", lwd = 2, lty = 1:3, legend = c("2012"), col = 7, cex = 0.7)
legend(x = 0.7, y = 0.15, bty = "n", lty = 0, legend =c(round(ROC_ARM_2012$auc, digits = 2)), col = 7, cex = 0.7)

par(new=T)

plot(ROC_ARM_2013, lty=1, legacy.axes = TRUE, col = 8, ann = FALSE) 
legend(x = 0.6, y = 0.15, bty = "n", lwd = 2, lty = 1:3, legend = c("2013"), col = 8, cex = 0.7)
legend(x = 0.5, y = 0.15, bty = "n", lty = 0, legend =c(round(ROC_ARM_2013$auc, digits = 2)), col = 8, cex = 0.7)

par(new=T)

plot(ROC_ARM_2014, lty=2, legacy.axes = TRUE, col = 1, ann = FALSE) 
legend(x = 0.4, y = 0.15, bty = "n", lwd = 2, lty = 2, legend = c("2014"), col = 1, cex = 0.7)
legend(x = 0.3, y = 0.15, bty = "n", lty = 0, legend =c(round(ROC_ARM_2014$auc, digits = 2)), col = 1, cex = 0.7)

par(new=T)

plot(ROC_ARM_2015, lty=2, legacy.axes = TRUE, col = 2, ann = FALSE) 
legend(x = 0.8, y = 0.2, bty = "n", lwd = 2, lty = 2, legend = c("2015"), col = 2, cex = 0.7)
legend(x = 0.7, y = 0.2, bty = "n", lty = 0, legend =c(round(ROC_ARM_2015$auc, digits = 2)), col = 2, cex = 0.7)

par(new=T)

plot(ROC_ARM_2016, lty=2, legacy.axes = TRUE, col = 3, ann = FALSE) 
legend(x = 0.6, y = 0.2, bty = "n", lwd = 2, lty = 2, legend = c("2016"), col = 3, cex = 0.7)
legend(x = 0.5, y = 0.2, bty = "n", lty = 0, legend =c(round(ROC_ARM_2016$auc, digits = 2)), col = 3, cex = 0.7)

par(new=T)

plot(ROC_ARM_2017, lty=2, legacy.axes = TRUE, col = 4, ann = FALSE) 
legend(x = 0.4, y = 0.2, bty = "n", lwd = 2, lty = 2, legend = c("2017"), col = 4, cex = 0.7)
legend(x = 0.3, y = 0.2, bty = "n", lty = 0, legend =c(round(ROC_ARM_2017$auc, digits = 2)), col = 4, cex = 0.7)

dev.off()



## MEMO #########################################
# 14. ARM-PRCurve
#################################################
############## 
# 2008year
pos_2008 <- ROC_ARMdata_2008$ARM[ROC_ARMdata_2008$Golsta == 1]; neg_2008 <- ROC_ARMdata_2008$ARM[ROC_ARMdata_2008$Golsta == 0]
pr_2008 <- pr.curve(scores.class0 = pos_2008, scores.class1 = neg_2008, curve = T)

############## 
# 2009year
pos_2009 <- ROC_ARMdata_2009$ARM[ROC_ARMdata_2009$Golsta == 1]; neg_2009 <- ROC_ARMdata_2009$ARM[ROC_ARMdata_2009$Golsta == 0]
pr_2009 <- pr.curve(scores.class0 = pos_2009, scores.class1 = neg_2009, curve = T)

############## 
# 2010year
pos_2010 <- ROC_ARMdata_2010$ARM[ROC_ARMdata_2010$Golsta == 1]; neg_2010 <- ROC_ARMdata_2010$ARM[ROC_ARMdata_2010$Golsta == 0]
pr_2010 <- pr.curve(scores.class0 = pos_2010, scores.class1 = neg_2010, curve = T)

############## 
# 2011year
pos_2011 <- ROC_ARMdata_2011$ARM[ROC_ARMdata_2011$Golsta == 1]; neg_2011 <- ROC_ARMdata_2011$ARM[ROC_ARMdata_2011$Golsta == 0]
pr_2011 <- pr.curve(scores.class0 = pos_2011, scores.class1 = neg_2011, curve = T)

############## 
# 2012year
pos_2012 <- ROC_ARMdata_2012$ARM[ROC_ARMdata_2012$Golsta == 1]; neg_2012 <- ROC_ARMdata_2012$ARM[ROC_ARMdata_2012$Golsta == 0]
pr_2012 <- pr.curve(scores.class0 = pos_2012, scores.class1 = neg_2012, curve = T)

############## 
# 2013year
pos_2013 <- ROC_ARMdata_2013$ARM[ROC_ARMdata_2013$Golsta == 1]; neg_2013 <- ROC_ARMdata_2013$ARM[ROC_ARMdata_2013$Golsta == 0]
pr_2013 <- pr.curve(scores.class0 = pos_2013, scores.class1 = neg_2013, curve = T)

############## 
# 2014year
pos_2014 <- ROC_ARMdata_2014$ARM[ROC_ARMdata_2014$Golsta == 1]; neg_2014 <- ROC_ARMdata_2014$ARM[ROC_ARMdata_2014$Golsta == 0]
pr_2014 <- pr.curve(scores.class0 = pos_2014, scores.class1 = neg_2014, curve = T)

############## 
# 2015year
pos_2015 <- ROC_ARMdata_2015$ARM[ROC_ARMdata_2015$Golsta == 1]; neg_2015 <- ROC_ARMdata_2015$ARM[ROC_ARMdata_2015$Golsta == 0]
pr_2015 <- pr.curve(scores.class0 = pos_2015, scores.class1 = neg_2015, curve = T)

############## 
# 2016year
pos_2016 <- ROC_ARMdata_2016$ARM[ROC_ARMdata_2016$Golsta == 1]; neg_2016 <- ROC_ARMdata_2016$ARM[ROC_ARMdata_2016$Golsta == 0]
pr_2016 <- pr.curve(scores.class0 = pos_2016, scores.class1 = neg_2016, curve = T)

############## 
# 2017year
pos_2017 <- ROC_ARMdata_2017$ARM[ROC_ARMdata_2017$Golsta == 1]; neg_2017 <- ROC_ARMdata_2017$ARM[ROC_ARMdata_2017$Golsta == 0]
pr_2017 <- pr.curve(scores.class0 = pos_2017, scores.class1 = neg_2017, curve = T)


# Visualize
setwd('~/Desktop')
pdf('JMDC_ARM_PRAUC_Reproducibility.pdf')
plot(pr_2008, xlab = "Recall", ylab = "Precision", lty=1, col = 3, ann = FALSE) 
legend(x = 0.7, y = 0.05, bty = "n", lwd = 2, lty = 1:3, legend = c("2008"), col = 3, cex = 0.7)
legend(x = 0.8, y = 0.05, bty = "n", lty = 0, legend =c(round(pr_2008$auc.integral, digits = 2)), col = 3, cex = 0.7)

par(new=T)

plot(pr_2009, xlab = "Recall", ylab = "Precision", lty=1, col = 4, ann = FALSE) 
legend(x = 0.3, y = 0.1, bty = "n", lwd = 2, lty = 1:3, legend = c("2009"), col = 4, cex = 0.7)
legend(x = 0.4, y = 0.1, bty = "n", lty = 0, legend =c(round(pr_2009$auc.integral, digits = 2)), col = 4, cex = 0.7)

par(new=T)

plot(pr_2010, xlab = "Recall", ylab = "Precision", lty=1, col = 5, ann = FALSE) 
legend(x = 0.5, y = 0.1, bty = "n", lwd = 2, lty = 1:3, legend = c("2010"), col = 5, cex = 0.7)
legend(x = 0.6, y = 0.1, bty = "n", lty = 0, legend =c(round(pr_2010$auc.integral, digits = 2)), col = 5, cex = 0.7)

par(new=T)

plot(pr_2011, xlab = "Recall", ylab = "Precision", lty=1, col = 6, ann = FALSE) 
legend(x = 0.7, y = 0.1, bty = "n", lwd = 2, lty = 1:3, legend = c("2011"), col = 6, cex = 0.7)
legend(x = 0.8, y = 0.1, bty = "n", lty = 0, legend =c(round(pr_2011$auc.integral, digits = 2)), col = 6, cex = 0.7)

par(new=T)

plot(pr_2012, xlab = "Recall", ylab = "Precision", lty=1, col = 7, ann = FALSE) 
legend(x = 0.3, y = 0.15, bty = "n", lwd = 2, lty = 1:3, legend = c("2012"), col = 7, cex = 0.7)
legend(x = 0.4, y = 0.15, bty = "n", lty = 0, legend =c(round(pr_2012$auc.integral, digits = 2)), col = 7, cex = 0.7)

par(new=T)

plot(pr_2013, xlab = "Recall", ylab = "Precision", lty=1, col = 8, ann = FALSE) 
legend(x = 0.5, y = 0.15, bty = "n", lwd = 2, lty = 1:3, legend = c("2013"), col = 8, cex = 0.7)
legend(x = 0.6, y = 0.15, bty = "n", lty = 0, legend =c(round(pr_2013$auc.integral, digits = 2)), col = 8, cex = 0.7)

par(new=T)

plot(pr_2014, xlab = "Recall", ylab = "Precision", lty=2, col = 1, ann = FALSE) 
legend(x = 0.7, y = 0.15, bty = "n", lwd = 2, lty = 2, legend = c("2014"), col = 1, cex = 0.7)
legend(x = 0.8, y = 0.15, bty = "n", lty = 0, legend =c(round(pr_2014$auc.integral, digits = 2)), col = 1, cex = 0.7)

par(new=T)

plot(pr_2015, xlab = "Recall", ylab = "Precision", lty=2, col = 2, ann = FALSE) 
legend(x = 0.3, y = 0.2, bty = "n", lwd = 2, lty = 2, legend = c("2015"), col = 2, cex = 0.7)
legend(x = 0.4, y = 0.2, bty = "n", lty = 0, legend =c(round(pr_2015$auc.integral, digits = 2)), col = 2, cex = 0.7)

par(new=T)

plot(pr_2016, xlab = "Recall", ylab = "Precision", lty=2, col = 3, ann = FALSE) 
legend(x = 0.5, y = 0.2, bty = "n", lwd = 2, lty = 2, legend = c("2016"), col = 3, cex = 0.7)
legend(x = 0.6, y = 0.2, bty = "n", lty = 0, legend =c(round(pr_2016$auc.integral, digits = 2)), col = 3, cex = 0.7)

par(new=T)

plot(pr_2017, xlab = "Recall", ylab = "Precision", lty=2, col = 4, ann = FALSE) 
legend(x = 0.7, y = 0.2, bty = "n", lwd = 2, lty = 2, legend = c("2017"), col = 4, cex = 0.7)
legend(x = 0.8, y = 0.2, bty = "n", lty = 0, legend =c(round(pr_2017$auc.integral, digits = 2)), col = 4, cex = 0.7)

dev.off()


# Remove tables
rm(pos_2008); rm(neg_2008); rm(pr_2008); rm(ROC_ARMdata_2008); rm(ROC_ARM_2008)
rm(pos_2009); rm(neg_2009); rm(pr_2009); rm(ROC_ARMdata_2009); rm(ROC_ARM_2009)
rm(pos_2010); rm(neg_2010); rm(pr_2010); rm(ROC_ARMdata_2010); rm(ROC_ARM_2010)
rm(pos_2011); rm(neg_2011); rm(pr_2011); rm(ROC_ARMdata_2011); rm(ROC_ARM_2011)
rm(pos_2012); rm(neg_2012); rm(pr_2012); rm(ROC_ARMdata_2012); rm(ROC_ARM_2012)
rm(pos_2013); rm(neg_2013); rm(pr_2013); rm(ROC_ARMdata_2013); rm(ROC_ARM_2013)
rm(pos_2014); rm(neg_2014); rm(pr_2014); rm(ROC_ARMdata_2014); rm(ROC_ARM_2014)
rm(pos_2015); rm(neg_2015); rm(pr_2015); rm(ROC_ARMdata_2015); rm(ROC_ARM_2015)
rm(pos_2016); rm(neg_2016); rm(pr_2016); rm(ROC_ARMdata_2016); rm(ROC_ARM_2016)
rm(pos_2017); rm(neg_2017); rm(pr_2017); rm(ROC_ARMdata_2017); rm(ROC_ARM_2017)


