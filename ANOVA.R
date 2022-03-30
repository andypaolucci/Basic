
#Read CSV
Elevation <-read.csv(file = 'E:/URI/MastersThesis/Data/SaltMarsh/Ditching/Manuscript_Files4Stats/Elevation4stats.csv')
str(Elevation)

Ipswich.Elev <-read.csv(file = 'E:/URI/MastersThesis/Data/SaltMarsh/Ditching/Manuscript_Files4Stats/IpswichElevation.csv')
Matunuck.Elev <-read.csv(file = 'E:/URI/MastersThesis/Data/SaltMarsh/Ditching/Manuscript_Files4Stats/MatunuckElevation.csv')
str(Ipswich.Elev)

#T-Test Matunuck vs Ipswich
t.test(cm ~ Soil, data=Elevation, var.equal=TRUE, conf.level=0.95)



#ANOVA Ipswich
anova2 <- aov(cm~Distance..m., data=Matunuck.Elev)
summary(anova2)
pairwise.t.test(Matunuck.Elev$cm, Matunuck.Elev$Site, p.adj="none")

#Check for normality 
res<-anova2$residuals
hist(res, main="Histogram of residuals", xlab="Residuals")

#Check for equal variance
library(car)
leveneTest(Total.Species.Richness~Soil*Cover.Type, data=upland.richness)

summary(anova2)


# Tree Species
#ANOVA
anova3 <- aov(Tree.Species~Soil*Cover.Type, data=upland.richness)

#Check for normality 
res<-anova3$residuals
hist(res, main="Histogram of residuals", xlab="Residuals")

#Check for equal variance
library(car)
leveneTest(Tree.Species~Soil*Cover.Type, data=upland.richness)

summary(anova3)


# Shrub Species
#ANOVA
anova4 <- aov(Shrub.Species~Soil*Cover.Type, data=upland.richness)

#Check for normality 
res<-anova4$residuals
hist(res, main="Histogram of residuals", xlab="Residuals")

#Check for equal variance
library(car)
leveneTest(Shrub.Species~Soil*Cover.Type, data=upland.richness)

summary(anova4)


# Forb Species
#ANOVA
anova5 <- aov(Forb.Species~Soil*Cover.Type, data=upland.richness)

#Check for normality 
res<-anova5$residuals
hist(res, main="Histogram of residuals", xlab="Residuals")

#Check for equal variance
library(car)
leveneTest(Forb.Species~Soil*Cover.Type, data=upland.richness)

summary(anova5)


# Graminoid Species
#ANOVA
anova6 <- aov(Graminoid.Species~Soil*Cover.Type, data=upland.richness)

#Check for normality 
res<-anova6$residuals
hist(res, main="Histogram of residuals", xlab="Residuals")

#Check for equal variance
library(car)
leveneTest(Graminoid.Species~Soil*Cover.Type, data=upland.richness)

summary(anova6)

TukeyHSD(anova2)

