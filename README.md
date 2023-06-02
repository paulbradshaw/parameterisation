# Parameterisation

This repo contains materials for learning how to generate a website using R. Examples of websites using this technique include:

* [Police misconduct](https://sduiopc.github.io/test1) - [GitHub repo with R files here](https://github.com/BBC-Data-Unit/police_misconduct/tree/main/rfiles)
* [Children's language needs post-lockdown](https://senspeech.github.io/website/) - [GitHub repo R files here](https://github.com/BBC-Data-Unit/child-speech/tree/main/parameterisation)

In each case we've been able to generate dozens of webpages that provide analyses of dozens of areas, so that journalists in each area can read a narrative about the figures in that particular area, explore an interactive table putting it into the context of the region, and in the second example have access to charts that show the figures of that region compared to historical numbers and national figures.

### The principles

Parameterisation is the process of using a 'parameter' to generate multiple documents. In general terms the principles are:

* Create a parameter — this should be what you want to generate a different page for (e.g. region, police force)
* Limit code output to what should be in the HTML file (visible elements)
* Loop through a list of items that can be used as that parameter, and call a ‘knitting’ function to create a file for each

### The steps

In practical terms we need to do the following:

1. Produce a template analysis for a given area in an R notebook (.Rmd file)
2. Produce an index page (using an R notebook) so that there's a single page to link to all the generated ones
3. Render multiple .md versions of the analysis page - one for each region 
4. Render HTML versions of the analysis pages and index, including a navigation bar
5. Upload to GitHub and publish as a GitHub Pages website
6. Debug, clean and tweak the HTML

### The files

You will find the R Markdown files in the [rfiles folder](https://github.com/paulbradshaw/parameterisation/tree/main/rfiles). 

The markdown doesn't render on GitHub so I've also uploaded simple [markdown versions in the mdfiles folder](https://github.com/paulbradshaw/parameterisation/tree/main/mdfiles). 

The resulting HTML files and CSS/JS libraries can be found in the [docs folder](https://github.com/paulbradshaw/parameterisation/tree/main/docs), and the website generated from those can be found at https://paulbradshaw.github.io/parameterisation/.

### Tips and tricks

* Set code and output to not be displayed in HTML page using `knitr::opts_chunk$set(echo = FALSE, warning = F, message = F)`
* Reduce size of knitted HTML file by specifying in `html_document:` part of YAML that `self_contained: false` and `lib_dir: site/libs`
* Remove `<!DOCTYPE html>` on resulting page
* Fix menu by updating the Bootstrap JS link to the latest version - see [cleaning notebook](https://github.com/paulbradshaw/parameterisation/blob/main/rfiles/05cleaning.Rmd) for example code
* Check if the menu is too long and split it into sections of alphabet if needed - see [cleaning notebook for the police site for an example](https://github.com/BBC-Data-Unit/police_misconduct/blob/main/rfiles/03renderAndClean.Rmd) or the [cleaning notebook for the language needs story for a longer menu](https://github.com/BBC-Data-Unit/child-speech/blob/main/parameterisation/03renderandclean.Rmd)


