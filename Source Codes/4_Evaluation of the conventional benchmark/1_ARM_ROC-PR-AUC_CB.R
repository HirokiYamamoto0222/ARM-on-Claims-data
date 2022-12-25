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
# 1. Preprocessing
###########################################################################
# "JMDC_ARM_15y.csv" is pre-created in "2_ARM_ROC-PR-AUC.R"


## MEMO ###################################################################
# 2. Association rule mining
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
CB_positive_15y <- subset(JMDC_ARM_15y_inspectdata, 
                                     cause == 'アシクロビル' & effect == 'N17'|
                                     cause == 'アムロジピンベシル酸塩' & effect == 'I21'|
                                     cause == 'アロプリノール' & effect == 'K71'|
                                     cause == 'イブプロフェン' & effect == 'N17'|
                                     cause == 'イブプロフェン' & effect == 'K71'|
                                     cause == 'イブプロフェン' & effect == 'K92'|
                                     cause == 'インドメタシン' & effect == 'K71'|
                                     cause == 'インドメタシン' & effect == 'I21'|
                                     cause == 'インドメタシン' & effect == 'K92'|
                                     cause == 'エスシタロプラムシュウ酸塩' & effect == 'K92'|
                                     cause == 'エストラジオール' & effect == 'I21'|
                                     cause == 'エトドラク' & effect == 'K71'|
                                     cause == 'エトドラク' & effect == 'I21'|
                                     cause == 'エトドラク' & effect == 'K92'|
                                     cause == 'エポエチン　アルファ（遺伝子組換え）' & effect == 'I21'|
                                     cause == 'エリスロマイシン' & effect == 'K71'|
                                     cause == 'オキサプロジン' & effect == 'K71'|
                                     cause == 'オキサプロジン' & effect == 'I21'|
                                     cause == 'オキサプロジン' & effect == 'K92'|
                                     cause == 'オフロキサシン' & effect == 'K71'|
                                     cause == 'オルメサルタン　メドキソミル' & effect == 'N17'|
                                     cause == 'カルバマゼピン' & effect == 'K71'|
                                     cause == 'キナプリル塩酸塩' & effect == 'K71'|
                                     cause == 'クリンダマイシン塩酸塩' & effect == 'K92'|
                                     cause == 'クロピドグレル硫酸塩' & effect == 'K92'|
                                     cause == 'シクロスポリン' & effect == 'K71'|
                                     cause == 'ジピリダモール' & effect == 'I21'|
                                     cause == 'シプロフロキサシン' & effect == 'K71'|
                                     cause == 'ジルチアゼム塩酸塩' & effect == 'K71'|
                                     cause == 'スマトリプタン' & effect == 'I21'|
                                     cause == 'スリンダク' & effect == 'K71'|
                                     cause == 'スリンダク' & effect == 'I21'|
                                     cause == 'セルトラリン塩酸塩' & effect == 'K92'|
                                     cause == 'セレコキシブ' & effect == 'K71'|
                                     cause == 'タモキシフェンクエン酸塩' & effect == 'K71'|
                                     cause == 'ダルベポエチン　アルファ（遺伝子組換え）' & effect == 'I21'|
                                     cause == 'テルビナフィン塩酸塩' & effect == 'K71'|
                                     cause == 'トランドラプリル' & effect == 'K71'|
                                     cause == 'ナプロキセン' & effect == 'N17'|
                                     cause == 'ナプロキセン' & effect == 'K71'|
                                     cause == 'ナプロキセン' & effect == 'K92'|
                                     cause == 'ニフェジピン' & effect == 'K71'|
                                     cause == 'ニフェジピン' & effect == 'I21'|
                                     cause == 'ノルトリプチリン塩酸塩' & effect == 'K71'|
                                     cause == 'ノルトリプチリン塩酸塩' & effect == 'I21'|
                                     cause == 'バルプロ酸ナトリウム' & effect == 'K71'|
                                     cause == 'ピオグリタゾン塩酸塩' & effect == 'K71'|
                                     cause == 'ヒドロクロロチアジド' & effect == 'N17'|
                                     cause == 'ピロキシカム' & effect == 'K71'|
                                     cause == 'ピロキシカム' & effect == 'I21'|
                                     cause == 'ピロキシカム' & effect == 'K92'|
                                     cause == 'フルコナゾール' & effect == 'K71'|
                                     cause == 'メトトレキサート' & effect == 'K71'|
                                     cause == 'メロキシカム' & effect == 'N17'|
                                     cause == 'メロキシカム' & effect == 'K92'|
                                     cause == 'ラモトリギン' & effect == 'K71'|
                                     cause == 'リシノプリル' & effect == 'N17'|
                                     cause == 'リシノプリル' & effect == 'K71'|
                                     cause == 'レボフロキサシン' & effect == 'K71'|
                                     cause == '塩化カリウム' & effect == 'K92'|
                                     cause == '結合型エストロゲン' & effect == 'I21'
)


