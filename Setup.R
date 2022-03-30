# determine your current $HOME directory
path.expand('~')

# install .Rprofile. Tc
source('https://raw.githubusercontent.com/ncss-tech/soilReports/master/R/installRprofile.R')
installRprofile(overwrite=TRUE)


# need devtools to install packages from GitHub
install.packages('devtools', dep=TRUE)

# get the latest version of the 'soilReports' package
remotes::install_github("ncss-tech/soilReports", dependencies=FALSE, upgrade_dependencies=FALSE) 

library(soilReports)

# list reports in the package
listReports()

# Determine working directory. Use setwd(C:/workspace) to set directory to C drive if needed
getwd()

# install required packages for a named report
reportSetup(reportName='region2/mu-comparison')

# copy report file 'MU-comparison' to your current working directory
reportInit(reportName='region2/mu-comparison', outputDir='MU-comparison')


