---
title: "05cleaning"
output: html_document
---


## Clean the HTML outputs

The pages have some HTML which needs to be removed because it is being rendered as paragraph text: `<p>&lt;!DOCTYPE html&gt;</p>`.

We open the HTML file in a text editor and search for that text - the second instance - to identify which line it's on. 

Then the code below seeks out that line and replaces it.

### Test on one file first


```{r list html files}
#get the names of all the html files
htmlfiles <- list.files("site/_site")
htmlfiles[1]
#read in the first one
testfile <- readr::read_lines(paste0("site/_site/",htmlfiles[1]))
#create an empty list
tfvec <- c()
#loop through all the lines
for(i in testfile){
  #check if the line matches the string
  tfmatch <- i == "<p>&lt;!DOCTYPE html&gt;</p>"
  #store the True/False value in a vector
  tfvec <- c(tfvec,tfmatch)
}

#find the index of the line with that text
doctypeline <- which(tfvec)
print(doctypeline)
#show the  line
#testfile[174]
testfile[doctypeline]
#replace it
testfile[doctypeline] <- ""
testfile[doctypeline]
#save it as a HTML file to check
write(x = testfile, file=paste0("site/_site/","testfile.html"))
#remove the variable
rm(testfile)
```


### Apply to all files

Once tested, we embed that process in a loop which tests if the file is one of the pages and then removes the offending line if so.

```{r clean DOCTYPE from all files}
#create a list to catch matches
matchlist <- c()
#loop through the list of filenames
for (i in htmlfiles){
  print(i)
  #extract the last 5 chars
  filetype <- substring(i,nchar(i)-4,nchar(i))
  #check if they end in .html
  ey <- filetype == ".html"
  print(filetype)
  #this should be TRUE or FALSE
  print(ey)
  #if it's a html file
  if(ey){
    #read in that file
    thisfile <- readr::read_lines(paste0("site/_site/",i))
    #show line
    print(thisfile[282])
    #if it has that text
    if (thisfile[282] == "<p>&lt;!DOCTYPE html&gt;</p>"){
      print("OH 282!")
      #replace specified string
      thisfile[282] <- ""
      write(x = thisfile, file=paste0("site/_site/",i))
    }
    #grab the same line we identified in the code chunk above
    else if(thisfile[doctypeline] == "<p>&lt;!DOCTYPE html&gt;</p>"){
      stringtoprint <- paste("OH",doctypeline,"!")
      print(stringtoprint)
      #replace specified string
      thisfile[doctypeline] <- ""
      write(x = thisfile, file=paste0("site/_site/",i))
    }
    else {
      print("NOPE")
      #add filename to list
      matchlist <- c(matchlist,i)
    }
  }
  else {
    print("NOT THIS ONE")
  }
}
```


## Clean the navigation in other pages

We need to ensure this navbar works.

The problem is caused by a duplicate `<html>` and `<head>` tag. 

This and other duplicate lines of code run from lines 283-418. But some of that code helps the table to work, so removing it all would cause new problems.

We *can* just remove `<html>` and `<head>` and the closing tags for those.

`<html>` and `<head>` are on 283 and 284 while `</head>` and `<body>` are on line 417 and 418. There's also an extra `</body>` and `</html>` on lines 492-3.

From 285-290 are some meta tags and a title tag we can also remove. 

From 340-368 is a style tag. Removing this doesn't affect the functionality of the page either.

From 370-415 is another which also can be removed without affecting functionality.

But we leave those lines as it's not worth the time of writing code to remove them.

We can make the dropdowns functional by adding this code, but it breaks their appearance. 

```
<!-- CSS file -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<!-- JavaScript files -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
```

Some trial and error (trying each line on its own) helps us fix it: the 4.5 JS file is the one that fixes the behaviour of the dropdown, while the CSS file is the one that breaks the appearance. 

So we just need to replace the JS link. This is on line 295.


```{r fix nav in area files}
#store the line numbers for the starting points so we only have to change them here
jsline <- 295

#create a list to catch matches
matchlist <- c()
#loop through the list of filenames
for (i in htmlfiles){
  print(i)
  #extract the last 5 chars
  filetype <- substring(i,nchar(i)-4,nchar(i))
  #check if they end in .html
  ey <- filetype == ".html"
  print(filetype)
  #this should be TRUE or FALSE
  print(ey)
  #we don't want to change the index.html file so set to false if it's that file
  if(i == 'index.html'){
    print("NOT THIS ONE")
    ey <- FALSE
  }
  #if it's a html file (apart from index.html)
  if(ey){
    #read in that file
    thisfile <- readr::read_lines(paste0("site/_site/",i))
    #line 254 should be the title of the dropdown, 'Local authorities'
    print(thisfile[jsline])
    #if it has that text
    if (thisfile[jsline] == '<script src="libs/bootstrap-3.3.5/js/bootstrap.min.js"></script>'){
      print(paste("OH ",jsline,"!"))
      #replace specified string
      #change it
      thisfile[jsline] <- '<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>'
      #now replace the original with the cleaned version
      write(x = thisfile, file=paste0("site/_site/",i))
    }
  }
  else {
    print("NOT THIS ONE")
  }
}
```



