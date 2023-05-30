---
title: |
  Regional analysis: `r params$reg`
output: 
  html_document:
    self_contained: false
    lib_dir: site/libs

params:
  reg: "Anyville"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE,
warning = F,
message = F)
```

# Analysing stop and search

Police have been given new powers to stop and search potential criminals - but are the existing powers effective - and used fairly? Find out how the numbers changed in `r params$reg`.

```{r import packages}
#import the tidyverse 
library(tidyverse)
#The datatables package 
library(DT)
```

```{r import data}
#store the URL
fileloc = "https://docs.google.com/spreadsheets/d/e/2PACX-1vR2-w4JWtqaDmOBp7CxZpMaqsa-2Tm4vUVslOf5_NVfiTIavYEJWHWOv-4sGJ9VUUlx8eJPnULECeYW/pub?gid=0&single=true&output=csv"

#Tidyverse's read_csv function imports from it
data = read_csv(fileloc)
```
```{r filter and subset}
#filter to those for this la, and specified cols
subsetdf <- data %>%
  dplyr::filter(region == params$reg)
```

```{r extract figures}
#store the figures for the earliest and latest years
fig21 <- subsetdf$stops_2021
fig22 <- subsetdf$stops_2022

#calculate the change in this region
localchange <- (fig22-fig21)/fig21
#calculate the change across all regions
nationalchange <- (sum(data$stops_2022)-sum(data$stops_2021))/sum(data$stops_2021)
```

```{r create custom string}
#set a variable to 'rose' or 'dropped' depending on relation of earlier figure to newer one
changetype <- ifelse(isTRUE(fig22 > fig21), "rose", "dropped")

#create a custom string with that
customstring1 <- paste0("In **",params$reg,"** the number of stops ",changetype," from **",fig21,"** in 2021 to **",fig22,"** in 2022.")
```

`r customstring1`

```{r create another string}
nationalcomparison <- ifelse(localchange>nationalchange, "higher than", "below the")

#create a custom string with that
customstring2 <- paste0("The number of people being stopped in 2022 **",changetype," by ",round(localchange*100,1),"%** compared to the previous year. This is ",nationalcomparison," the national rise of **",round(nationalchange*100, 1),"%**.")
```

`r customstring2`

## Explore your area

```{r clean headings}
#clean column headings
colnames(subsetdf) <- str_replace(colnames(subsetdf),"_"," ")
```

```{r table}
#Create the datatable. Add a caption if you want
DT::datatable(data,
             style = 'bootstrap',
             caption = 'Numbers of people being stopped and searched', 
             filter = 'top',
             options = list(pageLength = 10, scrollX=TRUE,
                             autoWidth = TRUE,
                             order = list(7, 'desc') #order by col 7
                              ), escape = F
             )
```


