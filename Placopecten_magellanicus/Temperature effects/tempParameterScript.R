
# Temperatures effecs on Sea Scallops
# Estimate parameters for Sea Scallop DEB

library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
library(zoo)
library(viridis)
library(nls2)
library(dplyr)
library(ncdf4)
library(sf)
library(colorRamps)

setwd("/Users/thomaskiffney/Desktop/parameterEstimation")

rm(list=ls())

################ Estimate Arrhenius Temp ###############################

dataTA = read.csv("/Users/thomaskiffney/Desktop/parameterEstimation/DEB_school/Sea scallop/temperature effects/TA_tempData.csv")

# convert to Kelvin and take ln of rates
dataTA = dataTA %>% 
  mutate(temp_k = temp_c + 273,
         inverseTemp = 1/temp_k,
         lnRate = log(Rate))

# Linear regressions for 1/temp and ln(rate)
a = filter(dataTA, ID == "a")
lmA = lm(a$lnRate ~ a$inverseTemp)
b = filter(dataTA, ID == "b")
lmB = lm(b$lnRate ~ b$inverseTemp)
c = filter(dataTA, ID == "c")
lmC = lm(c$lnRate ~ c$inverseTemp)
d = filter(dataTA, ID == "d")
lmD = lm(d$lnRate ~ d$inverseTemp)
e = filter(dataTA, ID == "e")
lmE = lm(e$lnRate ~ e$inverseTemp)
f = filter(dataTA, ID == "f")
lmF = lm(f$lnRate ~ f$inverseTemp)

# Average the slope from all the regressions
Ta = c(abs(lmA$coefficients[2]), 
       abs(lmB$coefficients[2]),
       abs(lmC$coefficients[2]),
       abs(lmD$coefficients[2]),
       abs(lmE$coefficients[2]),
       abs(lmF$coefficients[2]))

meanTa = mean(Ta)
sdTa = sd(Ta)

# Mean TA = 6781 with a standard deviation of 1149

# Plot the regressions
plot(a$inverseTemp, a$lnRate,
     ylim = c(-4, 5),
     pch = 16,
     ylab = "ln(rate)",
     xlab = "1/temperature (k)")
abline(lmA)
points(b$inverseTemp, b$lnRate, pch = 17)
abline(lmB)
points(c$inverseTemp, c$lnRate, pch = 0)
abline(lmC)
points(d$inverseTemp, d$lnRate, pch = 15)
abline(lmD)
points(e$inverseTemp, e$lnRate, pch = 6)
abline(lmE)
points(f$inverseTemp, f$lnRate, pch = 24)
abline(lmF)
legend("topright", "Arrhenius temperature: 6781 (+/- 1149)", bty = "n")

########################### Estimate full Arrhenius equation ######################

growthRates = read.csv("/Users/thomaskiffney/Desktop/parameterEstimation/DEB_school/Sea scallop/temperature effects/GrowthRates_ColeKiff2021.csv")

# extra columns were loaded, remove
growthRates = select(growthRates, Author, OISST_Temp_new, ShellHeightGrowth, ShellHeight)

# no rates at 20 C to use as a reference temperature, use 15 instead
refTemp = growthRates %>% 
  filter(OISST_Temp_new > 14.5,
         OISST_Temp_new < 16.5)

plot(refTemp$OISST_Temp_new, refTemp$ShellHeightGrowth)
refTemp = mean(refTemp$ShellHeightGrowth)

# Divide rates by rate at reference temp
growthRates$TC = growthRates$ShellHeightGrowth / refTemp
growthRates$tempk = growthRates$OISST_Temp_new + 273

# plot
ggplot(growthRates, aes(x = OISST_Temp_new, y = TC, color = Author)) +
  geom_point() +
  ylab("Shell Growth Rate (mm/day)") +
  xlab("OISST Temperature (C)") +
  xlim(0,20) +
  theme_classic()

## Attemped to fit the full equation, but it was over paramatized, fit the upper and lower section seperately

# Visually fit parameters to data to find starting points

temp = seq(0, 20, by = 0.5)
temp = temp + 273
TC = vector(mode = "numeric", length = length(temp))

for (i in 1:length(temp)) {
  
  # T_ref   = 273 +  15    #   K, reference temperature
  # T_H     = 273 +  15    #   K, upper boundary tolerance range
  # T_L     = 273 +  4    #   K, lower boundary tolerance range
  # T_A     =  6781        #   K, Arrehnius temperature
  # T_AL    =  13852       #   K, Arrehnius temperature at lower boundary of tolerance range
  # T_AH    =  46075        #   K, Arrehnius temperature at upper boundary of tolerance range 
  
  TC[i] = exp(T_A / T_ref - T_A / temp[i]) * ((1 + exp(T_AL / T_ref - T_AL / T_L) + exp(T_AH / T_H - T_AH / T_ref)) / (1 + exp(T_AL / temp[i] - T_AL / T_L) + exp(T_AH / T_H - T_AH / temp[i])))
  
}


plot(growthRates$OISST_Temp, growthRates$TC,
     xlim = c(0,20),
     ylab = "TC",
     xlab = "Temp")
lines(temp-273, TC, col = "red", lwd = 2)

#### two part nls regression ####
# Keep T_A values from earlier

# Filter to only important data
TCdata = growthRates %>% 
  select(TC, OISST_Temp_new, tempk)

# Make function for arrhenius equation

arrhenius = function(TA, TH, TL, TAH, TAL, Tref, t) {
  
  exp(TA/Tref - TA/t) * ((1 + exp(TAL/Tref - TAL/TL) + exp(TAH/TH - TAH/Tref)) / (1 + exp(TAL/t - TAL/TL) + exp(TAH/TH - TAH/t)))
  
}

# Lower temp parameter regression

lownls = nls(TC ~  arrhenius(TA = 6781, TH = 288, TL, TAH= 46075, TAL, Tref = 288, t = tempk), 
              data = TCdata,
              start = c(TL = 277, 
                        TAL = 15852),
              trace = TRUE)

lownls

## Resutls
# TL = 277
# TAL = 19350

# Sub in results and estimate upper parameters
highnls = nls(TC ~  arrhenius(TA = 6781, TH, TL = 277, TAH, TAL = 19350, Tref = 288, t = tempk), 
             data = TCdata,
             start = c(TH = 288, 
                       TAH = 46075),
             trace = TRUE)

highnls

## Results
# TH = 288
# TAH = 61891

# View final parameters

temp = seq(0, 20, by = 0.5)
temp = temp + 273
TC = vector(mode = "numeric", length = length(temp))

for (i in 1:length(temp)) {
  
  # T_ref   = 288          #   K, reference temperature
  # T_H     = 288          #   K, upper boundary tolerance range
  # T_L     = 277          #   K, lower boundary tolerance range
  # T_A     =  6781        #   K, Arrehnius temperature
  # T_AL    =  19350       #   K, Arrehnius temperature at lower boundary of tolerance range
  # T_AH    =  61891       #   K, Arrehnius temperature at upper boundary of tolerance range 
  
  TC[i] = exp(T_A / T_ref - T_A / temp[i]) * ((1 + exp(T_AL / T_ref - T_AL / T_L) + exp(T_AH / T_H - T_AH / T_ref)) / (1 + exp(T_AL / temp[i] - T_AL / T_L) + exp(T_AH / T_H - T_AH / temp[i])))
  
}

plot(growthRates$OISST_Temp, growthRates$TC,
     xlim = c(0,20),
     ylab = "Temperature correction factor",
     xlab = "Temp (C)")
lines(temp-273, TC, col = "red", lwd = 2)