## MEMO ########################
# Negative controls
################################
CB_negative_15y <- subset(JMDC_ARM_15y_inspectdata, 
                                     cause == 'アデノシン三リン酸二ナトリウム水和物' & effect == 'K71'|
                                     cause == 'アデノシン三リン酸二ナトリウム水和物' & effect == 'K92'|
                                     cause == 'エポエチン　アルファ（遺伝子組換え）' & effect == 'K92'|
                                     cause == 'オキシブチニン塩酸塩' & effect == 'K71'|
                                     cause == 'オキシブチニン塩酸塩' & effect == 'I21'|
                                     cause == 'オキシブチニン塩酸塩' & effect == 'K92'|
                                     cause == 'ガチフロキサシン水和物' & effect == 'K71'|
                                     cause == 'ガチフロキサシン水和物' & effect == 'I21'|
                                     cause == 'グリセオフルビン' & effect == 'K71'|
                                     cause == 'クリンダマイシン塩酸塩' & effect == 'I21'|
                                     cause == 'ジサイクロミン塩酸塩' & effect == 'K71'|
                                     cause == 'ジサイクロミン塩酸塩' & effect == 'I21'|
                                     cause == 'ジサイクロミン塩酸塩' & effect == 'K92'|
                                     cause == 'シタグリプチンリン酸塩水和物' & effect == 'K71'|
                                     cause == 'シタグリプチンリン酸塩水和物' & effect == 'I21'|
                                     cause == 'シタグリプチンリン酸塩水和物' & effect == 'K92'|
                                     cause == 'スクラルファート水和物' & effect == 'K71'|
                                     cause == 'スクラルファート水和物' & effect == 'I21'|
                                     cause == 'スクラルファート水和物' & effect == 'K92'|
                                     cause == 'テルビナフィン塩酸塩' & effect == 'I21'|
                                     cause == 'テルビナフィン塩酸塩' & effect == 'K92'|
                                     cause == 'ピオグリタゾン塩酸塩' & effect == 'K92'|
                                     cause == 'ブチルスコポラミン臭化物' & effect == 'K71'|
                                     cause == 'ブチルスコポラミン臭化物' & effect == 'I21'|
                                     cause == 'ブチルスコポラミン臭化物' & effect == 'K92'|
                                     cause == 'プロクロルペラジンマレイン酸塩' & effect == 'I21'|
                                     cause == 'プロクロルペラジンマレイン酸塩' & effect == 'K92'|
                                     cause == 'ベンジルペニシリンベンザチン水和物' & effect == 'K71'|
                                     cause == 'ベンジルペニシリンベンザチン水和物' & effect == 'I21'|
                                     cause == 'ベンジルペニシリンベンザチン水和物' & effect == 'K92'|
                                     cause == 'メトカルバモール' & effect == 'I21'|
                                     cause == 'メトカルバモール' & effect == 'K92'|
                                     cause == 'ラクツロース' & effect == 'K71'|
                                     cause == 'ラクツロース' & effect == 'I21'|
                                     cause == 'ラクツロース' & effect == 'K92'|
                                     cause == 'ラメルテオン' & effect == 'I21'|
                                     cause == 'ロラタジン' & effect == 'N17'|
                                     cause == 'ロラタジン' & effect == 'I21'|
                                     cause == 'ロラタジン' & effect == 'K92'
)

# Remove tables
rm(ARM_TransactionData_15y); rm(JMDC_ARM_rules_15y); rm(JMDC_ARM_15y_inspectdata);


