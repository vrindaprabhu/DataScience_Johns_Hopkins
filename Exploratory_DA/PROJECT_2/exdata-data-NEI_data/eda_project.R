require(knitr)
require(markdown)

## Change the working directory to required path
#setwd('IntroToBDA/Eploratory_DA/Ex_Da/exdata-data-NEI_data/')

knit("eda_project.Rmd", encoding="ISO8859-1")
markdownToHTML("eda_project.md", "eda_project.html")
