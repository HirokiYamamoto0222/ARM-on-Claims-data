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
# "TTO_JMDC_ARM_1month.csv" is pre-created in "4_ARM_Early detection.R"
# "TTO_JMDC_ARM_3months.csv" is pre-created in "4_ARM_Early detection.R"
# "TTO_JMDC_ARM_6months.csv" is pre-created in "4_ARM_Early detection.R"


## MEMO ###################################################################
# 2. Association rule mining
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
TTO_positive_1month_CB <- subset(TTO_JMDC_ARM_inspectdata_1month, 
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

# The Fisher's exact test(less than 10 values)
Result_positive_pre1 <- data.frame(
                                    cbind(subset(TTO_positive_1month_CB, count < 10)[, 1:2], 
                                    subset(TTO_positive_1month_CB, count < 10)[, 6:7],
                                    subset(TTO_positive_1month_CB, count < 10)[, 8],
                                    subset(TTO_positive_1month_CB, count < 10)[, 11])
                                    )
colnames(Result_positive_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_positive_pre2 <- data.frame(
                                    cbind(subset(TTO_positive_1month_CB, count >= 10)[, 1:2], 
                                    subset(TTO_positive_1month_CB, count >= 10)[, 6:7], 
                                    subset(TTO_positive_1month_CB, count >= 10)[, 8], 
                                    subset(TTO_positive_1month_CB, count >= 10)[, 10])
                                  )
colnames(Result_positive_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_positive_1month_re <- rbind(Result_positive_pre1, Result_positive_pre2)

# Align digits
TTO_positive_1month_re <- cbind(TTO_positive_1month_re[, 1:2], 
                                   round(TTO_positive_1month_re[, 3], 6), 
                                   TTO_positive_1month_re[, 4],
                                   round(TTO_positive_1month_re[, 5], 6),
                                   TTO_positive_1month_re[, 6])
colnames(TTO_positive_1month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

csvname <- paste('TTO_positive_1month_CB.csv', sep = ",")
write.csv(TTO_positive_1month_re, csvname, row.names = FALSE)


############## 
# 3months
TTO_positive_3months_CB <- subset(TTO_JMDC_ARM_inspectdata_3months, 
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

# The Fisher's exact test(less than 10 values)
Result_positive_pre1 <- data.frame(
                                    cbind(subset(TTO_positive_3months_CB, count < 10)[, 1:2], 
                                    subset(TTO_positive_3months_CB, count < 10)[, 6:7],
                                    subset(TTO_positive_3months_CB, count < 10)[, 8],
                                    subset(TTO_positive_3months_CB, count < 10)[, 11])
                                  )
colnames(Result_positive_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_positive_pre2 <- data.frame(
                                    cbind(subset(TTO_positive_3months_CB, count >= 10)[, 1:2], 
                                    subset(TTO_positive_3months_CB, count >= 10)[, 6:7], 
                                    subset(TTO_positive_3months_CB, count >= 10)[, 8], 
                                    subset(TTO_positive_3months_CB, count >= 10)[, 10])
                                    )
colnames(Result_positive_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_positive_3month_re <- rbind(Result_positive_pre1, Result_positive_pre2)

# Align digits
TTO_positive_3month_re <- cbind(TTO_positive_3month_re[, 1:2], 
                                   round(TTO_positive_3month_re[, 3], 6), 
                                   TTO_positive_3month_re[, 4],
                                   round(TTO_positive_3month_re[, 5], 6),
                                   TTO_positive_3month_re[, 6])
colnames(TTO_positive_3month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')


csvname <- paste('TTO_positive_3months_CB.csv', sep = ",")
write.csv(TTO_positive_3month_re, csvname, row.names = FALSE)


############## 
# 6months
TTO_positive_6months_CB <- subset(TTO_JMDC_ARM_inspectdata_6months, 
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

# The Fisher's exact test(less than 10 values)
Result_positive_pre1 <- data.frame(
                                    cbind(subset(TTO_positive_6months_CB, count < 10)[, 1:2], 
                                    subset(TTO_positive_6months_CB, count < 10)[, 6:7],
                                    subset(TTO_positive_6months_CB, count < 10)[, 8],
                                    subset(TTO_positive_6months_CB, count < 10)[, 11])
                                  )
colnames(Result_positive_pre1) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

Result_positive_pre2 <- data.frame(
                                    cbind(subset(TTO_positive_6months_CB, count >= 10)[, 1:2], 
                                    subset(TTO_positive_6months_CB, count >= 10)[, 6:7], 
                                    subset(TTO_positive_6months_CB, count >= 10)[, 8], 
                                    subset(TTO_positive_6months_CB, count >= 10)[, 10])
                                  )
colnames(Result_positive_pre2) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

TTO_positive_6month_re <- rbind(Result_positive_pre1, Result_positive_pre2)

# Align digits
TTO_positive_6month_re <- cbind(TTO_positive_6month_re[, 1:2], 
                                   round(TTO_positive_6month_re[, 3], 6), 
                                   TTO_positive_6month_re[, 4],
                                   round(TTO_positive_6month_re[, 5], 6),
                                   TTO_positive_6month_re[, 6])
colnames(TTO_positive_6month_re) <- cbind('cause', 'effect', 'lift', 'count', 'conviction', 'pValue')

csvname <- paste('TTO_positive_6months_CB.csv', sep = ",")
write.csv(TTO_positive_6month_re, csvname, row.names = FALSE)


