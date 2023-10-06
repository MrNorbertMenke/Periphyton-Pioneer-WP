
########################################################################################################
########################################################################################################

#WP Environmental Risk Assessments
# 3 WP Scenario Comparison of Pioneer Periphyton habitat: 
# Significance of difference of average seasonal habitat values per site
# 2023-09-20  by NM

########################################################################################################
########################################################################################################

#Quick introduction

# The summary bar chart ( 2023-02-14 Periphyton summary stats & figs.R ) shows differences between the 
# pre-development (PD) and full entitlement FE scenarios. Are these differences statistically significant?

# Objectives: Determine statistical significance of scenario outcomes.
# 1 What is the statistical probability density distribution of 
#  a) Producing q-q plots for visual assessment of distribution (finding zero inflagion for example)
#  b) the habitat data per site, season and scenario?
#  c) the difference between scenarios per site and season?
# 2 Is there a statistical difference between scenarios using the t-test (for normally distributed paired data)
# 3 Is there a statistical difference between scenarios using the Wilcoxon's signed rank test for paired data
# 4 Is there a statistical difference between scenarios using the Kruskal-Wallis test for paired data


######################
#Data type

#The eco risk projector output should be a long data format (.csv) and contains the following columns.
#Note: column titles are case sensitive.
#1st column - Year (categorical) (1889 - 2018, beginning year of financial years winter to winter)
#2nd column - Season (categorical) (Jan-Mar, Apr-Jun, Jul-Sep, Oct-Dec)
#3rd column - Site (categorical) (s1 - s4)
#4th column - Scenario (categorical) (PD, FE)
#5th column - Habitat (continuous) (width of stream cross-section, in m)


######################
#Required input(s) / Data prepping and formatting

#1 Current input data location: 
#  C:\WP Pioneer\data\Periphyton\Results\Pioneer.Periphyton.Scenario.Comparison.ALL.RESULTS.xlsm"
#  The original data was processed via pivot table operation in Excel, then manually formatted as flat files for use in R.
#  "C:\github.c\Periphyton\data\2023-09-15_Pioneer_Periphyton_dat.csv"
#2 Bar plots showing the mean periphyton habitat (m) per quarter by site (.tiff) from 
#  "2023-02-14 Periphyton summary stats & figs.R".

# Note: for each sample location, mean periphyton habitat (m) will be calculated per quarter over 
# a 130yr period under PD and FE flow regime simulation scenarios, 
# The associated bar plots show the longterm site x seasonal x annual x scenario averages as bar plots
# with error bars.
# So each sample consists of 130 annual records

########################################################################################################

#Outputs
#All significance testing of comparison of habitat data to be stored in ..\results\Pioneer.Scenario.SIGNIFICANCE.Tests.xlsx

########################################################################################################


#Record start time
start.time <- Sys.time()

#Call packages

# install.packages("ggpubr")

require("ggpubr")
library(ggpubr)


# Set the working directory
setwd("C:/github.c/Periphyton")  # ***REVISIT ONCE UPLOADED TO GIT-HUB

# Load data & history from previous session
load("C:/github.c/Periphyton/SigTestMeans code.Pioneer.RData")
# LOAD HISTORY VIA File>Open File ..

# Get the data - needs to be data.frame!
  S1 <- data.frame(read.csv("./data/PioneerS1.csv", header = TRUE))
  S2 <- data.frame(read.csv("./data/PioneerS2.csv", header = TRUE))
  S3 <- data.frame(read.csv("./data/PioneerS3.csv", header = TRUE))
  S4 <- data.frame(read.csv("./data/PioneerS4.csv", header = TRUE))

# check that the import produced a data frame
  head(S1)  # how is top of file
  str(S1)   # variable types

