# This script builds both the HTML and PDF versions of your CV

# Knit the HTML version
rmarkdown::render("cv.rmd",
    params = list(pdf_mode = FALSE),
    output_file = "index.html"
)

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
    params = list(pdf_mode = TRUE),
    output_file = tmp_html_cv_loc
)

# To install chrome:
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# dpkg -i google-chrome-stable_current_amd64.deb

# To fix dependencies:
# apt-get update
# apt-get install -f

# Convert to PDF using Pagedown
pagedown::chrome_print(
    input = tmp_html_cv_loc,
    output = "berrisch_cv.pdf",
    extra_args = "--no-sandbox"
)