# NLP Tokenisation Shiny App

This Shiny app allows users to input text and generate a word cloud using various tokenisation techniques and customization options, including word cloud shape, colour, scaling, and more.

## Features

- Input custom text and generate word clouds.
- Exclude specific stopwords (both common and custom-defined).
- Customize word cloud attributes like colour, scaling, and shape.
- Download the word cloud as PNG or JPEG.
- Explore the data further with bar chart and interactvie table views.

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/tokenisation-app.git
   ```

2. Install required libraries in R:
   ```R
   install.packages(c("shiny", "wordcloud2", "tm", "plotly", "dplyr", "shinyjs", "htmlwidgets"))
   ```

3. Run the app locally:
   ```R
   shiny::runApp()
   ```

## Deployment

The app is currently deployed and accessible [https://olivercareynhs.shinyapps.io/tokenisation_app/].

To deploy this app on [Shinyapps.io](https://www.shinyapps.io/):
   
1. Install the rsconnect package:
   ```R
   install.packages("rsconnect")
   ```

2. Use `rsconnect` to deploy the app:
   ```R
   library(rsconnect)
   rsconnect::deployApp()
   ```

## Screenshots
![image](https://github.com/user-attachments/assets/c7ad8c85-5971-45c2-b902-04fef653e44a)
![image](https://github.com/user-attachments/assets/8af81659-e95f-4f38-84d9-41b59910aa95)
![image](https://github.com/user-attachments/assets/4fd433f6-81af-45b7-9cf0-b19211ac56c9)
![image](https://github.com/user-attachments/assets/c60bfea0-f5fe-46f8-a1a2-374e89539d84)
![image](https://github.com/user-attachments/assets/0fb7ac80-bda3-4996-a00a-dc4fef182330)
![image](https://github.com/user-attachments/assets/0df89190-100b-4d03-918d-457ccd64706e)
![image](https://github.com/user-attachments/assets/29935dcb-c357-480c-a3dd-0c773f126982)
![image](https://github.com/user-attachments/assets/536bbd4e-f6a6-40c5-8a6b-d786b6da53a9)
![image](https://github.com/user-attachments/assets/2cf8cf2a-eb60-48a5-bf4b-86b29c5a7837)
![image](https://github.com/user-attachments/assets/3df52de6-2575-4736-ac29-31b19c39f059)