# DATA PLOTTING AND EXPLORATION
# DATA PLOTTING AND EXPLORATION
# IS THE DATA NORMALLY DISTRIBUTED (ETC)?
  
  #PLOT ALL HISTOGRAMS PER SEASON

  detach(S1)  # overcomes the problem with " 'x' must be numeric  "
  detach(S2)  
  detach(S3)  
  detach(S4)  
  
  
  attach(S1)  # overcomes the problem with " 'x' must be numeric  "
  attach(S2)  
  attach(S3)  
  attach(S4)  

  # PRODUCE PANEL CHARTS OF HISTOGRAMS
  # 1. Open jpeg file
  jpeg("histS1.jpg", width = 700, height = 1760)
  # 2. Create the plot
  par(mfrow=c(4,2))
  hist(S1Avg.GAR.PD)	
  hist(S1Avg.MIR.PD)	
  hist(S1Avg.SAR.PD)	
  hist(S1Avg.WHI.PD)	
  hist(S1Avg.GAR.FE)	
  hist(S1Avg.MIR.FE)	
  hist(S1Avg.SAR.FE)	
  hist(S1Avg.WHI.FE)	
  # 3. Close the file
  dev.off()
  
  # 1. Open jpeg file
  jpeg("histS2.jpg", width = 700, height = 1760)
  # 2. Create the plot
  par(mfrow=c(5,2))
  hist(S2Avg.GAR.PD)	
  hist(S2Avg.MIR.PD)	
  hist(S2Avg.SAR.PD)	
  hist(S2Avg.WHI.PD)	
  hist(S2Avg.GAR.FE)	
  hist(S2Avg.MIR.FE)	
  hist(S2Avg.SAR.FE)	
  hist(S2Avg.WHI.FE)	
  # 3. Close the file
  dev.off()
  
  # 1. Open jpeg file
  jpeg("histS3.jpg", width = 700, height = 1760)
  # 2. Create the plot
  par(mfrow=c(5,2))
  hist(S3Avg.GAR.PD)	
  hist(S3Avg.MIR.PD)	
  hist(S3Avg.SAR.PD)	
  hist(S3Avg.WHI.PD)	
  hist(S3Avg.GAR.FE)	
  hist(S3Avg.MIR.FE)	
  hist(S3Avg.SAR.FE)	
  hist(S3Avg.WHI.FE)	
  # 3. Close the file
  dev.off()
  
  # 1. Open jpeg file
  jpeg("histS4.jpg", width = 700, height = 1760)
  # 2. Create the plot
  par(mfrow=c(4,2))
  hist(S4Avg.GAR.PD)	
  hist(S4Avg.MIR.PD)	
  hist(S4Avg.SAR.PD)	
  hist(S4Avg.WHI.PD)	
  hist(S4Avg.GAR.FE)	
  hist(S4Avg.MIR.FE)	
  hist(S4Avg.SAR.FE)	
  hist(S4Avg.WHI.FE)	
  # 3. Close the file
  dev.off()
  
  
