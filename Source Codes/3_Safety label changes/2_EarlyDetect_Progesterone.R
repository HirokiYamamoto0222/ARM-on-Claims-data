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
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'set names utf8')

# Create the function
decanonicalize <- function(row, rdf){
                  details <- rdf %>%
                  dplyr::filter(加入者ID == row$加入者ID) %>%
                  magrittr::extract2('Item') %>%
                  as.vector()
                    }


## MEMO ###################################################################
# 2. Preprocessing
###########################################################################
############## 
# 2.1 Month elapsed after approval: 1month
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID = 1')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_1month.csv', format = 'basket')


############## 
# 2.2 Month elapsed after approval: 2months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_1months.csv', format = 'basket')


############## 
# 2.3 Month elapsed after approval: 3months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_3months.csv', format = 'basket')


############## 
# 2.4 Month elapsed after approval: 4months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_4months.csv', format = 'basket')


############## 
# 2.5 Month elapsed after approval: 5months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_5months.csv', format = 'basket')


############## 
# 2.6 Month elapsed after approval: 6months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_6months.csv', format = 'basket')


############## 
# 2.7 Month elapsed after approval: 7months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_7months.csv', format = 'basket')


############## 
# 2.8 Month elapsed after approval: 8months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_8months.csv', format = 'basket')


############## 
# 2.9 Month elapsed after approval: 9months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_9months.csv', format = 'basket')


############## 
# 2.10 Month elapsed after approval: 10months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_10months.csv', format = 'basket')


############## 
# 2.11 Month elapsed after approval: 11months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_11months.csv', format = 'basket')


############## 
# 2.12 Month elapsed after approval: 12months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_12months.csv', format = 'basket')


############## 
# 2.13 Month elapsed after approval: 13months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_13months.csv', format = 'basket')


############## 
# 2.14 Month elapsed after approval: 14months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_14months.csv', format = 'basket')


############## 
# 2.15 Month elapsed after approval: 15months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_15months.csv', format = 'basket')


############## 
# 2.16 Month elapsed after approval: 16months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_16months.csv', format = 'basket')


############## 
# 2.17 Month elapsed after approval: 17months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_17months.csv', format = 'basket')


############## 
# 2.18 Month elapsed after approval: 18months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_18months.csv', format = 'basket')


############## 
# 2.19 Month elapsed after approval: 19months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_19months.csv', format = 'basket')


############## 
# 2.20 Month elapsed after approval: 20months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_10months.csv', format = 'basket')


############## 
# 2.21 Month elapsed after approval: 21months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_11months.csv', format = 'basket')


############## 
# 2.22 Month elapsed after approval: 22months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_12months.csv', format = 'basket')


############## 
# 2.23 Month elapsed after approval: 23months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_13months.csv', format = 'basket')


############## 
# 2.24 Month elapsed after approval: 24months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_14months.csv', format = 'basket')


############## 
# 2.25 Month elapsed after approval: 25months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_15months.csv', format = 'basket')


############## 
# 2.26 Month elapsed after approval: 26months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_16months.csv', format = 'basket')


############## 
# 2.27 Month elapsed after approval: 27months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_17months.csv', format = 'basket')


############## 
# 2.28 Month elapsed after approval: 28months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_18months.csv', format = 'basket')


############## 
# 2.29 Month elapsed after approval: 29months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_19months.csv', format = 'basket')


############## 
# 2.30 Month elapsed after approval: 30months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_30months.csv', format = 'basket')


############## 
# 2.31 Month elapsed after approval: 31months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_31months.csv', format = 'basket')


############## 
# 2.32 Month elapsed after approval: 32months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_32months.csv', format = 'basket')


############## 
# 2.33 Month elapsed after approval: 33months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_33months.csv', format = 'basket')


############## 
# 2.34 Month elapsed after approval: 34months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_34months.csv', format = 'basket')


############## 
# 2.35 Month elapsed after approval: 35months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_35months.csv', format = 'basket')


############## 
# 2.36 Month elapsed after approval: 36months
Progesterone_SQLdata <- dbGetQuery(dbconnector, 'SELECT * FROM Progesterone_SQLdata WHERE eventID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36)')

Progesterone_SQLdata <- cbind(substring(Progesterone_SQLdata$加入者ID, 2, 10),
                              Progesterone_SQLdata[, 3],
                              Progesterone_SQLdata[, 4],
                              Progesterone_SQLdata[, 2])
colnames(Progesterone_SQLdata) <- cbind('加入者ID', 'Evday', 'eventID', 'Item')
Progesterone_SQLdata <- data.frame(Progesterone_SQLdata)
Progesterone_SQLdata$加入者ID <- as.numeric(Progesterone_SQLdata$加入者ID); Progesterone_SQLdata$eventID <- as.numeric(Progesterone_SQLdata$eventID)

ID_Table <- distinct(data.frame(Progesterone_SQLdata[, 1])); colnames(ID_Table) <- cbind('加入者ID'); ID_Table <- data.frame(ID_Table); Split_ID_Table <- split(ID_Table, ID_Table$加入者ID)
Transaction_list <- lapply(Split_ID_Table, decanonicalize, Progesterone_SQLdata)
ARM_TransactionData <- as(Transaction_list, 'transactions')

# Export the Transaction-Data
write(Progesterone_TransactionData, file = 'Progesterone_JMDC_ARM_36months.csv', format = 'basket')


## MEMO ###################################################################
# 3. Remove tables
###########################################################################
rm(list = ls())


## MEMO #########################################################################
# 4. ICD10Code
#################################################################################
ICD10Codelist <- read_csv('ICD10Codelist.csv', col_names=TRUE, na=c("","NA", "NULL"))
colnames(ICD10Codelist)<-cbind('ICD10Code')


