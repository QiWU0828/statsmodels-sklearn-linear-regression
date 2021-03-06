# Set working directory to where csv file is located
setwd("/home/michaeljgrogan/Documents/a_documents/computing/data science/datasets")

# Read the data
mydata<- read.csv("gasoline.csv")
attach(mydata)

df<-data.frame(consumption,capacity,price,hours)
attach(df)

train=head(df,32)
test=head(df,8)

# OLS regression - stock_return (dependent variable) and dividend + earnings + debt_to_equity (independent variables)
reg1 <- lm(consumption ~ capacity + price + hours, data=train)
summary(reg1)

plot(reg1)

#Install car library and regress independent variables
library(car)

#Variance Inflation Factor Test for multicollinearity
vif(reg1)

#Breusch-Pagan Test for Heteroscedasticity
library(lmtest)
bptest(reg1)

test_predict<-as.numeric(predict(reg1,test))
mse=(test_predict-test$consumption)/test$consumption
mse