# VISUAL ASSESSMENT FOR NORMAL (OR OTHERWISE) DISTRIBUTION OF ANNUAL AVG HABITAT DATA
# normal Q-Q Plot
# PRODUCE PANEL CHARTS OF Q-Q PLOTS (ADDITIONAL ASSESSMENT OF PROBABILITY DISTRIBUTIONS)
# (SEE https://arc.lib.montana.edu/book/statistics-with-r-textbook/item/57#main%3D%22Histogram%20of%20residuals%22 
#  and https://stats.stackexchange.com/questions/101274/how-to-interpret-a-qq-plot )
  
    par(mfrow=c(2,4))
  
  qqnorm(S1$S1Avg.GAR.PD, pch = 1, frame = FALSE,main="S1Avg.GAR.PD")
  qqnorm(S1$S1Avg.MIR.PD, pch = 1, frame = FALSE,main="S1Avg.MIR.PD")
  qqnorm(S1$S1Avg.SAR.PD, pch = 1, frame = FALSE,main="S1Avg.SAR.PD")
  qqnorm(S1$S1Avg.WHI.PD, pch = 1, frame = FALSE,main="S1Avg.WHI.PD")
  qqnorm(S1$S1Avg.GAR.FE, pch = 1, frame = FALSE,main="S1Avg.GAR.FE")
  qqnorm(S1$S1Avg.MIR.FE, pch = 1, frame = FALSE,main="S1Avg.MIR.FE")
  qqnorm(S1$S1Avg.SAR.FE, pch = 1, frame = FALSE,main="S1Avg.SAR.FE")
  qqnorm(S1$S1Avg.WHI.FE, pch = 1, frame = FALSE,main="S1Avg.WHI.FE")
  
  par(mfrow=c(2,4))
  
  qqnorm(S2$S2Avg.GAR.PD, pch = 1, frame = FALSE,main="S2Avg.GAR.PD")
  qqnorm(S2$S2Avg.MIR.PD, pch = 1, frame = FALSE,main="S2Avg.MIR.PD")
  qqnorm(S2$S2Avg.SAR.PD, pch = 1, frame = FALSE,main="S2Avg.SAR.PD")
  qqnorm(S2$S2Avg.WHI.PD, pch = 1, frame = FALSE,main="S2Avg.WHI.PD")
  qqnorm(S2$S2Avg.GAR.FE, pch = 1, frame = FALSE,main="S2Avg.GAR.FE")
  qqnorm(S2$S2Avg.MIR.FE, pch = 1, frame = FALSE,main="S2Avg.MIR.FE")
  qqnorm(S2$S2Avg.SAR.FE, pch = 1, frame = FALSE,main="S2Avg.SAR.FE")
  qqnorm(S2$S2Avg.WHI.FE, pch = 1, frame = FALSE,main="S2Avg.WHI.FE")
  
  par(mfrow=c(2,4))
  
  qqnorm(S3$S3Avg.GAR.PD, pch = 1, frame = FALSE,main="S3Avg.GAR.PD")
  qqnorm(S3$S3Avg.MIR.PD, pch = 1, frame = FALSE,main="S3Avg.MIR.PD")
  qqnorm(S3$S3Avg.SAR.PD, pch = 1, frame = FALSE,main="S3Avg.SAR.PD")
  qqnorm(S3$S3Avg.WHI.PD, pch = 1, frame = FALSE,main="S3Avg.WHI.PD")
  qqnorm(S3$S3Avg.GAR.FE, pch = 1, frame = FALSE,main="S3Avg.GAR.FE")
  qqnorm(S3$S3Avg.MIR.FE, pch = 1, frame = FALSE,main="S3Avg.MIR.FE")
  qqnorm(S3$S3Avg.SAR.FE, pch = 1, frame = FALSE,main="S3Avg.SAR.FE")
  qqnorm(S3$S3Avg.WHI.FE, pch = 1, frame = FALSE,main="S3Avg.WHI.FE")
  
  # Comment: number of "0"-habitat values from Jul-Dec produce non-normal data distributions
  
  par(mfrow=c(2,4))
  
  qqnorm(S4$S4Avg.GAR.PD, pch = 1, frame = FALSE,main="S4Avg.GAR.PD")
  qqnorm(S4$S4Avg.MIR.PD, pch = 1, frame = FALSE,main="S4Avg.MIR.PD")
  qqnorm(S4$S4Avg.SAR.PD, pch = 1, frame = FALSE,main="S4Avg.SAR.PD")
  qqnorm(S4$S4Avg.WHI.PD, pch = 1, frame = FALSE,main="S4Avg.WHI.PD")
  qqnorm(S4$S4Avg.GAR.FE, pch = 1, frame = FALSE,main="S4Avg.GAR.FE")
  qqnorm(S4$S4Avg.MIR.FE, pch = 1, frame = FALSE,main="S4Avg.MIR.FE")
  qqnorm(S4$S4Avg.SAR.FE, pch = 1, frame = FALSE,main="S4Avg.SAR.FE")
  qqnorm(S4$S4Avg.WHI.FE, pch = 1, frame = FALSE,main="S4Avg.WHI.FE")
  
  # Comment: same as for S3 (Jul-Sep), fairly right-skewed, due to quantity of "0"-habitat values  
  
  # THE DATA (HERE) DOES NOT LOOK NORMALLY DISTRIBUTED! 
  # THE DATA (HERE) DOES NOT LOOK NORMALLY DISTRIBUTED! 

  # TESTING FOR NORMAL DISTRIBUTION
  # SHAPIRO.TEST TO TEST FOR NORMAL DISTRIBUTION OF DATA
  # TESTING FOR INDIVIDUAL SAMPLE NORMALITY 
  
  shaptst00 <- shapiro.test(S1Avg.GAR.PD)$p.value
  shaptst01 <- shapiro.test(S1Avg.MIR.PD)$p.value	
  shaptst02 <- shapiro.test(S1Avg.SAR.PD)$p.value	
  shaptst03 <- shapiro.test(S1Avg.WHI.PD)$p.value	
  shaptst04 <- shapiro.test(S1Avg.GAR.FE)$p.value	
  shaptst05 <- shapiro.test(S1Avg.MIR.FE)$p.value	
  shaptst06 <- shapiro.test(S1Avg.SAR.FE)$p.value	
  shaptst07 <- shapiro.test(S1Avg.WHI.FE)$p.value	
  shaptst08 <- shapiro.test(S2Avg.GAR.PD)$p.value	
  shaptst09 <- shapiro.test(S2Avg.MIR.PD)$p.value	
  shaptst10 <- shapiro.test(S2Avg.SAR.PD)$p.value	
  shaptst11 <- shapiro.test(S2Avg.WHI.PD)$p.value	
  shaptst12 <- shapiro.test(S2Avg.GAR.FE)$p.value	
  shaptst13 <- shapiro.test(S2Avg.MIR.FE)$p.value	
  shaptst14 <- shapiro.test(S2Avg.SAR.FE)$p.value	
  shaptst15 <- shapiro.test(S2Avg.WHI.FE)$p.value
  shaptst16 <- shapiro.test(S3Avg.GAR.PD)$p.value	
  shaptst17 <- shapiro.test(S3Avg.MIR.PD)$p.value	
  shaptst18 <- shapiro.test(S3Avg.SAR.PD)$p.value	
  shaptst19 <- shapiro.test(S3Avg.WHI.PD)$p.value	
  shaptst20 <- shapiro.test(S3Avg.GAR.FE)$p.value	
  shaptst21 <- shapiro.test(S3Avg.MIR.FE)$p.value	
  shaptst22 <- shapiro.test(S3Avg.SAR.FE)$p.value	
  shaptst23 <- shapiro.test(S3Avg.WHI.FE)$p.value	
  shaptst24 <- shapiro.test(S4Avg.GAR.PD)$p.value	
  shaptst25 <- shapiro.test(S4Avg.MIR.PD)$p.value	
  shaptst26 <- shapiro.test(S4Avg.SAR.PD)$p.value	
  shaptst27 <- shapiro.test(S4Avg.WHI.PD)$p.value	
  shaptst28 <- shapiro.test(S4Avg.GAR.FE)$p.value	
  shaptst29 <- shapiro.test(S4Avg.MIR.FE)$p.value	
  shaptst30 <- shapiro.test(S4Avg.SAR.FE)$p.value	
  shaptst31 <- shapiro.test(S4Avg.WHI.FE)$p.value	
  
  #combine p.values for export & reporting