## MEMO ###################################################################
# 5. Association rule mining
###########################################################################
############## 
# 2.1 Month elapsed after approval: 1month
# Read transaction
Progesterone_TransactionData_1 <- read.transactions('Progesterone_JMDC_ARM_1month.csv', format = 'basket')
Progesterone_ARM_rules_1 <- apriori(Progesterone_TransactionData_1, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_1 <- cbind(
                                        as(Progesterone_ARM_rules_1, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_1, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_1, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_1, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_1, "fishersExactTest", trans))
                                      )

Progesterone_ARM_inspectdata_1["rules"] <- lapply(Progesterone_ARM_inspectdata_1["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_1["rules"] <- lapply(Progesterone_ARM_inspectdata_1["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_1 <- Progesterone_ARM_inspectdata_1 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_1, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_1, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_1, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_1, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_1, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_1, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_1 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_1 <- Progesterone_Earlydetect_1 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                     cause, effect, lift, count, conviction, pValue
                                       )

# Export the result
Progesterone_result_1month <- subset(Progesterone_Earlydetect_1, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_1month.csv', sep = ',')
write.csv(Progesterone_result_1month, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_1); rm(Progesterone_ARM_rules_1); rm(Progesterone_ARM_inspectdata_1); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_1)


############## 
# 2.2 Month elapsed after approval: 2months
# Read transaction
Progesterone_TransactionData_2 <- read.transactions('Progesterone_JMDC_ARM_2months.csv', format = 'basket')
Progesterone_ARM_rules_2 <- apriori(Progesterone_TransactionData_2, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_2 <- cbind(
                                        as(Progesterone_ARM_rules_2, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_2, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_2, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_2, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_2, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_2["rules"] <- lapply(Progesterone_ARM_inspectdata_2["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_2["rules"] <- lapply(Progesterone_ARM_inspectdata_2["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_2 <- Progesterone_ARM_inspectdata_2 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_2, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_2, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_2, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_2, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_2, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_2, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_2 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_2 <- Progesterone_Earlydetect_2 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_2months <- subset(Progesterone_Earlydetect_2, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_2months.csv', sep = ',')
write.csv(Progesterone_result_2months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_2); rm(Progesterone_ARM_rules_2); rm(Progesterone_ARM_inspectdata_2); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_2)


############## 
# 2.3 Month elapsed after approval: 3months
# Read transaction
Progesterone_TransactionData_3 <- read.transactions('Progesterone_JMDC_ARM_3months.csv', format = 'basket')
Progesterone_ARM_rules_3 <- apriori(Progesterone_TransactionData_3, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_3 <- cbind(
                                        as(Progesterone_ARM_rules_3, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_3, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_3, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_3, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_3, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_3["rules"] <- lapply(Progesterone_ARM_inspectdata_3["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_3["rules"] <- lapply(Progesterone_ARM_inspectdata_3["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_3 <- Progesterone_ARM_inspectdata_3 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_3, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_3, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_3, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_3, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_3, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_3, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_3 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_3 <- Progesterone_Earlydetect_3 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_3months <- subset(Progesterone_Earlydetect_3, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_3months.csv', sep = ',')
write.csv(Progesterone_result_3months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_3); rm(Progesterone_ARM_rules_3); rm(Progesterone_ARM_inspectdata_3); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_3)


############## 
# 2.4 Month elapsed after approval: 4months
# Read transaction
Progesterone_TransactionData_4 <- read.transactions('Progesterone_JMDC_ARM_4months.csv', format = 'basket')
Progesterone_ARM_rules_4 <- apriori(Progesterone_TransactionData_4, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_4 <- cbind(
                                        as(Progesterone_ARM_rules_4, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_4, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_4, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_4, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_4, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_4["rules"] <- lapply(Progesterone_ARM_inspectdata_4["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_4["rules"] <- lapply(Progesterone_ARM_inspectdata_4["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_4 <- Progesterone_ARM_inspectdata_4 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_4, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_4, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_4, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_4, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_4, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_4, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_4 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_4 <- Progesterone_Earlydetect_4 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_4months <- subset(Progesterone_Earlydetect_4, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_4months.csv', sep = ',')
write.csv(Progesterone_result_4months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_4); rm(Progesterone_ARM_rules_4); rm(Progesterone_ARM_inspectdata_4); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_4)


############## 
# 2.5 Month elapsed after approval: 5months
# Read transaction
Progesterone_TransactionData_5 <- read.transactions('Progesterone_JMDC_ARM_5months.csv', format = 'basket')
Progesterone_ARM_rules_5 <- apriori(Progesterone_TransactionData_5, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_5 <- cbind(
                                        as(Progesterone_ARM_rules_5, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_5, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_5, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_5, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_5, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_5["rules"] <- lapply(Progesterone_ARM_inspectdata_5["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_5["rules"] <- lapply(Progesterone_ARM_inspectdata_5["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_5 <- Progesterone_ARM_inspectdata_5 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_5, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_5, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_5, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_5, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_5, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_5, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_5 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_5 <- Progesterone_Earlydetect_5 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_5months <- subset(Progesterone_Earlydetect_5, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_5months.csv', sep = ',')
write.csv(Progesterone_result_5months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_5); rm(Progesterone_ARM_rules_5); rm(Progesterone_ARM_inspectdata_5); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_5)


############## 
# 2.6 Month elapsed after approval: 6months
# Read transaction
Progesterone_TransactionData_6 <- read.transactions('Progesterone_JMDC_ARM_6months.csv', format = 'basket')
Progesterone_ARM_rules_6 <- apriori(Progesterone_TransactionData_6, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_6 <- cbind(
                                        as(Progesterone_ARM_rules_6, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_6, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_6, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_6, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_6, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_6["rules"] <- lapply(Progesterone_ARM_inspectdata_6["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_6["rules"] <- lapply(Progesterone_ARM_inspectdata_6["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_6 <- Progesterone_ARM_inspectdata_6 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_6, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_6, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_6, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_6, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_6, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_6, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_6 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_6 <- Progesterone_Earlydetect_6 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_6months <- subset(Progesterone_Earlydetect_6, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_6months.csv', sep = ',')
write.csv(Progesterone_result_6months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_6); rm(Progesterone_ARM_rules_6); rm(Progesterone_ARM_inspectdata_6); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_6)


############## 
# 2.7 Month elapsed after approval: 7months
# Read transaction
Progesterone_TransactionData_7 <- read.transactions('Progesterone_JMDC_ARM_7months.csv', format = 'basket')
Progesterone_ARM_rules_7 <- apriori(Progesterone_TransactionData_7, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_7 <- cbind(
                                        as(Progesterone_ARM_rules_7, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_7, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_7, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_7, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_7, "fishersExactTest", trans))
                                      )

Progesterone_ARM_inspectdata_7["rules"] <- lapply(Progesterone_ARM_inspectdata_7["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_7["rules"] <- lapply(Progesterone_ARM_inspectdata_7["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_7 <- Progesterone_ARM_inspectdata_7 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                           cbind(subset(Progesterone_ARM_inspectdata_7, count < 10)[, 1:2], 
                           subset(Progesterone_ARM_inspectdata_7, count < 10)[, 6:8],
                           subset(Progesterone_ARM_inspectdata_7, count < 10)[, 11])
                            )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_7, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_7, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_7, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_7 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_7 <- Progesterone_Earlydetect_7 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_7months <- subset(Progesterone_Earlydetect_7, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_7months.csv', sep = ',')
write.csv(Progesterone_result_7months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_7); rm(Progesterone_ARM_rules_7); rm(Progesterone_ARM_inspectdata_7); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_7)


############## 
# 2.8 Month elapsed after approval: 8months
# Read transaction
Progesterone_TransactionData_8 <- read.transactions('Progesterone_JMDC_ARM_8months.csv', format = 'basket')
Progesterone_ARM_rules_8 <- apriori(Progesterone_TransactionData_8, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_8 <- cbind(
                                        as(Progesterone_ARM_rules_8, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_8, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_8, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_8, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_8, "fishersExactTest", trans))
                                      )

Progesterone_ARM_inspectdata_8["rules"] <- lapply(Progesterone_ARM_inspectdata_8["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_8["rules"] <- lapply(Progesterone_ARM_inspectdata_8["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_8 <- Progesterone_ARM_inspectdata_8 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_8, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_8, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_8, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_8, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_8, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_8, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_8 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_8 <- Progesterone_Earlydetect_8 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_8months <- subset(Progesterone_Earlydetect_8, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_8months.csv', sep = ',')
write.csv(Progesterone_result_8months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_8); rm(Progesterone_ARM_rules_8); rm(Progesterone_ARM_inspectdata_8); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_8)


############## 
# 2.9 Month elapsed after approval: 9months
# Read transaction
Progesterone_TransactionData_9 <- read.transactions('Progesterone_JMDC_ARM_9months.csv', format = 'basket')
Progesterone_ARM_rules_9 <- apriori(Progesterone_TransactionData_9, 
                                    parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_9 <- cbind(
                                        as(Progesterone_ARM_rules_9, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_9, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_9, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_9, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_9, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_9["rules"] <- lapply(Progesterone_ARM_inspectdata_9["rules"], 
                                                  gsub, 
                                                  pattern = "{", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_9["rules"] <- lapply(Progesterone_ARM_inspectdata_9["rules"], 
                                                  gsub, 
                                                  pattern = "}", 
                                                  replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_9 <- Progesterone_ARM_inspectdata_9 %>% 
                                  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_9, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_9, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_9, count < 10)[, 11])
                                        )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_9, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_9, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_9, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_9 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_9 <- Progesterone_Earlydetect_9 %>% 
                              inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                              select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_9months <- subset(Progesterone_Earlydetect_9, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_9months.csv', sep = ',')
write.csv(Progesterone_result_9months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_9); rm(Progesterone_ARM_rules_9); rm(Progesterone_ARM_inspectdata_9); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_9)


############## 
# 2.10 Month elapsed after approval: 10months
# Read transaction
Progesterone_TransactionData_10 <- read.transactions('Progesterone_JMDC_ARM_10months.csv', format = 'basket')
Progesterone_ARM_rules_10 <- apriori(Progesterone_TransactionData_10, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_10 <- cbind(
                                          as(Progesterone_ARM_rules_10, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_10, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_10, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_10, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_10, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_10["rules"] <- lapply(Progesterone_ARM_inspectdata_10["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_10["rules"] <- lapply(Progesterone_ARM_inspectdata_10["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_10 <- Progesterone_ARM_inspectdata_10 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_10, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_10, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_10, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_10, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_10, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_10, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_10 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_10 <- Progesterone_Earlydetect_10 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_10months <- subset(Progesterone_Earlydetect_10, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_10months.csv', sep = ',')
write.csv(Progesterone_result_10months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_10); rm(Progesterone_ARM_rules_10); rm(Progesterone_ARM_inspectdata_10); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_10)


############## 
# 2.11 Month elapsed after approval: 11months
# Read transaction
Progesterone_TransactionData_11 <- read.transactions('Progesterone_JMDC_ARM_11months.csv', format = 'basket')
Progesterone_ARM_rules_11 <- apriori(Progesterone_TransactionData_11, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_11 <- cbind(
                                          as(Progesterone_ARM_rules_11, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_11, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_11, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_11, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_11, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_11["rules"] <- lapply(Progesterone_ARM_inspectdata_11["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_11["rules"] <- lapply(Progesterone_ARM_inspectdata_11["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_11 <- Progesterone_ARM_inspectdata_11 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_11, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_11, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_11, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_11, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_11, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_11, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_11 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_11 <- Progesterone_Earlydetect_11 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_11months <- subset(Progesterone_Earlydetect_11, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_11months.csv', sep = ',')
write.csv(Progesterone_result_11months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_11); rm(Progesterone_ARM_rules_11); rm(Progesterone_ARM_inspectdata_11); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_11)


############## 
# 2.12 Month elapsed after approval: 12months
# Read transaction
Progesterone_TransactionData_12 <- read.transactions('Progesterone_JMDC_ARM_12months.csv', format = 'basket')
Progesterone_ARM_rules_12 <- apriori(Progesterone_TransactionData_12, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_12 <- cbind(
                                          as(Progesterone_ARM_rules_12, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_12, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_12, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_12, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_12, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_12["rules"] <- lapply(Progesterone_ARM_inspectdata_12["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_12["rules"] <- lapply(Progesterone_ARM_inspectdata_12["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_12 <- Progesterone_ARM_inspectdata_12 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_12, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_12, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_12, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_12, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_12, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_12, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_12 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_12 <- Progesterone_Earlydetect_12 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_12months <- subset(Progesterone_Earlydetect_12, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_12months.csv', sep = ',')
write.csv(Progesterone_result_12months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_12); rm(Progesterone_ARM_rules_12); rm(Progesterone_ARM_inspectdata_12); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_12)


############## 
# 2.13 Month elapsed after approval: 13months
# Read transaction
Progesterone_TransactionData_13 <- read.transactions('Progesterone_JMDC_ARM_13months.csv', format = 'basket')
Progesterone_ARM_rules_13 <- apriori(Progesterone_TransactionData_13, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_13 <- cbind(
                                          as(Progesterone_ARM_rules_13, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_13, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_13, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_13, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_13, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_13["rules"] <- lapply(Progesterone_ARM_inspectdata_13["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_13["rules"] <- lapply(Progesterone_ARM_inspectdata_13["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_13 <- Progesterone_ARM_inspectdata_13 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_13, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_13, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_13, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_13, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_13, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_13, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_13 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_13 <- Progesterone_Earlydetect_13 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_13months <- subset(Progesterone_Earlydetect_13, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_13months.csv', sep = ',')
write.csv(Progesterone_result_13months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_13); rm(Progesterone_ARM_rules_13); rm(Progesterone_ARM_inspectdata_13); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_13)


############## 
# 2.14 Month elapsed after approval: 14months
# Read transaction
Progesterone_TransactionData_14 <- read.transactions('Progesterone_JMDC_ARM_14months.csv', format = 'basket')
Progesterone_ARM_rules_14 <- apriori(Progesterone_TransactionData_14, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_14 <- cbind(
                                          as(Progesterone_ARM_rules_14, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_14, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_14, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_14, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_14, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_14["rules"] <- lapply(Progesterone_ARM_inspectdata_14["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_14["rules"] <- lapply(Progesterone_ARM_inspectdata_14["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_14 <- Progesterone_ARM_inspectdata_14 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_14, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_14, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_14, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_14, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_14, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_14, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_14 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_14 <- Progesterone_Earlydetect_14 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_14months <- subset(Progesterone_Earlydetect_14, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_14months.csv', sep = ',')
write.csv(Progesterone_result_14months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_14); rm(Progesterone_ARM_rules_14); rm(Progesterone_ARM_inspectdata_14); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_14)


############## 
# 2.15 Month elapsed after approval: 15months
# Read transaction
Progesterone_TransactionData_15 <- read.transactions('Progesterone_JMDC_ARM_15months.csv', format = 'basket')
Progesterone_ARM_rules_15 <- apriori(Progesterone_TransactionData_15, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_15 <- cbind(
                                          as(Progesterone_ARM_rules_15, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_15, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_15, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_15, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_15, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_15["rules"] <- lapply(Progesterone_ARM_inspectdata_15["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_15["rules"] <- lapply(Progesterone_ARM_inspectdata_15["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_15 <- Progesterone_ARM_inspectdata_15 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_15, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_15, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_15, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_15, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_15, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_15, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_15 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_15 <- Progesterone_Earlydetect_15 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_15months <- subset(Progesterone_Earlydetect_15, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_15months.csv', sep = ',')
write.csv(Progesterone_result_15months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_15); rm(Progesterone_ARM_rules_15); rm(Progesterone_ARM_inspectdata_15); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_15)


############## 
# 2.16 Month elapsed after approval: 16months
# Read transaction
Progesterone_TransactionData_16 <- read.transactions('Progesterone_JMDC_ARM_16months.csv', format = 'basket')
Progesterone_ARM_rules_16 <- apriori(Progesterone_TransactionData_16, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_16 <- cbind(
                                          as(Progesterone_ARM_rules_16, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_16, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_16, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_16, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_16, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_16["rules"] <- lapply(Progesterone_ARM_inspectdata_16["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_16["rules"] <- lapply(Progesterone_ARM_inspectdata_16["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_16 <- Progesterone_ARM_inspectdata_16 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_16, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_16, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_16, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_16, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_16, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_16, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_16 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_16 <- Progesterone_Earlydetect_16 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_16months <- subset(Progesterone_Earlydetect_16, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_16months.csv', sep = ',')
write.csv(Progesterone_result_16months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_16); rm(Progesterone_ARM_rules_16); rm(Progesterone_ARM_inspectdata_16); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_16)


############## 
# 2.17 Month elapsed after approval: 17months
# Read transaction
Progesterone_TransactionData_17 <- read.transactions('Progesterone_JMDC_ARM_17months.csv', format = 'basket')
Progesterone_ARM_rules_17 <- apriori(Progesterone_TransactionData_17, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_17 <- cbind(
                                          as(Progesterone_ARM_rules_17, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_17, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_17, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_17, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_17, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_17["rules"] <- lapply(Progesterone_ARM_inspectdata_17["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_17["rules"] <- lapply(Progesterone_ARM_inspectdata_17["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_17 <- Progesterone_ARM_inspectdata_17 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_17, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_17, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_17, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_17, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_17, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_17, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_17 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_17 <- Progesterone_Earlydetect_17 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_17months <- subset(Progesterone_Earlydetect_17, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_17months.csv', sep = ',')
write.csv(Progesterone_result_17months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_17); rm(Progesterone_ARM_rules_17); rm(Progesterone_ARM_inspectdata_17); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_17)


############## 
# 2.18 Month elapsed after approval: 18months
# Read transaction
Progesterone_TransactionData_18 <- read.transactions('Progesterone_JMDC_ARM_18months.csv', format = 'basket')
Progesterone_ARM_rules_18 <- apriori(Progesterone_TransactionData_18, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_18 <- cbind(
                                          as(Progesterone_ARM_rules_18, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_18, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_18, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_18, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_18, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_18["rules"] <- lapply(Progesterone_ARM_inspectdata_18["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_18["rules"] <- lapply(Progesterone_ARM_inspectdata_18["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_18 <- Progesterone_ARM_inspectdata_18 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_18, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_18, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_18, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_18, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_18, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_18, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_18 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_18 <- Progesterone_Earlydetect_18 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_18months <- subset(Progesterone_Earlydetect_18, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_18months.csv', sep = ',')
write.csv(Progesterone_result_18months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_18); rm(Progesterone_ARM_rules_18); rm(Progesterone_ARM_inspectdata_18); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_18)


############## 
# 2.19 Month elapsed after approval: 19months
# Read transaction
Progesterone_TransactionData_19 <- read.transactions('Progesterone_JMDC_ARM_19months.csv', format = 'basket')
Progesterone_ARM_rules_19 <- apriori(Progesterone_TransactionData_19, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_19 <- cbind(
                                          as(Progesterone_ARM_rules_19, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_19, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_19, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_19, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_19, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_19["rules"] <- lapply(Progesterone_ARM_inspectdata_19["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_19["rules"] <- lapply(Progesterone_ARM_inspectdata_19["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_19 <- Progesterone_ARM_inspectdata_19 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_19, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_19, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_19, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_19, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_19, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_19, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_19 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_19 <- Progesterone_Earlydetect_19 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_19months <- subset(Progesterone_Earlydetect_19, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_19months.csv', sep = ',')
write.csv(Progesterone_result_19months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_19); rm(Progesterone_ARM_rules_19); rm(Progesterone_ARM_inspectdata_19); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_19)


############## 
# 2.20 Month elapsed after approval: 20months
# Read transaction
Progesterone_TransactionData_20 <- read.transactions('Progesterone_JMDC_ARM_20months.csv', format = 'basket')
Progesterone_ARM_rules_20 <- apriori(Progesterone_TransactionData_20, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_20 <- cbind(
                                         as(Progesterone_ARM_rules_20, "data.frame"), 
                                         conviction = interestMeasure(Progesterone_ARM_rules_20, "conviction", trans), 
                                         chiSquared = interestMeasure(Progesterone_ARM_rules_20, "chiSquared", trans),
                                         "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_20, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                         "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_20, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_20["rules"] <- lapply(Progesterone_ARM_inspectdata_20["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_20["rules"] <- lapply(Progesterone_ARM_inspectdata_20["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_20 <- Progesterone_ARM_inspectdata_20 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_20, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_20, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_20, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_20, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_20, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_20, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_20 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_20 <- Progesterone_Earlydetect_20 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_20months <- subset(Progesterone_Earlydetect_20, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_20months.csv', sep = ',')
write.csv(Progesterone_result_20months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_20); rm(Progesterone_ARM_rules_20); rm(Progesterone_ARM_inspectdata_20); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_20)


############## 
# 2.21 Month elapsed after approval: 21months
# Read transaction
Progesterone_TransactionData_21 <- read.transactions('Progesterone_JMDC_ARM_21months.csv', format = 'basket')
Progesterone_ARM_rules_21 <- apriori(Progesterone_TransactionData_21, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_21 <- cbind(
                                          as(Progesterone_ARM_rules_21, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_21, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_21, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_21, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_21, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_21["rules"] <- lapply(Progesterone_ARM_inspectdata_21["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_21["rules"] <- lapply(Progesterone_ARM_inspectdata_21["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_21 <- Progesterone_ARM_inspectdata_21 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_21, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_21, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_21, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_21, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_21, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_21, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_21 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_21 <- Progesterone_Earlydetect_21 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                       cause, effect, lift, count, conviction, pValue
                                     )

# Export the result
Progesterone_result_21months <- subset(Progesterone_Earlydetect_21, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_21months.csv', sep = ',')
write.csv(Progesterone_result_21months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_21); rm(Progesterone_ARM_rules_21); rm(Progesterone_ARM_inspectdata_21); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_21)


############## 
# 2.22 Month elapsed after approval: 22months
# Read transaction
Progesterone_TransactionData_22 <- read.transactions('Progesterone_JMDC_ARM_22months.csv', format = 'basket')
Progesterone_ARM_rules_22 <- apriori(Progesterone_TransactionData_22, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_22 <- cbind(
                                        as(Progesterone_ARM_rules_22, "data.frame"), 
                                        conviction = interestMeasure(Progesterone_ARM_rules_22, "conviction", trans), 
                                        chiSquared = interestMeasure(Progesterone_ARM_rules_22, "chiSquared", trans),
                                        "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_22, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                        "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_22, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_22["rules"] <- lapply(Progesterone_ARM_inspectdata_22["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_22["rules"] <- lapply(Progesterone_ARM_inspectdata_22["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_22 <- Progesterone_ARM_inspectdata_22 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_22, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_22, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_22, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_22, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_22, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_22, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_22 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_22 <- Progesterone_Earlydetect_22 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_22months <- subset(Progesterone_Earlydetect_22, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_22months.csv', sep = ',')
write.csv(Progesterone_result_22months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_22); rm(Progesterone_ARM_rules_22); rm(Progesterone_ARM_inspectdata_22); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_22)


############## 
# 2.23 Month elapsed after approval: 23months
# Read transaction
Progesterone_TransactionData_23 <- read.transactions('Progesterone_JMDC_ARM_23months.csv', format = 'basket')
Progesterone_ARM_rules_23 <- apriori(Progesterone_TransactionData_23, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_23 <- cbind(
                                          as(Progesterone_ARM_rules_23, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_23, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_23, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_23, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_23, "fishersExactTest", trans))
                                      )

Progesterone_ARM_inspectdata_23["rules"] <- lapply(Progesterone_ARM_inspectdata_23["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_23["rules"] <- lapply(Progesterone_ARM_inspectdata_23["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_23 <- Progesterone_ARM_inspectdata_23 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_23, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_23, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_23, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_23, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_23, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_23, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_23 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_23 <- Progesterone_Earlydetect_23 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_23months <- subset(Progesterone_Earlydetect_23, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_23months.csv', sep = ',')
write.csv(Progesterone_result_23months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_23); rm(Progesterone_ARM_rules_23); rm(Progesterone_ARM_inspectdata_23); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_23)


############## 
# 2.24 Month elapsed after approval: 24months
# Read transaction
Progesterone_TransactionData_24 <- read.transactions('Progesterone_JMDC_ARM_24months.csv', format = 'basket')
Progesterone_ARM_rules_24 <- apriori(Progesterone_TransactionData_24, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_24 <- cbind(
                                          as(Progesterone_ARM_rules_24, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_24, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_24, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_24, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_24, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_24["rules"] <- lapply(Progesterone_ARM_inspectdata_24["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_24["rules"] <- lapply(Progesterone_ARM_inspectdata_24["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_24 <- Progesterone_ARM_inspectdata_24 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_24, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_24, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_24, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_24, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_24, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_24, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_24 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_24 <- Progesterone_Earlydetect_24 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_24months <- subset(Progesterone_Earlydetect_24, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_24months.csv', sep = ',')
write.csv(Progesterone_result_24months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_24); rm(Progesterone_ARM_rules_24); rm(Progesterone_ARM_inspectdata_24); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_24)


############## 
# 2.25 Month elapsed after approval: 25months
# Read transaction
Progesterone_TransactionData_25 <- read.transactions('Progesterone_JMDC_ARM_25months.csv', format = 'basket')
Progesterone_ARM_rules_25 <- apriori(Progesterone_TransactionData_25, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_25 <- cbind(
                                          as(Progesterone_ARM_rules_25, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_25, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_25, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_25, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_25, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_25["rules"] <- lapply(Progesterone_ARM_inspectdata_25["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_25["rules"] <- lapply(Progesterone_ARM_inspectdata_25["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_25 <- Progesterone_ARM_inspectdata_25 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_25, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_25, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_25, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_25, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_25, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_25, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_25 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_25 <- Progesterone_Earlydetect_25 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                     )

# Export the result
Progesterone_result_25months <- subset(Progesterone_Earlydetect_25, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_25months.csv', sep = ',')
write.csv(Progesterone_result_25months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_25); rm(Progesterone_ARM_rules_25); rm(Progesterone_ARM_inspectdata_25); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_25)


############## 
# 2.26 Month elapsed after approval: 26months
# Read transaction
Progesterone_TransactionData_26 <- read.transactions('Progesterone_JMDC_ARM_26months.csv', format = 'basket')
Progesterone_ARM_rules_26 <- apriori(Progesterone_TransactionData_26, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_26 <- cbind(
                                          as(Progesterone_ARM_rules_26, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_26, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_26, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_26, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_26, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_26["rules"] <- lapply(Progesterone_ARM_inspectdata_26["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_26["rules"] <- lapply(Progesterone_ARM_inspectdata_26["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_26 <- Progesterone_ARM_inspectdata_26 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_26, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_26, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_26, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_26, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_26, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_26, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_26 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_26 <- Progesterone_Earlydetect_26 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_26months <- subset(Progesterone_Earlydetect_26, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_26months.csv', sep = ',')
write.csv(Progesterone_result_26months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_26); rm(Progesterone_ARM_rules_26); rm(Progesterone_ARM_inspectdata_26); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_26)


############## 
# 2.27 Month elapsed after approval: 27months
# Read transaction
Progesterone_TransactionData_27 <- read.transactions('Progesterone_JMDC_ARM_27months.csv', format = 'basket')
Progesterone_ARM_rules_27 <- apriori(Progesterone_TransactionData_27, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_27 <- cbind(
                                          as(Progesterone_ARM_rules_27, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_27, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_27, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_27, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_27, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_27["rules"] <- lapply(Progesterone_ARM_inspectdata_27["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_27["rules"] <- lapply(Progesterone_ARM_inspectdata_27["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_27 <- Progesterone_ARM_inspectdata_27 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_27, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_27, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_27, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_27, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_27, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_27, count >= 10)[, 10])
                                        )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_27 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_27 <- Progesterone_Earlydetect_27 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                     )

# Export the result
Progesterone_result_27months <- subset(Progesterone_Earlydetect_27, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_27months.csv', sep = ',')
write.csv(Progesterone_result_27months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_27); rm(Progesterone_ARM_rules_27); rm(Progesterone_ARM_inspectdata_27); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_27)


############## 
# 2.28 Month elapsed after approval: 28months
# Read transaction
Progesterone_TransactionData_28 <- read.transactions('Progesterone_JMDC_ARM_28months.csv', format = 'basket')
Progesterone_ARM_rules_28 <- apriori(Progesterone_TransactionData_28, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_28 <- cbind(
                                          as(Progesterone_ARM_rules_28, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_28, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_28, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_28, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_28, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_28["rules"] <- lapply(Progesterone_ARM_inspectdata_28["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_28["rules"] <- lapply(Progesterone_ARM_inspectdata_28["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_28 <- Progesterone_ARM_inspectdata_28 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
  cbind(subset(Progesterone_ARM_inspectdata_28, count < 10)[, 1:2], 
        subset(Progesterone_ARM_inspectdata_28, count < 10)[, 6:8],
        subset(Progesterone_ARM_inspectdata_28, count < 10)[, 11])
)
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_28, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_28, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_28, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_28 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_28 <- Progesterone_Earlydetect_28 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_28months <- subset(Progesterone_Earlydetect_28, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_28months.csv', sep = ',')
write.csv(Progesterone_result_28months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_28); rm(Progesterone_ARM_rules_28); rm(Progesterone_ARM_inspectdata_28); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_28)


############## 
# 2.29 Month elapsed after approval: 29months
# Read transaction
Progesterone_TransactionData_29 <- read.transactions('Progesterone_JMDC_ARM_29months.csv', format = 'basket')
Progesterone_ARM_rules_29 <- apriori(Progesterone_TransactionData_29, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_29 <- cbind(
                                          as(Progesterone_ARM_rules_29, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_29, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_29, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_29, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_29, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_29["rules"] <- lapply(Progesterone_ARM_inspectdata_29["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_29["rules"] <- lapply(Progesterone_ARM_inspectdata_29["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_29 <- Progesterone_ARM_inspectdata_29 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_29, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_29, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_29, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_29, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_29, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_29, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_29 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_29 <- Progesterone_Earlydetect_29 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_29months <- subset(Progesterone_Earlydetect_29, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_29months.csv', sep = ',')
write.csv(Progesterone_result_29months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_29); rm(Progesterone_ARM_rules_29); rm(Progesterone_ARM_inspectdata_29); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_29)


############## 
# 2.30 Month elapsed after approval: 30months
# Read transaction
Progesterone_TransactionData_30 <- read.transactions('Progesterone_JMDC_ARM_30months.csv', format = 'basket')
Progesterone_ARM_rules_30 <- apriori(Progesterone_TransactionData_30, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_30 <- cbind(
                                          as(Progesterone_ARM_rules_30, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_30, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_30, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_30, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_30, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_30["rules"] <- lapply(Progesterone_ARM_inspectdata_30["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_30["rules"] <- lapply(Progesterone_ARM_inspectdata_30["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_30 <- Progesterone_ARM_inspectdata_30 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_30, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_30, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_30, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_30, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_30, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_30, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_30 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_30 <- Progesterone_Earlydetect_30 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_30months <- subset(Progesterone_Earlydetect_30, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_30months.csv', sep = ',')
write.csv(Progesterone_result_30months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_30); rm(Progesterone_ARM_rules_30); rm(Progesterone_ARM_inspectdata_30); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_30)


############## 
# 2.31 Month elapsed after approval: 31months
# Read transaction
Progesterone_TransactionData_31 <- read.transactions('Progesterone_JMDC_ARM_31months.csv', format = 'basket')
Progesterone_ARM_rules_31 <- apriori(Progesterone_TransactionData_31, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_31 <- cbind(
                                          as(Progesterone_ARM_rules_31, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_31, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_31, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_31, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_31, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_31["rules"] <- lapply(Progesterone_ARM_inspectdata_31["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_31["rules"] <- lapply(Progesterone_ARM_inspectdata_31["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_31 <- Progesterone_ARM_inspectdata_31 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_31, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_31, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_31, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_31, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_31, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_31, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_31 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_31 <- Progesterone_Earlydetect_31 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_31months <- subset(Progesterone_Earlydetect_31, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_31months.csv', sep = ',')
write.csv(Progesterone_result_31months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_31); rm(Progesterone_ARM_rules_31); rm(Progesterone_ARM_inspectdata_31); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_31)


############## 
# 2.32 Month elapsed after approval: 32months
# Read transaction
Progesterone_TransactionData_32 <- read.transactions('Progesterone_JMDC_ARM_32months.csv', format = 'basket')
Progesterone_ARM_rules_32 <- apriori(Progesterone_TransactionData_32, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_32 <- cbind(
                                          as(Progesterone_ARM_rules_32, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_32, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_32, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_32, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_32, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_32["rules"] <- lapply(Progesterone_ARM_inspectdata_32["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_32["rules"] <- lapply(Progesterone_ARM_inspectdata_32["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_32 <- Progesterone_ARM_inspectdata_32 %>% 
  separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_32, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_32, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_32, count < 10)[, 11])
                                    )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_32, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_32, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_32, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_32 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_32 <- Progesterone_Earlydetect_32 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                  )

# Export the result
Progesterone_result_32months <- subset(Progesterone_Earlydetect_32, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_32months.csv', sep = ',')
write.csv(Progesterone_result_32months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_32); rm(Progesterone_ARM_rules_32); rm(Progesterone_ARM_inspectdata_32); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_32)


############## 
# 2.33 Month elapsed after approval: 33months
# Read transaction
Progesterone_TransactionData_33 <- read.transactions('Progesterone_JMDC_ARM_33months.csv', format = 'basket')
Progesterone_ARM_rules_33 <- apriori(Progesterone_TransactionData_33, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_33 <- cbind(
                                          as(Progesterone_ARM_rules_33, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_33, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_33, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_33, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_33, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_33["rules"] <- lapply(Progesterone_ARM_inspectdata_33["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_33["rules"] <- lapply(Progesterone_ARM_inspectdata_33["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_33 <- Progesterone_ARM_inspectdata_33 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_33, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_33, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_33, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_33, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_33, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_33, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_33 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_33 <- Progesterone_Earlydetect_33 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_33months <- subset(Progesterone_Earlydetect_33, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_33months.csv', sep = ',')
write.csv(Progesterone_result_33months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_33); rm(Progesterone_ARM_rules_33); rm(Progesterone_ARM_inspectdata_33); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_33)


############## 
# 2.34 Month elapsed after approval: 34months
# Read transaction
Progesterone_TransactionData_34 <- read.transactions('Progesterone_JMDC_ARM_34months.csv', format = 'basket')
Progesterone_ARM_rules_34 <- apriori(Progesterone_TransactionData_34, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_34 <- cbind(
                                          as(Progesterone_ARM_rules_34, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_34, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_34, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_34, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_34, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_34["rules"] <- lapply(Progesterone_ARM_inspectdata_34["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_34["rules"] <- lapply(Progesterone_ARM_inspectdata_34["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_34 <- Progesterone_ARM_inspectdata_34 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_34, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_34, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_34, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_34, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_34, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_34, count >= 10)[, 10])
                                      )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_34 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_34 <- Progesterone_Earlydetect_34 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                        )

# Export the result
Progesterone_result_34months <- subset(Progesterone_Earlydetect_34, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_34months.csv', sep = ',')
write.csv(Progesterone_result_34months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_34); rm(Progesterone_ARM_rules_34); rm(Progesterone_ARM_inspectdata_34); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_34)


############## 
# 2.35 Month elapsed after approval: 35months
# Read transaction
Progesterone_TransactionData_35 <- read.transactions('Progesterone_JMDC_ARM_35months.csv', format = 'basket')
Progesterone_ARM_rules_35 <- apriori(Progesterone_TransactionData_35, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_35 <- cbind(
                                          as(Progesterone_ARM_rules_35, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_35, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_35, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_35, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_35, "fishersExactTest", trans))
                                        )

Progesterone_ARM_inspectdata_35["rules"] <- lapply(Progesterone_ARM_inspectdata_35["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_35["rules"] <- lapply(Progesterone_ARM_inspectdata_35["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_35 <- Progesterone_ARM_inspectdata_35 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_35, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_35, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_35, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_35, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_35, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_35, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_35 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_35 <- Progesterone_Earlydetect_35 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                      cause, effect, lift, count, conviction, pValue
                                      )

# Export the result
Progesterone_result_35months <- subset(Progesterone_Earlydetect_35, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_35months.csv', sep = ',')
write.csv(Progesterone_result_35months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_35); rm(Progesterone_ARM_rules_35); rm(Progesterone_ARM_inspectdata_35); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_35)


############## 
# 2.36 Month elapsed after approval: 36months
# Read transaction
Progesterone_TransactionData_36 <- read.transactions('Progesterone_JMDC_ARM_36months.csv', format = 'basket')
Progesterone_ARM_rules_36 <- apriori(Progesterone_TransactionData_36, 
                                     parameter = list(support = 0.0000000001, confidence = 0.0000000001, minlen = 2, maxlen = 2))

# lift, conviction, chiSquared
Progesterone_ARM_inspectdata_36 <- cbind(
                                          as(Progesterone_ARM_rules_36, "data.frame"), 
                                          conviction = interestMeasure(Progesterone_ARM_rules_36, "conviction", trans), 
                                          chiSquared = interestMeasure(Progesterone_ARM_rules_36, "chiSquared", trans),
                                          "-log10(χ2_pValue)" = -pchisq((interestMeasure(Progesterone_ARM_rules_36, "chiSquared", trans)), df=1, lower.tail=F, log.p = T)/log(10), 
                                          "-log10(fishersExactTest)" = -log10(interestMeasure(Progesterone_ARM_rules_36, "fishersExactTest", trans))
                                          )

Progesterone_ARM_inspectdata_36["rules"] <- lapply(Progesterone_ARM_inspectdata_36["rules"], 
                                                   gsub, 
                                                   pattern = "{", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_36["rules"] <- lapply(Progesterone_ARM_inspectdata_36["rules"], 
                                                   gsub, 
                                                   pattern = "}", 
                                                   replacement = "", fixed=TRUE)

Progesterone_ARM_inspectdata_36 <- Progesterone_ARM_inspectdata_36 %>% 
                                   separate(rules, c("cause", "effect"), sep=" => ")

# The Fisher's exact test(less than 10 values)
Earlydetect_result_pre1 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_36, count < 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_36, count < 10)[, 6:8],
                                      subset(Progesterone_ARM_inspectdata_36, count < 10)[, 11])
                                      )
colnames(Earlydetect_result_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Earlydetect_result_pre2 <- data.frame(
                                      cbind(subset(Progesterone_ARM_inspectdata_36, count >= 10)[, 1:2], 
                                      subset(Progesterone_ARM_inspectdata_36, count >= 10)[, 6:8], 
                                      subset(Progesterone_ARM_inspectdata_36, count >= 10)[, 10])
                                    )
colnames(Earlydetect_result_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Progesterone_Earlydetect_36 <- rbind(Earlydetect_result_pre1, Earlydetect_result_pre2)

# effect: only ICD10Code
Progesterone_Earlydetect_36 <- Progesterone_Earlydetect_36 %>% 
                               inner_join(ICD10Codelist, by = c('effect' = 'ICD10Code')) %>% 
                               select(
                                       cause, effect, lift, count, conviction, pValue
                                    )

# Export the result
Progesterone_result_36months <- subset(Progesterone_Earlydetect_36, cause == 'ドロスピレノン・エチニルエストラジオール　ベータデクス')
csvname <- paste('Progesterone_result_36months.csv', sep = ',')
write.csv(Progesterone_result_36months, csvname, row.names = FALSE)

# Remove tables
rm(Progesterone_TransactionData_36); rm(Progesterone_ARM_rules_36); rm(Progesterone_ARM_inspectdata_36); 
rm(Earlydetect_result_pre1); rm(Earlydetect_result_pre2); rm(Progesterone_Earlydetect_36)

