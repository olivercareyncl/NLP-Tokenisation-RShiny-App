# Load required libraries
library(shiny)

# Load common stopwords from a separate file
common_stopwords <- readLines("common_stopwords.txt")

# Define the Shiny UI for Text Input
source("ui.R")

# Define the Shiny server for Text Input
source("server.R")

# Run the Shiny app for Text Input
shinyApp(ui = ui_text, server = server_text)