# WORKS, PRODUCES PD / FE pairs
# WORKING! PRODUCES 2 X 16 MATRIX OF SHAPIRO TEST RESULTS (MANUALLY MATCHED VECTORS FOR COMPARISON)
  Pioneer.shap.test.summary <- matrix(c(shaptst00,shaptst04,
                                            shaptst01,shaptst05,
                                            shaptst02,shaptst06,
                                            shaptst03,shaptst07,
                                            shaptst08,shaptst12,
                                            shaptst09,shaptst13,
                                            shaptst10,shaptst14,
                                            shaptst11,shaptst15,
                                            shaptst16,shaptst20,
                                            shaptst17,shaptst21,
                                            shaptst18,shaptst22,
                                            shaptst19,shaptst23,
                                            shaptst24,shaptst28,
                                            shaptst25,shaptst29,
                                            shaptst26,shaptst30,
                                            shaptst27,shaptst31)
                                          ,ncol=16, byrow=FALSE)

# CHECK THAT FE VALUES FOR EACH SITE * SEASON ARE BELOW PD IN TABLE!
    
#EXPORT FOR REPORTING
write.csv(Pioneer.shap.test.summary, file = "c:/github.c/Periphyton/results/Pioneer.shapiro.test.csv")
                                      

# testing for sample normality of the difference

shaptst01diff <- shapiro.test(S1Avg.GAR.PD-S1Avg.GAR.FE)$p.value	
shaptst02diff <- shapiro.test(S1Avg.MIR.PD-S1Avg.MIR.FE)$p.value	
shaptst03diff <- shapiro.test(S1Avg.SAR.PD-S1Avg.SAR.FE)$p.value	
shaptst04diff <- shapiro.test(S1Avg.WHI.PD-S1Avg.WHI.FE)$p.value	
shaptst05diff <- shapiro.test(S2Avg.GAR.PD-S2Avg.GAR.FE)$p.value	
shaptst06diff <- shapiro.test(S2Avg.MIR.PD-S2Avg.MIR.FE)$p.value	
shaptst07diff <- shapiro.test(S2Avg.SAR.PD-S2Avg.SAR.FE)$p.value	
shaptst08diff <- shapiro.test(S2Avg.WHI.PD-S2Avg.WHI.FE)$p.value	
shaptst09diff <- shapiro.test(S3Avg.GAR.PD-S3Avg.GAR.FE)$p.value	
shaptst10diff <- shapiro.test(S3Avg.MIR.PD-S3Avg.MIR.FE)$p.value	
shaptst11diff <- shapiro.test(S3Avg.SAR.PD-S3Avg.SAR.FE)$p.value	
shaptst12diff <- shapiro.test(S3Avg.WHI.PD-S3Avg.WHI.FE)$p.value	
shaptst13diff <- shapiro.test(S4Avg.GAR.PD-S4Avg.GAR.FE)$p.value	
shaptst14diff <- shapiro.test(S4Avg.MIR.PD-S4Avg.MIR.FE)$p.value	
shaptst15diff <- shapiro.test(S4Avg.SAR.PD-S4Avg.SAR.FE)$p.value	
shaptst16diff <- shapiro.test(S4Avg.WHI.PD-S4Avg.WHI.FE)$p.value	

Pioneer.shap.test.diff.summary <- matrix(c(shaptst01diff,
                                           shaptst02diff,
                                           shaptst03diff,
                                           shaptst04diff,
                                           shaptst05diff,
                                           shaptst06diff,
                                           shaptst07diff,
                                           shaptst08diff,
                                           shaptst09diff,
                                           shaptst10diff,
                                           shaptst11diff,
                                           shaptst12diff,
                                           shaptst13diff,
                                           shaptst14diff,
                                           shaptst15diff,
                                           shaptst16diff),ncol=16, byrow=FALSE)

# CHECK THAT FE VALLUES FOR EACH SITE * SEASON ARE BELOW PD!

#EXPORT FOR REPORTING
write.csv(Pioneer.shap.test.diff.summary, file = "c:/github.c/Periphyton/results/Pioneer.shapiro.test.diff.csv")

# t-tests are often applied without examining the prop. dens. function of the data first, 
# and with the Barron data the tests produced similar results (after removal of 0-values) 
  
# THEREFORE: DO t-test as well as non-parametric tests
  
  # What probability distribution is better than normal?
  # TRANSFORMATIONS: NEED TO UNDERSTAND UNDERLYING PROCESSES! FIDDLY!
  # DISTRIBUTIONS for zero-inflated data: Zuur et al 2009 / https://www.researchgate.net/post/How-can-I-analyze-variables-with-several-zeros )

  # ALL SIGNIFICANCE TESTING (COMPARISON OF MEANS) HERE 
  # ALL SIGNIFICANCE TESTING (COMPARISON OF MEANS) HERE 

  # ASSUMING NORMAL DISTRIBUTION:
  # This produces Welch Two Sample t-test   
