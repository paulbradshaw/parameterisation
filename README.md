# Parameterisation

This repo contains materials for learning how to generate a website using R. Examples of websites using this technique include:

* [Police misconduct](https://sduiopc.github.io/test1)
* [Children's language needs post-lockdown](https://senspeech.github.io/website/)

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
