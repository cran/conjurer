## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
#invoke library
library("conjurer")

set.seed(123)
continuousData <- buildNum(n = 10, st = 0, en = 1, disp = (pi/3), outliers = 0)
continuousDataOutlier <- buildNum(n = 10, st = 0, en = 1, disp = (pi/3), outliers = 1)
par(mfrow=c(1,2)) 
plot(continuousData)
plot(continuousDataOutlier)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
#invoke library
library("conjurer")

set.seed(123)
buildNames(numOfNames = 3, minLength = 5, maxLength = 7)

d <- data.frame (first_column  = c("ATGACGAGAGAGAGCA", "ATGACGAGAGAGCAGAGA","TACTGCTCTCTCGTAAATCG"))
buildNames(dframe=d, numOfNames = 3, minLength = 5, maxLength = 5)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
#invoke library
library("conjurer")

buildId(numOfItems = 3, prefix = "specID")

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
#invoke library
library("conjurer")

set.seed(123)
parts <- list(c(172),c("."),c(16:31), c("."), c(0:255), c("."), c(0:255))
probs <- list(c(), c(),c(),c(), c(), c(), c())
buildPattern(n=5,parts = parts, probs = probs)

parts <- list(c("+11","+44","+64"), c("-"), c(491,324,211), c(7821:8324))
probs <- list(c(0.25,0.25,0.50), c(), c(0.30,0.60,0.10), c())
buildPattern(n=5,parts = parts, probs = probs)

## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
#invoke library
library("conjurer")

buildHierarchy(splits = 2, numOfLevels = 3)


## ---- eval=TRUE, echo=TRUE, results='markup'----------------------------------
#invoke library
library("conjurer")
set.seed(123)
f1 <- factor(c(1:10))
f2 <- factor(letters[1:12], labels = "f")

buildPareto(factor1 = f1, factor2 = f2, pareto = c(70,30))