# CHECKING DEFAULTS
 t1Gmore <- t.test(S1[2],S1[3],mu = 0) #two-sided is default, "mu = 0" = true difference of means, 
 
 t1G <- t.test(S1[2],S1[3])
 t1M <- t.test(S1[4],S1[5])
 t1S <- t.test(S1[6],S1[7])
 t1W <- t.test(S1[8],S1[9])

 t2G <- t.test(S2[2],S2[3])
 t2M <- t.test(S2[4],S2[5])
 t2S <- t.test(S2[6],S2[7])
 t2W <- t.test(S2[8],S2[9])
 
 t3G <- t.test(S3[2],S3[3])
 t3M <- t.test(S3[4],S3[5])
 t3S <- t.test(S3[6],S3[7])
 t3W <- t.test(S3[8],S3[9])
 
 t4G <- t.test(S4[2],S4[3])
 t4M <- t.test(S4[4],S4[5])
 t4S <- t.test(S4[6],S4[7])
 t4W <- t.test(S4[8],S4[9])
 
# PRODUCES LIST OF RESULTS, USE
 t1G$statistic #etc to look up results

 t1G$parameter  
 t1G$p.value    
 t1G$conf.int   
 t1G$estimate   
 t1G$null.value 
 t1G$stderr     
 t1G$alternative
 t1G$method     
 t1G$data.name

Pioneer.t.test.summary <- matrix(c(t1G,t1M,t1S,t1W,t2G,t2M,t2S,t2W,t3G,t3M,t3S,t3W,t4G,t4M,t4S,t4W),nrow=10,ncol=16,byrow=FALSE)

write.csv(Pioneer.t.test.summary, file = "c:/github.c/Periphyton/results/Pioneer.t.test.csv")
 

 # RESULT: SEE SPREADSHEET FOR SUMMARY

 # THE DATA IS NON-NORMALLY DISTRIBUTED, BUT HERE THE t-test WAS USED 
 # FOR COMPARISON WITH THE WILCOXON TEST
 

# CALCULATE / TABULATE NON-PARAMETRIC = WILCOXON SIGNIFICANCE TEST RESULTS
# CALCULATE / TABULATE NON-PARAMETRIC = WILCOXON SIGNIFICANCE TEST RESULTS

#to confirm difference we are looking for a p value smaller than the significance level of 0.05
# https://www.youtube.com/watch?v=JmUnlDdMd9U

PioneerS1Avg.GAR.res <- wilcox.test(S1$S1Avg.GAR.PD, S1$S1Avg.GAR.FE, paired = TRUE)
PioneerS1Avg.MIR.res <- wilcox.test(S1$S1Avg.MIR.PD, S1$S1Avg.MIR.FE, paired = TRUE)
PioneerS1Avg.SAR.res <- wilcox.test(S1$S1Avg.SAR.PD, S1$S1Avg.SAR.FE, paired = TRUE)
PioneerS1Avg.WHI.res <- wilcox.test(S1$S1Avg.WHI.PD, S1$S1Avg.WHI.FE, paired = TRUE)

PioneerS2Avg.GAR.res <- wilcox.test(S2$S2Avg.GAR.PD, S2$S2Avg.GAR.FE, paired = TRUE)
PioneerS2Avg.MIR.res <- wilcox.test(S2$S2Avg.MIR.PD, S2$S2Avg.MIR.FE, paired = TRUE)
PioneerS2Avg.SAR.res <- wilcox.test(S2$S2Avg.SAR.PD, S2$S2Avg.SAR.FE, paired = TRUE)
PioneerS2Avg.WHI.res <- wilcox.test(S2$S2Avg.WHI.PD, S2$S2Avg.WHI.FE, paired = TRUE)

PioneerS3Avg.GAR.res <- wilcox.test(S3$S3Avg.GAR.PD, S3$S3Avg.GAR.FE, paired = TRUE)
PioneerS3Avg.MIR.res <- wilcox.test(S3$S3Avg.MIR.PD, S3$S3Avg.MIR.FE, paired = TRUE)
PioneerS3Avg.SAR.res <- wilcox.test(S3$S3Avg.SAR.PD, S3$S3Avg.SAR.FE, paired = TRUE)
PioneerS3Avg.WHI.res <- wilcox.test(S3$S3Avg.WHI.PD, S3$S3Avg.WHI.FE, paired = TRUE)

PioneerS4Avg.GAR.res <- wilcox.test(S4$S4Avg.GAR.PD, S4$S4Avg.GAR.FE, paired = TRUE)
PioneerS4Avg.MIR.res <- wilcox.test(S4$S4Avg.MIR.PD, S4$S4Avg.MIR.FE, paired = TRUE)
PioneerS4Avg.SAR.res <- wilcox.test(S4$S4Avg.SAR.PD, S4$S4Avg.SAR.FE, paired = TRUE)
PioneerS4Avg.WHI.res <- wilcox.test(S4$S4Avg.WHI.PD, S4$S4Avg.WHI.FE, paired = TRUE)

# PRODUCES TWO MORE VALUES:
PioneerS4Avg.WHI.res <- wilcox.test(S4$S4Avg.WHI.PD, S4$S4Avg.WHI.FE, paired = TRUE,conf.int = TRUE)


