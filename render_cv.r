# This script builds both the HTML and PDF versions of your CV

# %% Packages
install.packages("knitr")
install.packages("pagedown")
install.packages("rmarkdown")
install.packages("googlesheets4")
install.packages("stringr") # Needs icu64
install.packages("tidyr")
install.packages("dplyr")
install.packages("glue")
install.packages("purrr")
install.packages("languageserver")
install.packages("lubridate")
install.packages("readr")
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
