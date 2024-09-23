# Load required libraries
library(shiny)
library(wordcloud2)
library(tm)
library(plotly)
library(dplyr)
library(shinyjs)
library(htmlwidgets)

# Set Shiny options
options(shiny.maxRequestSize = 9 * 1024 ^ 2)

# Define the Shiny UI for Text Input
ui_text <- fluidPage(
  h1("Word Cloud Shiny App"),
  
  # Create a layout with a sidebar panel and a main panel
  sidebarLayout(
    sidebarPanel(
      # Multiline text input
      tags$textarea(id = "text_input", rows = 10, placeholder = "Enter Text"),
      
      # Action button to generate word cloud
      actionButton("generate_btn", "Generate Word Cloud", icon = icon("cloud")),
      
      # Action button to erase text
      actionButton("clear_btn", "Clear Text", icon = icon("eraser")),
      
      # User-defined words to remove
      textInput("custom_stopwords", "Exclude Words (comma-separated)"),
      
      # Numeric input for top word count
      numericInput("top_words", "Top Words to Display", 20),
      
      # Slider input to adjust word cloud scaling
      sliderInput("wordcloud_scale", "Adjust Word Cloud Scaling:",
                  min = 0.1, max = 3, value = 0.4, step = 0.05),
      
      # Select input for word cloud color
      selectInput("wordcloud_colour", "Word Cloud Colour", c(
        "Azul" = "#016BBD", "White" = "white", "Tekhelet" = "#502E7C",
        "Mexican Pink" = "#DB1482", "Kelly Green" = "#6AB33D",
        "Carrot Orange" = "#F38E22", "Aureolin" = "#FCEB05"
      )),
      
      # Select input for background color
      selectInput("background_colour", "Choose Background Colour", c(
        "White" = "white", "Black" = "black", "Grey" = "grey", "Azul" = "#016BBD"
      )),
      
      # Select input for word cloud font
      selectInput("wordcloud_font", "Word Cloud font", c("Helvetica", "Arial", "Times New Roman")),
      
      # Select input for word cloud shape
      selectInput("wordcloud_shape", "Word Cloud Shape", c("circle", "square", "diamond")),
      
      # Download buttons for various outputs
      downloadButton("download_wordfreq_table", "Download Word Frequency Table (CSV)"),
      downloadButton("download_barchart_jpeg", "Download Bar Chart (JPEG)"),
      downloadButton("download_barchart_png", "Download Bar Chart (PNG)"),
      downloadButton("download_wordcloud_jpeg", "Download Word Cloud (JPEG)"),
      downloadButton("download_wordcloud_png", "Download Word Cloud (PNG)"),
    ),
    
    mainPanel(
      # Create a tabset panel with multiple tabs
      tabsetPanel(
        tabPanel("About",
                 h3("About this app:"),
                 
                 # About text
                 p("This Shiny App is designed to generate word clouds, bar charts, and display word frequencies from text data."),
                 
                 h3("How to Use:"),
                 
                 # Usage instructions
                 tags$ol(
                   tags$li("Enter or paste text data into the text area."),
                   tags$li("Exclude specific words by entering them as comma-separated values in the 'Exclude Words' input."),
                   tags$li("Select desired options for word cloud generation, including colour, background, font, and shape."),
                   tags$li("Click the 'Generate Word Cloud' button to create a word cloud and view it."),
                   tags$li("Explore the 'Word Frequency Table' and 'Bar Chart' tabs for additional insights."),
                   tags$li("You can also download the generated word frequency table, bar chart using the provided download buttons. (To export word cloud please take a screenshot - Download currently not supported)")
                 ),
                 
                 h3("Author:"),
                 p("Oliver Carey - NECS100 Graduate")
        ),
        
        tabPanel("Word Cloud", wordcloud2Output("wordcloud")),
        tabPanel("Bar Chart", plotlyOutput("bar_chart")),
        tabPanel("Word Frequency Table", dataTableOutput("wordfreq_table"))
      )
    )
  )
)