# record Wilcox V-statistic and p.value
Pioneer.wilcox.test.summary.Stat.P <- 
  matrix(c(PioneerS1Avg.GAR.res$statistic, 
           PioneerS1Avg.MIR.res$statistic, 
           PioneerS1Avg.SAR.res$statistic, 
           PioneerS1Avg.WHI.res$statistic, 
           PioneerS2Avg.GAR.res$statistic, 
           PioneerS2Avg.MIR.res$statistic, 
           PioneerS2Avg.SAR.res$statistic, 
           PioneerS2Avg.WHI.res$statistic, 
           PioneerS3Avg.GAR.res$statistic, 
           PioneerS3Avg.MIR.res$statistic, 
           PioneerS3Avg.SAR.res$statistic, 
           PioneerS3Avg.WHI.res$statistic, 
           PioneerS4Avg.GAR.res$statistic, 
           PioneerS4Avg.MIR.res$statistic, 
           PioneerS4Avg.SAR.res$statistic, 
           PioneerS4Avg.WHI.res$statistic,
           PioneerS1Avg.GAR.res$p.value, 
           PioneerS1Avg.MIR.res$p.value, 
           PioneerS1Avg.SAR.res$p.value, 
           PioneerS1Avg.WHI.res$p.value, 
           PioneerS2Avg.GAR.res$p.value, 
           PioneerS2Avg.MIR.res$p.value, 
           PioneerS2Avg.SAR.res$p.value, 
           PioneerS2Avg.WHI.res$p.value, 
           PioneerS3Avg.GAR.res$p.value, 
           PioneerS3Avg.MIR.res$p.value, 
           PioneerS3Avg.SAR.res$p.value, 
           PioneerS3Avg.WHI.res$p.value, 
           PioneerS4Avg.GAR.res$p.value, 
           PioneerS4Avg.MIR.res$p.value, 
           PioneerS4Avg.SAR.res$p.value, 
           PioneerS4Avg.WHI.res$p.value),nrow=2,ncol=16,byrow=TRUE)

write.csv(Pioneer.wilcox.test.summary.Stat.P, file = "c:/github.c/Periphyton/results/Pioneer.wilcox.test.summary.Stat.P.csv")



# RESULT: SEE SPREADSHEET
? wilcox.test

 
S1.GA <- (S1[2:3])
S1.MI <- (S1[4:5])
S1.SA <- (S1[6:7])
S1.WH <- (S1[8:9])

S2.GA <- (S2[2:3])
S2.MI <- (S2[4:5])
S2.SA <- (S2[6:7])
S2.WH <- (S2[8:9])

S3.GA <- (S3[2:3])
S3.MI <- (S3[4:5])
S3.SA <- (S3[6:7])
S3.WH <- (S3[8:9])

S4.GA <- (S4[2:3])
S4.MI <- (S4[4:5])
S4.SA <- (S4[6:7])
S4.WH <- (S4[8:9])

#***

# http://www.sthda.com/english/wiki/paired-samples-wilcoxon-test-in-r#check-your-data

PioneerS1Wilc <- data.frame(read.csv("./data/PioneerS1Wilc.csv", header = TRUE))
PioneerS2Wilc <- data.frame(read.csv("./data/PioneerS2Wilc.csv", header = TRUE))
PioneerS3Wilc <- data.frame(read.csv("./data/PioneerS3Wilc.csv", header = TRUE))
PioneerS4Wilc <- data.frame(read.csv("./data/PioneerS4Wilc.csv", header = TRUE))

# OPTIONS: NON-PARAMETRIC APPROACH 
# (ASSUMPTION-FREE, DOES NOT REQUIRE SPECIFIC PROBABILITY DISTRIBUTIONS)


library("ggpubr")

par(mfrow=c(4,4))

ggboxplot

ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.GAR", add = "jitter", ylim=c(0,30), color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgGAR", xlab = "Scen")
ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.MIR", color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgMIR", xlab = "Scen")
ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.SAR", color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgSAR", xlab = "Scen")
ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.WHI", color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgWHI", xlab = "Scen")

ggboxPioGAR <- ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.GAR", add = "jitter", ylim=c(0,30), color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgGAR", xlab = "Scen")
ggboxPioMIR <- ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.MIR", add = "jitter", ylim=c(0,30), color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgMIR", xlab = "Scen")
ggboxPioSAR <- ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.SAR", add = "jitter", ylim=c(0,30), color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgSAR", xlab = "Scen")
ggboxPioWHI <- ggboxplot(PioneerS1Wilc, x = "Scen", y = "S1Avg.WHI", add = "jitter", ylim=c(0,30), color = "Scen", palette = c("#00AFBB", "#E7B800"), order = c("PD", "FE"), ylab = "S1AvgWHI", xlab = "Scen")



? ggboxplot  # bxp.errorbar.width (default = 0.4): 

# TO DISPLAY PANEL OF BOX PLOTS FOR ALL SERIES FOR A SEASON
# TO DISPLAY PANEL OF BOX PLOTS FOR ALL SERIES FOR A SEASON

library(gridExtra)  # for "grid.arrange" function

grid.arrange(ggboxPioGAR,ggboxPioMIR,ggboxPioSAR,ggboxPioWHI, nrow=2)

# saved as C:\github.c\Periphyton\data\vidualization\ggboxplot season 1 panel.png

