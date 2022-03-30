install.packages("dplyr")
library(dplyr)

#read CSV
HSG <- read.csv(file="C:/Paolucci/Projects/HSG/HSG.csv")

#Get column names using head()
head(HSG)

#Information about boxplot function
?boxplot()

#Plot box plot using min soil moist depth
boxplot(min_soimoistdept_r~hydgrp, data=HSG, main="HSG Minimum soil moisture depth", xlab="HSG", ylab="minimum soil moisture depth (cm)")

#Plot box plot using restriction depth 
boxplot(resdept_r~hydgrp, data=HSG, main="HSG Restriction Depth", xlab="HSG", ylab="Restriction depth (cm)")

#Plot box plot using min_ks
boxplot(min_ks~hydgrp, data=HSG, main="HSG min_ks", xlab="HSG", ylab="min_ks")



# this code below shows example of how to subset data. In the example I subset the HSG D soil in Wisconsin and Maine.
#Subset HSG D soils in Wisconsin and Maine. A new dataframe (table) is created called HSG_D
HSG_D <-dplyr::filter(HSG, hydgrp == "D" & State ==c("WI", "ME"))

#Remove unwanted levels for plotting. If you dont do this the plot will have every state on the X axis instead of just WI and ME
HSG_D$State<- factor(HSG_D_test$State)

#Plot boxplot with subset data
boxplot(min_soimoistdept_r~State, data=HSG_D_subset, main="HSG D Minimum soil moisture depth", xlab="State", ylab="minimum soil moisture depth (cm)")



