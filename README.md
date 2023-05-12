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

5. Make our package also a Git repository, with `use_git()`

6. Create `x <- "alfa,bravo,charlie,delta"`. Suppose we want to write a function that splits this into a vector of individual words:

   * this can be done with `unlist(strsplit(x, split=","))`

7. We now want to write a function we are going to call `strsplit1` which takes as input a string with a given separator and splits it into a vector of strings

   * call `use_r("strsplit1")` which should create an `strsplit1.R` file within the `R/` folder

   * write your `strsplit1` function in that file:

     ```R
     strsplit1 <- function(x, split) {
     	unlist(strsplit(x, split = split))
     }
     ```

8. Test drive your function by calling `load_all()` which should make the function available for you to play with

   * when developing an R package, we don't manually instantiate functions typically
   * `load_all` provides a more robust way to test functions as it simulates what a user would experience by loading the package

9. Check that the package as a whole works by calling `check()`

   * this runs `R CMD check`, which is executed in the shell, and is the gold standard for checking that an R package is in full working order

10. Note that `check` will have raised a warning about `Non-standard license specification`

    * we will address this soon

11. Open up the `DESCRIPTION` file:

    * make yourself the author; if you don’t have an ORCID, you can omit the `comment = ...` portion
    * add some descriptive text to the `Title` and `Description` fields

12. Add an MIT license (see lecture slides for intro to licenses) via `use_mit_license()`

    * adds two license files to the folder:
      * `LICENSE` which contains the year and copywright owners
      * `LICENSE.md` which holds the full license info

13. Create documentation for your `strsplit1` function:

    * open again your `R/strsplit1.R` file and place your cursor within the `strsplit1` function body
    * do *Code > Insert roxygen skeleton*, which should create boilerplate code above the function
    * add a title
    * describe the inputs and the return value
    * include an example

14. Trigger creation of the documentation via `document()`

    * this will create a folder `man/` which houses automatically built documentation for your package

15. Test your documentation using `?strsplit1`

16. Examine the `NAMESPACE` file. You will see that `document()` added *export(strsplit1)* there.

    * this makes the function available to users of the package

    * note, you may want internal functions in your package which you don't make available to users

17. Double check that your package is all ok via `check()`

18. Now that we have a package that works, we can install it via `install()`

19. Restart your R session and do `library(regexcite)` to load the package

20. Test the package using:

    ```R
    x <- "alfa,bravo,charlie,delta"
    strsplit1(x, split = ",")
    ```

21. We've tested our function `strsplit1` informally, but we would like to do so systematically to ensure that: the function works as intended across more general examples; and the function continues to work when we develop the package. To do so, we are going to create unit tests. A first step in this process is to call `use_testthat()`.

22. 