# COOL OPTION
# see here: http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/76-add-p-values-and-significance-levels-to-ggplots/
# for box plots with significance levels / probabilities


# PLOT PAIRED DATA (NOT GOOD-LOOKING)
# PLOT PAIRED DATA (NOT GOOD-LOOKING)

install.packages("PairedData")
library(PairedData)

# Compare habitat data before and after treatment

PioneerS1Avg.GAR.PD <- subset(S1[2])
PioneerS1Avg.GAR.FE <- subset(S1[3])

PioneerS1Avg.GAR.paired <- paired(PioneerS1Avg.GAR.PD, PioneerS1Avg.GAR.FE)
plot(PioneerS1Avg.GAR.paired, type = "profile") + theme_bw()

#


# SECOND NON-PARAMETRIC TEST: KRUSKAL-WALLACE
# http://www.sthda.com/english/wiki/paired-samples-wilcoxon-test-in-r#check-your-data

PioneerS1Wilc <- data.frame(read.csv("./data/PioneerS1Wilc.csv", header = TRUE))
PioneerS2Wilc <- data.frame(read.csv("./data/PioneerS2Wilc.csv", header = TRUE))
PioneerS3Wilc <- data.frame(read.csv("./data/PioneerS3Wilc.csv", header = TRUE))
PioneerS4Wilc <- data.frame(read.csv("./data/PioneerS4Wilc.csv", header = TRUE))

Scen <- PioneerS1Wilc$Scen
Scen = factor(Scen)

attach(PioneerS1Wilc)
attach(PioneerS2Wilc)
attach(PioneerS3Wilc)
attach(PioneerS4Wilc)

KW.S1Avg.GAR <- data.frame(kruskal.test(S1Avg.GAR ~ Scen)$statistic,
                           kruskal.test(S1Avg.GAR ~ Scen)$parameter,
                           kruskal.test(S1Avg.GAR ~ Scen)$p.value,
                           kruskal.test(S1Avg.GAR ~ Scen)$method,
                           kruskal.test(S1Avg.GAR ~ Scen)$data.name)
KW.S1Avg.MIR <- data.frame(kruskal.test(S1Avg.MIR ~ Scen)$statistic,
                           kruskal.test(S1Avg.MIR ~ Scen)$parameter,
                           kruskal.test(S1Avg.MIR ~ Scen)$p.value,
                           kruskal.test(S1Avg.MIR ~ Scen)$method,
                           kruskal.test(S1Avg.MIR ~ Scen)$data.name)
KW.S1Avg.SAR <- data.frame(kruskal.test(S1Avg.SAR ~ Scen)$statistic,
                           kruskal.test(S1Avg.SAR ~ Scen)$parameter,
                           kruskal.test(S1Avg.SAR ~ Scen)$p.value,
                           kruskal.test(S1Avg.SAR ~ Scen)$method,
                           kruskal.test(S1Avg.SAR ~ Scen)$data.name)
KW.S1Avg.WHI <- data.frame(kruskal.test(S1Avg.WHI ~ Scen)$statistic,
                           kruskal.test(S1Avg.WHI ~ Scen)$parameter,
                           kruskal.test(S1Avg.WHI ~ Scen)$p.value,
                           kruskal.test(S1Avg.WHI ~ Scen)$method,
                           kruskal.test(S1Avg.WHI ~ Scen)$data.name)

KW.S2Avg.GAR <- data.frame(kruskal.test(S2Avg.GAR ~ Scen)$statistic,
                           kruskal.test(S2Avg.GAR ~ Scen)$parameter,
                           kruskal.test(S2Avg.GAR ~ Scen)$p.value,
                           kruskal.test(S2Avg.GAR ~ Scen)$method,
                           kruskal.test(S2Avg.GAR ~ Scen)$data.name)
KW.S2Avg.MIR <- data.frame(kruskal.test(S2Avg.MIR ~ Scen)$statistic,
                           kruskal.test(S2Avg.MIR ~ Scen)$parameter,
                           kruskal.test(S2Avg.MIR ~ Scen)$p.value,
                           kruskal.test(S2Avg.MIR ~ Scen)$method,
                           kruskal.test(S2Avg.MIR ~ Scen)$data.name)
KW.S2Avg.SAR <- data.frame(kruskal.test(S2Avg.SAR ~ Scen)$statistic,
                           kruskal.test(S2Avg.SAR ~ Scen)$parameter,
                           kruskal.test(S2Avg.SAR ~ Scen)$p.value,
                           kruskal.test(S2Avg.SAR ~ Scen)$method,
                           kruskal.test(S2Avg.SAR ~ Scen)$data.name)
KW.S2Avg.WHI <- data.frame(kruskal.test(S2Avg.WHI ~ Scen)$statistic,
                           kruskal.test(S2Avg.WHI ~ Scen)$parameter,
                           kruskal.test(S2Avg.WHI ~ Scen)$p.value,
                           kruskal.test(S2Avg.WHI ~ Scen)$method,
                           kruskal.test(S2Avg.WHI ~ Scen)$data.name)

