# Load common stopwords from a separate file
common_stopwords <- readLines("common_stopwords.txt")

# Define the Shiny server for Text Input
server_text <- function(input, output, session) {
  text_data <- eventReactive(input$generate_btn, {
    req(input$text_input)
    return(input$text_input)
  })
  
  custom_stopwords <- reactive({
    if (is.null(input$custom_stopwords) || input$custom_stopwords == "")
      character(0)
    else
      unlist(strsplit(input$custom_stopwords, ","))
  })
  
  # Define the preprocessing function
  preprocessing <- function(text) {
    text <- tolower(text)
    text <- gsub("[[:punct:]]", " ", text)  # Remove punctuation
    text <- gsub("\\d+", " ", text)  # Remove numbers
    text <- gsub("\\s+", " ", text)  # Remove extra spaces
    
    # Tokenize the text into words
    words <- unlist(strsplit(text, "\\s+"))
    
    # Remove custom stopwords if provided
    custom_stop <- custom_stopwords()
    if (length(custom_stop) > 0) {
      words <- words[!words %in% custom_stop]
    }
    
    words <- words[!words %in% common_stopwords]
    
    # Remove short words (less than 3 characters)
    words <- words[nchar(words) > 2]
    
    return(words)
  }
  
  # Tokenize the text and create word frequency table
  word_freq <- reactive({
    text <- preprocessing(text_data())
    word_freq <- table(text)
    word_freq_df <- data.frame(word = names(word_freq), freq = as.vector(word_freq))
    word_freq_df <- word_freq_df %>%
      arrange(desc(freq)) %>%
      head(input$top_words)
    return(word_freq_df)
  })
  
  # Generate word cloud
  output$wordcloud <- renderWordcloud2({
    word_freq_df <- word_freq()
    wordcloud2(word_freq_df, size = input$wordcloud_scale, color = input$wordcloud_colour,
               backgroundColor = input$background_colour, fontFamily = input$wordcloud_font,
               shape = input$wordcloud_shape)
  })
  
  # Generate bar chart
  output$bar_chart <- renderPlotly({
    word_freq_df <- word_freq()
    plot <- ggplot(word_freq_df, aes(x = reorder(word, -freq), y = freq)) +
      geom_bar(stat = "identity", fill = input$wordcloud_colour) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Top Word Frequencies", x = "Word", y = "Frequency")
    ggplotly(plot)
  })
  
  # Generate word frequency table
  output$wordfreq_table <- renderDataTable({
    word_freq_df <- word_freq()
    word_freq_df
  })
  
  # Download word frequency table
  output$download_wordfreq_table <- downloadHandler(
    filename = function() {
      paste("wordfreq_table_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(word_freq(), file, row.names = FALSE)
    }
  )
  
  # Download bar chart as JPEG
  output$download_barchart_jpeg <- downloadHandler(
    filename = function() {
      paste("barchart_", Sys.Date(), ".jpeg", sep = "")
    },
    content = function(file) {
      word_freq_df <- word_freq()
      plot <- ggplot(word_freq_df, aes(x = reorder(word, -freq), y = freq)) +
        geom_bar(stat = "identity", fill = input$wordcloud_colour) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Top Word Frequencies", x = "Word", y = "Frequency")
      ggsave(file, plot, device = "jpeg")
    }
  )
  
  # Download bar chart as PNG
  output$download_barchart_png <- downloadHandler(
    filename = function() {
      paste("barchart_", Sys.Date(), ".png", sep = "")
    },
    content = function(file) {
      word_freq_df <- word_freq()
      plot <- ggplot(word_freq_df, aes(x = reorder(word, -freq), y = freq)) +
        geom_bar(stat = "identity", fill = input$wordcloud_colour) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Top Word Frequencies", x = "Word", y = "Frequency")
      ggsave(file, plot, device = "png")
    }
  )
  
  # Download word cloud as JPEG
  output$download_wordcloud_jpeg <- downloadHandler(
    filename = function() {
      paste("wordcloud_", Sys.Date(), ".jpeg", sep = "")
    },
    content = function(file) {
      word_freq_df <- word_freq()
      wordcloud <- wordcloud2(word_freq_df, size = input$wordcloud_scale, color = input$wordcloud_colour,
                              backgroundColor = input$background_colour, fontFamily = input$wordcloud_font,
                              shape = input$wordcloud_shape)
      saveWidget(wordcloud, file, "jpeg", selfcontained = FALSE)
    }
  )
  
  # Download word cloud as PNG
  output$download_wordcloud_png <- downloadHandler(
    filename = function() {
      paste("wordcloud_", Sys.Date(), ".png", sep = "")
    },
    content = function(file) {
      word_freq_df <- word_freq()
      wordcloud <- wordcloud2(word_freq_df, size = input$wordcloud_scale, color = input$wordcloud_colour,
                              backgroundColor = input$background_colour, fontFamily = input$wordcloud_font,
                              shape = input$wordcloud_shape)
      saveWidget(wordcloud, file, "png", selfcontained = FALSE)
    }
  )
  
  # Clear text input
  observeEvent(input$clear_btn, {
    updateTextInput(session, "text_input", value = "")
  })
}
