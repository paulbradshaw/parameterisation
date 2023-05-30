---
title: "renderhtml"
author: "BIGNEWS"
date: "2023-05-26"
output: html_document
---

```{r get file names}
#get the names of all the html files
filenames <- list.files("site")
```

```{r generate yaml}
#store the string we want to start out yaml file with
yamlstring <- 'name: "reg"
navbar:
  title: "Stop and search"
  left:
    - text: "Regions"
      menu:'
```

```{r}
#create an empty vector to store all the strings we're about to create
strvec <- c()
#loop through the filenames 
for (i in filenames){
  if(substring(i,nchar(i)-2,nchar(i)) == ".md" ){
    #replace spaces with dashes, and replace the file extension with .html
    htmlversion <- gsub(" ","-",gsub(".md",".html",i))
    #get the name by removing the file extension. 
    textversion <- gsub(".md","",i)
    #create a string for the YAML file by inserting those
    fullstring <- paste0('
      - text: "',textversion,'"
        href: ',htmlversion)
    strvec <- c(strvec,fullstring) #add to the collection of strings 
  }
}

#add the initial string
strvec <- c(yamlstring, strvec)
#create a yaml file with that string of text in it
write(strvec, file = "site/_site.yml")


```



```{r render site}
#now render the site
rmarkdown::render_site("site")
```

