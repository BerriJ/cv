# This script builds both the HTML and PDF versions of your CV

# %% Packages
library("knitr")
library("pagedown")
library("rmarkdown")
library("googlesheets4")
library("stringr") # Needs icu64
library("tidyr")
library("dplyr")
library("glue")
library("purrr")
library("languageserver")
library("lubridate")
library("readr")
# %%

# %% Knit the HTML version
rmarkdown::render("cv.rmd",
  params = list(pdf_mode = FALSE),
  output_file = "index.html"
)

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- "tmp/cv.html" # fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
  params = list(pdf_mode = TRUE),
  output_file = tmp_html_cv_loc
)


# Convert to PDF using Pagedown
pagedown::chrome_print(
  input = tmp_html_cv_loc,
  output = "berrisch_cv.pdf",
  extra_args = "--no-sandbox"
)
# %%
