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

## Instructions

1. Create a fresh folder where you intend to house an R package
2. Open up RStudio and change the working directory to be within the folder
3. Load `devtools` via `library(devtools)` (which loads `usethis`):
   * this is the interface to a range of tools which greatly facilitate R package development

### Create package outline

1. Call `create_package("regexcite")` which will initialise a package in a directory

   * this will likely open up a new RStudio session so you may need to call `library(devtools)` again

   * notice that there now exists various files in the directory:

     * `DESCRIPTION` which is an editable file containing package metadata, which we will later edit

     * `.Rbuildignore` lists files that we need to have around but that should not be included when building the R package from source

     * `NAMESPACE` declares the functions your package exports for external use and the external functions your package imports from other packages. Generally, this should not be edited by hand

     * the `R/` directory is the “business end” of your package. It will soon contain `.R` files with function definitions.

2. Make our package also a Git repository, with `use_git()`

3. Create `x <- "alfa,bravo,charlie,delta"`. Suppose we want to write a function that splits this into a vector of individual words:
   * this can be done with `unlist(strsplit(x, split=","))`

### Create basic function

1. We now want to write a function we are going to call `strsplit1` which takes as input a string with a given separator and splits it into a vector of strings

   * call `use_r("strsplit1")` which should create an `strsplit1.R` file within the `R/` folder

   * write your `strsplit1` function in that file:

     ```R
     strsplit1 <- function(x, split) {
     	unlist(strsplit(x, split = split))
     }
     ```

2. Test drive your function by calling `load_all()` which should make the function available for you to play with

   * when developing an R package, we don't manually instantiate functions typically

   * `load_all` provides a more robust way to test functions as it simulates what a user would experience by loading the package

3. Check that the package as a whole works by calling `check()`

   * this runs `R CMD check`, which is executed in the shell, and is the gold standard for checking that an R package is in full working order

4. Note that `check` will have raised a warning about `Non-standard license specification`
   * we will address this soon

### Add descriptive info for your package

1. Open up the `DESCRIPTION` file:

   * make yourself the author; if you don’t have an ORCID, you can omit the `comment = ...` portion

   * add some descriptive text to the `Title` and `Description` fields

2. Add an MIT license (see lecture slides for intro to licenses) via `use_mit_license()`
   * adds two license files to the folder:
     * `LICENSE` which contains the year and copywright owners
     * `LICENSE.md` which holds the full license info

### Create function documentation

1. Create documentation for your `strsplit1` function:

   * open again your `R/strsplit1.R` file and place your cursor within the `strsplit1` function body

   * do *Code > Insert roxygen skeleton*, which should create boilerplate code above the function

   * add a title

   * describe the inputs and the return value

   * include an example

2. Trigger creation of the documentation via `document()`

   * this will create a folder `man/` which houses automatically built documentation for your package

3. Test your documentation using `?strsplit1`

4. Examine the `NAMESPACE` file. You will see that `document()` added *export(strsplit1)* there.

   * this makes the function available to users of the package

   * note, you may want internal functions in your package which you don't make available to users

5. Double check that your package is all ok via `check()`

6. Now that we have a package that works, we can install it via `install()`

7. Restart your R session and do `library(regexcite)` to load the package

8. Test the package using:

   ```R
   x <- "alfa,bravo,charlie,delta"
   strsplit1(x, split = ",")
   ```

### Add unit tests

1. We've tested our function `strsplit1` informally, but we would like to do so systematically to ensure that: the function works as intended across more general examples; and the function continues to work when we develop the package. To do so, we are going to create unit tests. A first step in this process is to call `use_testthat()`.

2. Call `use_test("strsplit1")` to create a file which contains an example test. Try highlighting this code and running it interactively which will likely require another call to `load_all()` to make the `test_that()` function available.

3. In developing a package, you will more typically do `test()` to run all of your unit tests. Try this.
   * Note that tests are also run when `check()` is run

4. Write a `test_that` function which checks that `strsplit1` can split a string with comma separation

5. Write a different test that checks if `strsplit1` can split a string with hyphen separation

6. Try `test()` again to check that all unit tests pass

### Including dependencies

Suppose we want to use the `tibble` function from `dplyr` to store our split string in a dataframe with a column 'order' which specifies the position of each element in the string and another column 'string' which contains the splitted string. To do this, we will create a function called  `string_df(x, split)` that internally calls `tibble`.

1. Call `use_package("dplyr")` and note that this modifies the `DESCRIPTION` file to import this package for use

2. Call `use_r("string_df")` to create a blank `.R` file

3. Insert the following into the file:

```
string_df <- function(x, split) {
  x <- strsplit1(x, split)
  dplyr::tibble(
    order=seq_along(x),
    string=x
  )
}
```

4. Create documentation for this function.

5. Call `use_test()` from within the R file to create a test file, and add a unit test for `string_df`

6. Check that all is ok with the package (and the tests) by running `check()`

7. Try installing your package and running its functionality in a fresh R session

