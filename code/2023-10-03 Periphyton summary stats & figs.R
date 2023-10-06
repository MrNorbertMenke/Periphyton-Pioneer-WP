
########################################################################################################
########################################################################################################

#WP Environmental Risk Assessments
# 3 Data summary and visualisation - Periphyton model summary stats and figs
#2023-02-14  by Ryan McCosker and Yoko Shimizu, adapted by NM

########################################################################################################
########################################################################################################
#Quick introduction

#The original data was processed via pivot table operation in Excel, then manually formatted as flat file
#Currently: "C:\WP Pioneer\data\Periphyton\Results\Pioneer.Periphyton.Scenario.Comparison.ALL.RESULTS.xlsm"
#.. obtained from Norbert: Periphyton.Scenario.Comparison07_0.55VTOC.PIVOTPREP.YEAR.xlsm (NM).
#Formatted input data for R "C:\github.c\Periphyton\data\2023-09-15_Pioneer_Periphyton_dat.csv" 
#spreadsheet was formatted to use in R, then saved as a .csv file.
#NOTE this assessment will be available on eco risk projector platform from mid 2023 onwards.


######################
#Data type (flat file format, adapted from pivot table, for direct import provision see 
#"C:\zzz_dms\Pioneer01\Scenarios\MyStacker.xlsm")

#The eco risk projector output should be a long data format (.csv) and contains the following columns.
#Note: column titles are case sensitive.
#1st column - Year
#2nd column - Season
#3rd column - Site
#4th column - Scenario
#5th column - Habitat


######################
#Required output(s)

#1. Summary statistics table (.csv). Mean/SD/SE periphyton habitat (m) per quarter by site.
# "C:\github.c\Periphyton\results\Periphyton summary statistics.csv" (matching the Excel pivot table 
# results, which were used for the EAR report)
#2. Bar plots showing the mean periphyton habitat (m) per quarter by site (.tiff).
# "C:\github.c\Periphyton\results\Periphyton barplot.tiff"

#Note: for each sample location, mean periphyton habitat (m) will be calculated per quarter over 
#a 130yr period under PD and FE flow regime simulation scenarios, then plot it as bar plots
#with error bars(Mean and SD based on all annual X season values, including "0" values).


#Metadata tasks
#1) Final update of records/details
#2) Finalize document paths for GitHub repository (& G-drive?)

########################################################################################################

#Data prepping and formatting

########################################################################################################


#Record start time
start.time <- Sys.time()

#Call packages
require("pacman")
pacman::p_load(tidyr, dplyr, plyr, ggplot2, gridExtra, gtools)

#set Working Directory
setwd("C:/github.c/Periphyton")

#Call the model output data
dat <- read.csv('./data/2023-09-15_Pioneer_Periphyton_dat.csv')
str(dat)
# fix(dat)  #NM  4160 rows

# Note: including all values, including numerous zeros!

#Change Season/Scenario to factor and apply levels
dat$Season <- factor(dat$Season, levels = c("Jan-Mar", "Apr-Jun", "Jul-Sep", "Oct-Dec"))
dat$Scenario <- factor(dat$Scenario, levels = c("PD", "FE"))


########################################################################################################

#Summary statistics (loop!)

########################################################################################################


#Determine number of sites for looping 
no_sites <- length(unique(dat$Site))
site_names <- unique(dat$Site)

site_names  #CHECKING

# REPLACE SITE NAMES WITH ASSESSMENT NODES

site_names <- c("125004B", "125007A", "125002C", "125005A")

site_names[1]

#Split dataframe into a list by site name (in alphabetical order)
dat_list <- split(dat, f=dat$Site)

# write.csv(dat_list, './results/dat_list.csv')   #NM  for diagnostics only

#Order site names alphabetically to match up with the dat_list above
#  site_names <- site_names[order(site_names)]  
#no alphabetic sorting when using hand-arranged assessment node names
# site_names[4] <- "Whiteford"  #Unabbreviated name NM
site_names

#create an empty list to store summary statistics
tab <- list()

#Calculate summary statistics (Mean, SD, SE)
for(i in 1:no_sites){
  tab[[i]] <- ddply(dat_list[[i]], c('Season', 'Scenario', 'Site'), summarise,
                    Mean = mean(Habitat),
                    SE = sd(Habitat) / sqrt((length(Habitat))),
                    SD = sd(Habitat)) #function to be applied to each site
  
}

#assigning the name of each list item to be its respective site
names(tab) <- c(site_names) 

#Check the summary stats by site
tab

#Save as .csv
write.csv(tab, './results/Periphyton summary statistics.csv')



########################################################################################################

#Bar plot (loop!)

########################################################################################################


#Create an empty list to store ggplot figures in
plots <- list()

#Generate all plots and save them in plots list (above), then plot them all in same window.
for(i in 1:no_sites){
  plots[[i]] <- ggplot(tab[[i]], aes(x = Season, y = Mean, fill = Scenario))+ 
    ylim(-1,20) +
    xlab("Season") +
    ylab("Habitat (m)") +
    ggtitle(names(tab[i]))+
    geom_bar(stat = "identity", position = "dodge", show.legend = F)+
    geom_errorbar(aes(ymin = Mean-SD, ymax = Mean + SD), width=.1,position=position_dodge(.9))+
    theme(plot.title = element_text(size=10))+
    theme(axis.text=element_text(size=8))+
    theme(axis.title=element_text(size=8))+
    theme(legend.text=element_text(size=8))+
    theme(legend.title=element_text(size=8))+
    scale_fill_manual(values = c("#b5e3d2", "#2bb891"))   #NM inserted for new colour scheme
  
}



#####################################################################################################

#Visualisation 

#####################################################################################################

#Display plots 
grid.arrange(grobs = plots, ncol = 2)

#Save as .tiff at 600dpi as per Glenn
ggsave(file = './results/Periphyton barplot.tiff', 
       arrangeGrob(grobs = plots, ncol=2), width=5, height=5, units="in", dpi=600)  #height=7.5

# NOTE: requires some pixel editing to fit in the most negative SD error bar, FE for Sarichs Jul-Sep

#File>Save As  saves code as .R
#Session>Save Workspace As  saves into .RData

# File>Save All:
save.image("C:/github.c/Periphyton/Periphyton Pioneer barplots.RData") 
# Saves .RData; .Rhistory; .R code
# Does not save .Rproj

#Time taken to run the script
end.time <- Sys.time()
time <- end.time - start.time
time



########################################################################################################
#End of Script

