## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE, echo=TRUE----------------------------------------------
#  install.packages("conjurer")

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
library(conjurer)
customers <- buildCust(numOfCust =  100)
print(head(customers))

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
products <- buildProd(numOfProd = 10, minPrice = 5, maxPrice = 50)
print(head(products))

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
transactions <- genTrans(cycles = "y", spike = 12, outliers = 1, transactions = 10000)

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
TxnAggregated <- aggregate(transactions$transactionID, by = list(transactions$dayNum), length)
plot(TxnAggregated, type = "l", ann = FALSE)

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
customer2transaction <- buildPareto(customers, transactions$transactionID, pareto = c(80,20))

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
names(customer2transaction) <- c('transactionID', 'customer')

#inspect the output
print(head(customer2transaction))

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
product2transaction <- buildPareto(products$SKU,transactions$transactionID,pareto = c(70,30))
names(product2transaction) <- c('transactionID', 'SKU')

#inspect the output
print(head(product2transaction))

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
df1 <- merge(x = customer2transaction, y = product2transaction, by = "transactionID")

dfFinal <- merge(x = df1, y = transactions, by = "transactionID", all.x = TRUE)

#inspect the output
print(head(dfFinal))

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
aggregatedDataDay <- aggregate(dfFinal$transactionID, by = list(dfFinal$dayNum), length)
plot(aggregatedDataDay, type = "l", ann = FALSE)

## ---- eval=TRUE, echo=TRUE, results='markup'-----------------------------
aggregatedDataMth <- aggregate(dfFinal$transactionID, by = list(dfFinal$mthNum), length)
aggregatedDataMthSorted <- aggregatedDataMth[order(aggregatedDataMth$Group.1),]
plot(aggregatedDataMthSorted, ann = FALSE)