## MEMO #########################################################################
# 4. Conventional benchmark
#################################################################################
C_benchmark <- read_csv('C_benchmark.csv', col_names=TRUE, na=c("","NA", "NULL"))
colnames(C_benchmark)<-cbind('Drugname', 'ICD10', 'Ground_Truth')


## MEMO #########################################################################
# 5. Align digits
#################################################################################
CB_Summary_15y_pre <- rbind(CB_positive_15y, CB_negative_15y)

# The Fisher's exact test(less than 10 values)
CB_Summary_15y_pre1 <- data.frame(
                                  cbind(subset(CB_Summary_15y_pre, count < 10)[, 1:2], 
                                  subset(CB_Summary_15y_pre, count < 10)[, 6:7],
                                  subset(CB_Summary_15y_pre, count < 10)[, 8],
                                  subset(CB_Summary_15y_pre, count < 10)[, 11])
                                  )
colnames(CB_Summary_15y_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

CB_Summary_15y_pre2 <- data.frame(
                                  cbind(subset(CB_Summary_15y_pre, count >= 10)[, 1:2], 
                                  subset(CB_Summary_15y_pre, count >= 10)[, 6:7],
                                  subset(CB_Summary_15y_pre, count >= 10)[, 8],
                                  subset(CB_Summary_15y_pre, count >= 10)[, 10])
                                )
colnames(CB_Summary_15y_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_Summary_15y <- rbind(CB_Summary_15y_pre1, CB_Summary_15y_pre2)

# 5. Align digits
Result_Summary_15y <- cbind(Result_Summary_15y[, 1:2], 
                               round(Result_Summary_15y[, 3], 6), 
                               Result_Summary_15y[, 4],
                               round(Result_Summary_15y[, 5], 6),
                               Result_Summary_15y[, 6]
                              )
colnames(Result_Summary_15y) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

# Join the Conventional benchmark
Result_Summary_15y_CB <- CB_Golsta %>% 
                         left_join(Result_Summary_15y, by = c("Drugname" = "cause", "ICD10" = "effect")) %>% 
                         select(
                                Drugname, ICD10, Ground_Truth, 
                                lift, count, conviction, pValue
                                    )


# Export the result
csvname <- paste('Result_Summary_15y_CB.csv', sep=",")
write.csv(Result_Summary_15y_CB, csvname, row.names=FALSE)

# Remove tables
rm(CB_Golsta);
rm(CB_Summary_15y_pre); rm(CB_Summary_15y_pre1); rm(CB_Summary_15y_pre2); 
rm(CB_positive_15y); rm(CB_negative_15y); 


## MEMO #########################################################################
# 6. ARM-ROCCurve
#################################################################################
# Import the files
Result_Summary_15y_CB <- read_csv('Result_Summary_15y_CB.csv', col_names = TRUE, na=c("","NA", "NULL"))

# Calculate AUC values
ROC_ARMdata_15y <- cbind(Result_Summary_15y_CB[, 4], Result_Summary_15y_CB[, 3]) 
ROC_ARMdata_15y[is.na(ROC_ARMdata_15y)] <- 0      # Replace NA with 0
colnames(ROC_ARMdata_15y)<-cbind('ARM', 'Golsta')
ROC_ARM_15y <- roc(formula = Golsta ~ ARM, ROC_ARMdata_15y)
ROC_ARM_15y

# Visualize
setwd('~/Desktop')
pdf('ARM_ROCAUC_15y_CB.pdf')
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
pdf('JMDC_ARM_PRAUC_15y_CB.pdf')
plot(ARM_PRAUC_15y, xlab = "Recall", ylab = "Precision", col = 1, cex = 1, lty = 1, lwd = 5)
legend(x = 0.7, y = 0.25, bty = "n", lwd = 2, lty = 1, legend = c("15year"), col = 1, cex = 0.7)
legend(x = 0.8, y = 0.25, bty = "n", lty = 0, legend =c(round(ARM_PRAUC_15y$auc.integral, digits = 2)), col = 5, cex = 0.7)
dev.off()

# Remove tables
rm(pos_15y); rm(neg_15y); rm(ARM_PRAUC_15y)





