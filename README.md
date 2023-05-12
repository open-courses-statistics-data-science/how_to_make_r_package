# How to create an R package

This short course describes how to make an R package. It broadly follow's Chapter 2 of the [online version](https://r-pkgs.org/) of "R Packages (2nd edition)", by Hadley Wickham and Jennifer Bryan.

Requirements:

* have R and RStudio installed
* have the `devtools` package installed

## Aims

We aim to create an R package, "regexcite", which contains a few simple functions for processing strings. In doing so, we will:

* create the functions themselves
* show how to set up version control
* explain workflows for package development including:
  * function documentation
  * unit testing
  * package documentation
* if time allows, we will discuss setting up continuous integration testing via Github Actions

## Instructions

1. Create a fresh folder where you intend to house an R package

2. Open up RStudio and change the working directory to be within the folder

3. Load `devtools` via `library(devtools)` (which loads `usethis`):

   * this is the interface to a range of tools which greatly facilitate R package development

4. Call `create_package("regexcite")` which will initialise a package in a directory

   * this will likely open up a new RStudio session so you may need to call `library(devtools)` again

   * notice that there now exists various files in the directory:

     * `DESCRIPTION` which is an editable file containing package metadata, which we will later edit
     * `.Rbuildignore` lists files that we need to have around but that should not be included when building the R package from source
     * `NAMESPACE` declares the functions your package exports for external use and the external functions your package imports from other packages. Generally, this should not be edited by hand
     * the `R/` directory is the “business end” of your package. It will soon contain `.R` files with function definitions.

     

5. 