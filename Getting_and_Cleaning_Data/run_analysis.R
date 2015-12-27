require(knitr)
require(markdown)

## Change the working directory to required path
#setwd("IntroToBDA/Getting_and_Cleaning_Data/UCI HAR Dataset/")

knit("run_analysis.Rmd", encoding="ISO8859-1")
markdownToHTML("run_analysis.md", "run_analysis.html")
