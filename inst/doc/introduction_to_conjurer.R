## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE, echo=TRUE---------------------------------------------------
#  install.packages("conjurer")

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
library(conjurer)
customers <- buildCust(numOfCust =  100)
print(head(customers))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
custNames <- as.data.frame(buildNames(numOfNames = 100, minLength = 5, maxLength = 7))

#set column heading
colnames(custNames) <- c("customerName")
print(head(custNames))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
customer2name <- cbind(customers, custNames)
#set column heading
print(head(customer2name))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
custAge <- as.data.frame(round(buildNum(n = 10, st = 23, en = 80, disp = 0.5, outliers = 1)))

#set column heading
colnames(custAge) <- c("customerAge")
print(head(custAge))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
customer2age <- cbind(customers, custAge)
#set column heading
print(head(customer2age))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
products <- buildProd(numOfProd = 10, minPrice = 5, maxPrice = 50)
print(head(products))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
transactions <- genTrans(cycles = "y", spike = 12, outliers = 1, transactions = 10000)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
TxnAggregated <- aggregate(transactions$transactionID, by = list(transactions$dayNum), length)
plot(TxnAggregated, type = "l", ann = FALSE)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
customer2transaction <- buildPareto(customers, transactions$transactionID, pareto = c(80,20))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
names(customer2transaction) <- c('transactionID', 'customer')

#inspect the output
print(head(customer2transaction))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
product2transaction <- buildPareto(products$SKU,transactions$transactionID,pareto = c(70,30))
names(product2transaction) <- c('transactionID', 'SKU')

#inspect the output
print(head(product2transaction))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
df1 <- merge(x = customer2transaction, y = product2transaction, by = "transactionID")

df2 <- merge(x = df1, y = transactions, by = "transactionID", all.x = TRUE)

#inspect the output
print(head(df2))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
df3 <- merge(x = df2, y = customer2name, by.x = "customer", by.y = "customers", all.x = TRUE)
df4 <- merge(x = df3, y = customer2age, by.x = "customer", by.y = "customers", all.x = TRUE)
df5 <- merge(x = df4, y = products, by = "SKU", all.x = TRUE)
dfFinal <- df5[,c("dayNum", "mthNum", "customer", "customerName", "customerAge", "SKU", "Price", "transactionID")]


#inspect the output
print(head(dfFinal))

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
aggregatedDataDay <- aggregate(dfFinal$transactionID, by = list(dfFinal$dayNum), length)
plot(aggregatedDataDay, type = "l", ann = FALSE)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
aggregatedDataMth <- aggregate(dfFinal$transactionID, by = list(dfFinal$mthNum), length)
aggregatedDataMthSorted <- aggregatedDataMth[order(aggregatedDataMth$Group.1),]
plot(aggregatedDataMthSorted, ann = FALSE)

