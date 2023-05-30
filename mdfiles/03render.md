---
title: "02render"
author: "BIGNEWS"
date: "2023-05-26"
output: html_document
---

```{r import data}
#store the URL
fileloc = "https://docs.google.com/spreadsheets/d/e/2PACX-1vR2-w4JWtqaDmOBp7CxZpMaqsa-2Tm4vUVslOf5_NVfiTIavYEJWHWOv-4sGJ9VUUlx8eJPnULECeYW/pub?gid=0&single=true&output=csv"

data = read_csv(fileloc)
#just get one column - it's now a vector
regions <- data$region
```

```{r generate md files}
#store the location of the template 
paramsfile <- "01template.Rmd"
#loop through all regions 
for (r in regions) {
  rmarkdown::render(paramsfile, params = list(reg = r), output_file = paste(sep="",'site/',stringr::str_replace_all(r," ","-"),'.md'),
    envir = parent.frame())
}
```