KW.S3Avg.GAR <- data.frame(kruskal.test(S3Avg.GAR ~ Scen)$statistic,
                           kruskal.test(S3Avg.GAR ~ Scen)$parameter,
                           kruskal.test(S3Avg.GAR ~ Scen)$p.value,
                           kruskal.test(S3Avg.GAR ~ Scen)$method,
                           kruskal.test(S3Avg.GAR ~ Scen)$data.name)
KW.S3Avg.MIR <- data.frame(kruskal.test(S3Avg.MIR ~ Scen)$statistic,
                           kruskal.test(S3Avg.MIR ~ Scen)$parameter,
                           kruskal.test(S3Avg.MIR ~ Scen)$p.value,
                           kruskal.test(S3Avg.MIR ~ Scen)$method,
                           kruskal.test(S3Avg.MIR ~ Scen)$data.name)
KW.S3Avg.SAR <- data.frame(kruskal.test(S3Avg.SAR ~ Scen)$statistic,
                           kruskal.test(S3Avg.SAR ~ Scen)$parameter,
                           kruskal.test(S3Avg.SAR ~ Scen)$p.value,
                           kruskal.test(S3Avg.SAR ~ Scen)$method,
                           kruskal.test(S3Avg.SAR ~ Scen)$data.name)
KW.S3Avg.WHI <- data.frame(kruskal.test(S3Avg.WHI ~ Scen)$statistic,
                           kruskal.test(S3Avg.WHI ~ Scen)$parameter,
                           kruskal.test(S3Avg.WHI ~ Scen)$p.value,
                           kruskal.test(S3Avg.WHI ~ Scen)$method,
                           kruskal.test(S3Avg.WHI ~ Scen)$data.name)

KW.S4Avg.GAR <- data.frame(kruskal.test(S4Avg.GAR ~ Scen)$statistic,
                           kruskal.test(S4Avg.GAR ~ Scen)$parameter,
                           kruskal.test(S4Avg.GAR ~ Scen)$p.value,
                           kruskal.test(S4Avg.GAR ~ Scen)$method,
                           kruskal.test(S4Avg.GAR ~ Scen)$data.name)
KW.S4Avg.MIR <- data.frame(kruskal.test(S4Avg.MIR ~ Scen)$statistic,
                           kruskal.test(S4Avg.MIR ~ Scen)$parameter,
                           kruskal.test(S4Avg.MIR ~ Scen)$p.value,
                           kruskal.test(S4Avg.MIR ~ Scen)$method,
                           kruskal.test(S4Avg.MIR ~ Scen)$data.name)
KW.S4Avg.SAR <- data.frame(kruskal.test(S4Avg.SAR ~ Scen)$statistic,
                           kruskal.test(S4Avg.SAR ~ Scen)$parameter,
                           kruskal.test(S4Avg.SAR ~ Scen)$p.value,
                           kruskal.test(S4Avg.SAR ~ Scen)$method,
                           kruskal.test(S4Avg.SAR ~ Scen)$data.name)
KW.S4Avg.WHI <- data.frame(kruskal.test(S4Avg.WHI ~ Scen)$statistic,
                           kruskal.test(S4Avg.WHI ~ Scen)$parameter,
                           kruskal.test(S4Avg.WHI ~ Scen)$p.value,
                           kruskal.test(S4Avg.WHI ~ Scen)$method,
                           kruskal.test(S4Avg.WHI ~ Scen)$data.name)

KW.S4Avg.WHI <- matrix(kruskal.test(S4Avg.WHI ~ Scen)$statistic,
                           kruskal.test(S4Avg.WHI ~ Scen)$parameter,
                           kruskal.test(S4Avg.WHI ~ Scen)$p.value,
                           kruskal.test(S4Avg.WHI ~ Scen)$method,
                           kruskal.test(S4Avg.WHI ~ Scen)$data.name,byrow=TRUE)

Kruskal.Wallis.chi2.summary <- matrix(c(KW.S1Avg.GAR,KW.S1Avg.MIR,KW.S1Avg.SAR,KW.S1Avg.WHI,
                                        KW.S2Avg.GAR,KW.S2Avg.MIR,KW.S2Avg.SAR,KW.S2Avg.WHI,
                                        KW.S3Avg.GAR,KW.S3Avg.MIR,KW.S3Avg.SAR,KW.S3Avg.WHI,
                                        KW.S4Avg.GAR,KW.S4Avg.MIR,KW.S4Avg.SAR,KW.S4Avg.WHI),
                                        nrow=5,ncol=16,byrow=FALSE)

write.csv(Kruskal.Wallis.chi2.summary, file = "c:/github.c/Periphyton/results/Kruskal.Wallis.chi2.summary.csv")

detach(PioneerS1Wilc)
detach(PioneerS2Wilc)
detach(PioneerS3Wilc)
detach(PioneerS4Wilc)

# Findings so far: t-test and Kruskal-Wallis test provide almost identical results 
# for the full seasonal time series, Wilcoxon is less powerful

save.image("C:/github.c/Periphyton/SigTestMeans code.Pioneer.RData")

savehistory("C:/github.c/Periphyton/SigTestMeans code.Pioneer.Rhistory")









